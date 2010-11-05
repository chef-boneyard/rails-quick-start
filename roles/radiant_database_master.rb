name "blog_database_master"
description "Database master for the blog application."
run_list(
  "recipe[database::master]"
)
