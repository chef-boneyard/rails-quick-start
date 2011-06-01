name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[zsh]",
  "recipe[users::sysadmins]",
  "recipe[sudo]"
)
override_attributes(
  :authorization => {
    :sudo => {
      :users => ["ubuntu"],
      :passwordless => true
    }
  }
)

