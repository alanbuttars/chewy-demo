load './spec/spec_helper.rb'

Dir['./db/seeds/*.rb'].sort.each do |file|
  puts file
  require file
end
