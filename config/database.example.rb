postgresql_settings: &postgresql_settings
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: postgres
  password: T2EQHewQ
  host: xx.xx.xx.xx
  database: recruitment_production

development:
  <<: *postgresql_settings

production:
  <<: *postgresql_settings
