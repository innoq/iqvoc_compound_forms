source 'https://rubygems.org'

gem 'iqvoc', '~> 4.12', :github => 'innoq/iqvoc', branch: 'master'
gem 'iqvoc_skosxl', '~> 2.9.0', :github => 'innoq/iqvoc_skosxl', branch: 'master'

group :development, :test do
  gem 'pry-rails'

  group :test do
    gem 'capybara', '~> 2.2.1'
    gem 'poltergeist', '~> 1.5.0'
  end

  platforms :ruby do
    gem 'mysql2'
    gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
  end
end
