namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.exclude_pattern = "spec/integration/**/*_spec.rb"
  end

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/integration/**/*_spec.rb"
  end
end
