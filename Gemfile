source 'https://rubygems.org'

gem 'iqvoc', '~> 4.14.4', github: 'innoq/iqvoc', branch: :main
gem 'iqvoc_skosxl', '~> 2.11.3', github: 'innoq/iqvoc_skosxl', branch: :main

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
    gem 'pg'
  end
  platforms :jruby do
    gem 'activerecord-jdbcpostgresql-adapter'
  end
end
