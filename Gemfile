source 'https://rubygems.org'

gem 'iqvoc', '~> 4.3.0', :github => 'innoq/iqvoc'
gem 'iqvoc_skosxl', '~> 2.3.0', :github => 'innoq/iqvoc_skosxl'

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
