source 'https://rubygems.org'

gem 'iqvoc', '~> 4.12', :github => 'innoq/iqvoc', branch: 'master'
gem 'iqvoc_skosxl', '~> 2.9.0', :github => 'innoq/iqvoc_skosxl', branch: 'master'

group :development do
  gem 'better_errors'
  gem 'web-console'
  gem 'listen'
end

group :development, :test do
  gem 'pry-rails'

  group :test do
    gem 'capybara'
    gem 'poltergeist'
  end

  platforms :ruby do
    gem 'pg', '~> 0.21'
    #gem 'mysql2'
    #gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcpostgresql-adapter'
    #gem 'activerecord-jdbcmysql-adapter'
    #gem 'activerecord-jdbcsqlite3-adapter'
  end
end
