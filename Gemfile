source "http://rubygems.org"

gem 'rails',        '~> 3.2.2'
gem 'iqvoc',        '~> 3.5.1'#, :path => '../iqvoc'
gem 'iqvoc_skosxl', '~> 1.2.0'#, :path => '../iqvoc_skosxl'

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

group :test do
  gem 'test-unit'
  gem 'spork'
  gem 'spork-testunit'
end
