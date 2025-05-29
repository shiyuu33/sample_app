#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

bundle exec rails runner "ActiveRecord::Base.connection_pool.disconnect!" 2>/dev/null || true
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:reset
bundle exec rails db:seed
