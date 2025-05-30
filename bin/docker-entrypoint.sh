#!/bin/bash
set -e

# Run database migrations and seed if DATABASE_URL is set
if [ -n "$DATABASE_URL" ]; then
  echo "Running database migrations..."
  bundle exec rails db:migrate
  echo "Checking database seed..."
  bundle exec rails runner "User.exists? || load('db/seeds.rb')"
fi

# Then execute container's main command
exec "$@"
