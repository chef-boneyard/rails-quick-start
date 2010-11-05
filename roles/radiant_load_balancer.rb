name "radiant_load_balancer"
description "radiant load balancer"
run_list(
  "recipe[haproxy::app_lb]"
)
override_attributes(
  "haproxy" => {
    "app_server_role" => "radiant"
  }
)
