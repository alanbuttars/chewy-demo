namespace :db do
  desc "Establish schema and seed database"
  task :go => %w[db:schema db:seed]

  desc "Establish schema"
  task :schema => %w[db:kill db:drop db:create db:migrate chewy:reset]

  desc "Kill existing database connections"
  task :kill do
    begin
      config = ActiveRecord::Base.configurations[Rails.env]
      ActiveRecord::Base.establish_connection(config)
      pid = ActiveRecord::Base.connection.raw_connection.backend_pid
      ActiveRecord::Base.connection.execute("select pg_terminate_backend(pid) from pg_stat_activity where pid <> #{pid} and datname = current_database()")
    rescue => e
      raise unless e.message =~ /database is not configured/
    end
  end
end
