#!/usr/bin/env sh

set -e
set -x

env="RAILS_ENV=test"

export DISPLAY=:99.0

bundle exec rake iqvoc:setup:generate_secret_token $env
bundle exec rake db:drop $env
bundle exec rake db:create $env
bundle exec rake db:migrate $env
bundle exec rake test  $env
