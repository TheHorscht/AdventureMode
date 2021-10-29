#! /usr/bin/env python

# GIMP script to crop, export and splice pixel scenes
# Written for GIMP 2.10.14
# Use at your own risk :)
# Prefix your layers with (V), (B) or (M) to mark them as visual, background or materials for exporting
# all other layers will be ignored, no need to manually toggle their visibility
# This plugin will:
# 1. Split your image into 3072x3072 chunks
# 2. Export filename.png, filename_visual.png, filename_background.png
# 3. Run those through Noita -splice_pixel_scene
# 4. Replace the path in the generated XML with the path to your pixel scenes in your mod folder
# After this you will still need to insert your pixel scene XMLs to your _pixel_scenes.xml

from gimpfu import *
from shutil import copyfile
from shutil import rmtree
from distutils.dir_util import copy_tree
import subprocess
import sys
import os
import re
import math

def turn_layers_on(img, type):
  layers = []
  for layer in img.layers:
    was_visible = pdb.gimp_item_get_visible(layer)
    pdb.gimp_item_set_visible(layer, 1 if layer.name.lower().startswith("("+type+")") else 0)
    layers.append((layer, was_visible))
  return layers

# This will export one type (visual, background, materials) of file for all chunks
# So you might end up with:
# - filename_0_0_visual.png
# - filename_1_0_visual.png
# - filename_0_1_visual.png
# - filename_1_1_visual.png
def export_layers(img, type, chunk_size, path, filename):
  num_chunks_x = math.floor(img.width / chunk_size)
  num_chunks_x_rest = img.width % chunk_size
  num_chunks_y = math.floor(img.height / chunk_size)
  num_chunks_y_rest = img.height % chunk_size
  do_x_times = int(num_chunks_x + (1 if num_chunks_x_rest > 0 else 0))
  do_y_times = int(num_chunks_y + (1 if num_chunks_y_rest > 0 else 0))
  for y in range(do_y_times):
    for x in range(do_x_times):
      new_image = pdb.gimp_image_duplicate(img)
      turn_layers_on(new_image, type[0])
      layer = pdb.gimp_image_merge_visible_layers(new_image, CLIP_TO_IMAGE)
      has_visible_layer = False
      for layer in new_image.layers:
        if pdb.gimp_item_get_visible(layer) == 1:
          has_visible_layer = True
          break
      if not has_visible_layer:
        new_layer = pdb.gimp_layer_new_from_drawable(layer, new_image)
        pdb.gimp_item_set_visible(new_layer, 1)
        pdb.gimp_image_insert_layer(new_image, new_layer, None, 10000)
        pdb.gimp_selection_all(new_image)
        pdb.gimp_edit_clear(new_layer)
        layer = new_layer
      size_x = num_chunks_x_rest if (x+1) == do_x_times and num_chunks_x_rest > 0 else chunk_size
      size_y = num_chunks_y_rest if (y+1) == do_y_times and num_chunks_y_rest > 0 else chunk_size
      pdb.gimp_image_crop(new_image, size_x, size_y, x * chunk_size, y * chunk_size)
      save_to_filename = path + filename + "_" + str(x) + "_" + str(y) + type[1] + ".png"
      print("Saving " + save_to_filename)
      pdb.file_png_save(new_image, layer, save_to_filename, save_to_filename, 0, 9, 0, 0, 1, 1, 0)
      pdb.gimp_image_delete(new_image)

def export_noita_pixelscene(img, layer, start_x, start_y, noita_path, output_path, filename, pixel_scenes_mods_folder):
  if filename == "":
    pdb.gimp_message("Filename cannot be empty")
    return False
  filename = os.path.splitext(filename)[0]

  chunk_size = 3072
  pixel_scenes_mods_folder_TEMP = "mods/__GIMP_PLUGIN_TEMP__/"
  splice_output_folder = noita_path + "\\data\\biome_impl\\spliced"
  pixel_png_output_path = noita_path + "\\" + pixel_scenes_mods_folder_TEMP # This is where we need to export our png to
  num_chunks_x = math.floor(img.width / chunk_size)
  num_chunks_x_rest = img.width % chunk_size
  num_chunks_y = math.floor(img.height / chunk_size)
  num_chunks_y_rest = img.height % chunk_size
  do_x_times = int(num_chunks_x + (1 if num_chunks_x_rest > 0 else 0))
  do_y_times = int(num_chunks_y + (1 if num_chunks_y_rest > 0 else 0))
  # Create directory or do nothing if it already exists
  full_temp_mod_path = noita_path + "/" + pixel_scenes_mods_folder_TEMP
  if not os.path.exists(full_temp_mod_path):
    print("Creating directory " + full_temp_mod_path)
    os.makedirs(full_temp_mod_path)
  # Export the cropped PNGs
  for type in [("v", "_visual"), ("b", "_background"), ("m", "")]:
    export_layers(img, type, chunk_size, pixel_png_output_path, filename)

  print("Splicing pixel scenes: ")

  for y in range(do_y_times):
    for x in range(do_x_times):
      tmp_filename = filename + "_" + str(x) + "_" + str(y)
      x_offset = start_x + chunk_size * x
      y_offset = start_y + chunk_size * y
      # Tell Noita to splice the pixel scenes for us
      print("-splice_pixel_scene " +  pixel_scenes_mods_folder_TEMP + tmp_filename + ".png -x " + str(x_offset) + " -y " + str(y_offset) + " -debug 0")
      p = subprocess.Popen([noita_path + "\\Noita.exe", "-splice_pixel_scene", pixel_scenes_mods_folder_TEMP + tmp_filename + ".png", "-x", str(x_offset), "-y", str(y_offset), "-debug 0"], stdout=sys.stdout, cwd=noita_path)
      p.communicate()

      print("copyfile(" + splice_output_folder + "\\" + tmp_filename + ".xml, " + output_path + "\\" + tmp_filename + ".xml)")
      copyfile(splice_output_folder + "\\" + tmp_filename + ".xml", output_path + "\\" + tmp_filename + ".xml")
      print("copy_tree(" + splice_output_folder + "\\" + tmp_filename + "," + output_path + "\\" + tmp_filename + ")")
      copy_tree(splice_output_folder + "\\" + tmp_filename, output_path + "\\" + tmp_filename)

      # Replace the paths in the XML Noita spat out for us
      with open(output_path + "\\" + tmp_filename + ".xml", "r+") as f:
        text = f.read()
        text = re.sub("data/biome_impl/spliced/", pixel_scenes_mods_folder, text)
        f.seek(0)
        f.write(text)
        f.truncate()
  rmtree(full_temp_mod_path)
  return

register(
  "export_noita_pixelscene",
  "Export pixelscene",
  "Exports pixelscenes for Noita",
  "Horscht",
  "Horscht",
  "2021",
  "<Image>/File/Export pixelscene",
  "*",
  [
    (PF_INT, "start_x", "Start X", 512),
    (PF_INT, "start_y", "Start Y", -3072),
    (PF_DIRNAME, "noita_path", "Noita Path", "C:/Program Files (x86)/Steam/steamapps/common/Noita"),
    (PF_DIRNAME, "output_path", "Ouput Path", "D:/Projekte/NoitaMods/AdventureMode/files/pixel_scenes"),
    (PF_STRING, "filename", "Filename", "world"),
    (PF_STRING, "pixel_scenes_mods_folder", "Path to pixel scene in your mod", "mods/AdventureMode/files/pixel_scenes/"),
  ],
  [],
  export_noita_pixelscene
  )
main()
