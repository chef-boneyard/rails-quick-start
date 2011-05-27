name "radiant"
description "radiant front end application server."
run_list(
  "recipe[mysql::client]",
  "recipe[application]",
  "recipe[radiant::status]"
)
