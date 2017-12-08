ELASTICSEARCH_PID_FILE = "/tmp/chewy_demo_elasticsearch.pid"

namespace :elasticsearch do
  desc "Safely start elasticsearch"
  task :go => %w[elasticsearch:kill elasticsearch:start]

  desc "Start elasticsearch"
  task :start do
    elasticsearch_home = ENV["ELASTICSEARCH_HOME"]
    raise "Please set ELASTICSEARCH_HOME environment variable" if elasticsearch_home.nil?
    system("sh #{elasticsearch_home}/bin/elasticsearch -d -p #{ELASTICSEARCH_PID_FILE}")
  end

  desc "Kill existing elasticsearch"
  task :kill do
    next unless File.exists?(ELASTICSEARCH_PID_FILE)
    lines = File.readlines(ELASTICSEARCH_PID_FILE)
    next unless lines.size == 1
    pid = lines.first
    system("kill -9 #{pid}")
  end
end
