name "radiant_database_master"
description "Database master for the radiant application."
run_list(
  "recipe[database::master]"
)
