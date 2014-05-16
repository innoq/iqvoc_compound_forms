source 'https://rubygems.org'

gem 'iqvoc', '~> 4.4.0', :github => 'innoq/iqvoc'
gem 'iqvoc_skosxl', '~> 2.4.0', :github => 'innoq/iqvoc_skosxl'

group :development, :test do
  gem 'spring'
  gem 'pry-rails'
  gem 'awesome_print'

  platforms :ruby do
    gem 'mysql2'
    gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
  end
end
