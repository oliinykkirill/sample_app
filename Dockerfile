FROM ruby:2.7.5-bullseye

# Install official Node.js 14 and Yarn
# (curl, tar, xz, build-essential and libpq-dev are already pre-installed in the ruby:2.7.5 base image)
RUN curl -fsSL https://nodejs.org/dist/v14.21.3/node-v14.21.3-linux-x64.tar.xz | tar -xJf - -C /usr/local --strip-components=1 && \
    npm install -g yarn@1.22.19

WORKDIR /app

ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true \
    PORT=10000

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.2.25 && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Install Node modules
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy the rest of the application
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE=dummy_asset_precompile_key bundle exec rails assets:precompile

# Ensure scripts in bin/ are executable
RUN chmod +x bin/*

EXPOSE 10000

ENTRYPOINT ["/app/bin/docker-entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
