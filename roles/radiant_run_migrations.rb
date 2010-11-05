name "radiant_run_migrations"
description "Run db:migrate on demand for radiant"
override_attributes( "apps" => { "radiant" => { "production" => { "run_migrations" => true } } })
