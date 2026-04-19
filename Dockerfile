 FROM ruby:3.4-slim

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]