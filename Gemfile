source "http://rubygems.org"

gem 'rails', '~> 3.2.13'
gem 'iqvoc', :git => 'git://github.com/innoq/iqvoc.git'
gem 'iqvoc_skosxl', :git => 'git://github.com/innoq/iqvoc_skosxl.git'

group :development, :test do
  platforms :ruby do
    gem 'mysql2'
    gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
  end
end
