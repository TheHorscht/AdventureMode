$noitaExe = "C:\Program Files (x86)\Steam\steamapps\common\Noita\Noita.exe"
$spliceOutputFolder = "C:\Program Files (x86)\Steam\steamapps\common\Noita\data\biome_impl\spliced"
$pixelScenesFolder = "D:\Projekte\NoitaMods\AdventureMode\files\pixel_scenes"
$pixelScenesModsFolder = "mods/AdventureMode/files/pixel_scenes/"
$pixelSceneName = "pyramid_entrance_full"

$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "$noitaExe"
$pinfo.WorkingDirectory = "C:\Program Files (x86)\Steam\steamapps\common\Noita\"
$pinfo.Arguments = "-splice_pixel_scene $pixelScenesModsFolder$pixelSceneName.png -x 512 -y -1536 -debug 0"
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.UseShellExecute = $false
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start() | Out-Null
$p.WaitForExit()
$stdout = $p.StandardOutput.ReadToEnd()
$stderr = $p.StandardError.ReadToEnd()
Write-Host "stdout: $stdout"
Write-Host "stderr: $stderr"
Write-Host "exit code: " + $p.ExitCode

# & $noitaExe -splice_pixel_scene "$pixelScenesModsFolder$pixelSceneName.png" -x 512 -y -1536 -debug 0
# Exit
Copy-Item -Path "$spliceOutputFolder\$pixelSceneName.xml" -Destination $pixelScenesFolder -Force
Copy-Item -Path "$spliceOutputFolder\$pixelSceneName\*" -Destination "$pixelScenesFolder\$pixelSceneName" -Force

$xmlPath = "$pixelScenesFolder\$pixelSceneName.xml"
((Get-Content -path $xmlPath -Raw) -replace "data/biome_impl/spliced/", $pixelScenesModsFolder) | Set-Content -Path $xmlPath
