if Rails.env.test?
  Chewy.settings = {
    host: 'localhost:9250',
    prefix: 'test',
  }
elsif Rails.env.development?
  Chewy.settings = {
    host: 'localhost:9200',
    prefix: 'development',
  }
end
