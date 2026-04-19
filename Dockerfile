# syntax=docker/dockerfile:1
FROM ruby:3.2-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install gems first (layer caching)
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Copy app code
COPY . .

# Precompile assets (skip for API-only apps)
# RUN bundle exec rails assets:precompile RAILS_ENV=production

# Expose port
EXPOSE 3000

# Start server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
