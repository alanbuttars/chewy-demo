Chewy Demo
=====

The <a href="https://github.com/toptal/chewy">chewy gem</a> is an excellent framework that enables simple integration with the equally fantastic <a href="https://github.com/elastic/elasticsearch-ruby">elasticsearch-ruby gem</a>.

This demo project is a simple demonstration of how the `chewy` gem can operate within a Rails project using a PostgreSQL.

## Installation

These instructions are for Ubuntu 16.04 LTS, but will be roughly similar for other Linux distributions and Mac.

1. Install RVM (https://rvm.io/rvm/install)
```
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

2. Install PostgreSQL and create credentials (http://postgresguide.com/setup/install.html)
```
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib libpq-dev

sudo -u postgres createuser -s chewy_demo
sudo -u postgres psql
\password chewy_demo
# Enter 'chewy_demo_password' at the prompt
\q
```

3. Install elasticsearch (https://www.elastic.co/guide/en/elasticsearch/guide/master/running-elasticsearch.html)
```
curl -O "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.1.tar.gz"
tar -zxf elasticsearch-5.5.1.tar.gz
rm -f elasticsearch-5.5.1.tar.gz
sudo elasticsearch-5.5.1/bin/elasticsearch-plugin install analysis-phonetic
```

4. Download code source
```
git clone https://github.com/alanbuttars/chewy-demo.git
```

5. Run the application
```
cd /path/to/chewy-demo
gem install bundler
bundle install

rake elasticsearch:go
rake db:go

rails server
```
