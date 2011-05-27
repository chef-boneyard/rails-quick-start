name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[users::sysadmins]",
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[ruby]"
)
