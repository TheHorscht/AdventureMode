local entity_id = GetUpdatedEntityID()
one()
function one()
  print("entity_id one(): " .. entity_id)
end
function two()
  print("entity_id two(): " .. entity_id)
end
two()
