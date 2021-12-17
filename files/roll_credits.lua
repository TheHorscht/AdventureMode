local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

if x > 400 and not loaded_credits then
  loaded_credits = true
  GameAddFlagRun("ending_game_completed")
  EntityLoad("mods/AdventureMode/files/fake_credits.xml")
end

if x > 500 and not killed_player then
  killed_player = true
  GameOnCompleted()
  EntityKill(entity_id)
end
