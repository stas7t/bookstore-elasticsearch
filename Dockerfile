FROM ruby:2.5.1-slim

RUN apt-get update -qq && apt-get install -y \
 build-essential libpq-dev libxml2-dev libxslt1-dev imagemagick apt-transport-https curl nano

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
 apt-get update && apt-get install -y yarn

ENV RAILS_ENV=development
ENV APP_HOME /bookstore_elasticsearch_app
RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile Gemfile.lock ./

RUN bundle check || bundle install

ADD package.json yarn.lock ./

RUN yarn install

COPY . .

# RUN bin/rails assets:precompile

# CMD bundle exec puma -C config/puma.rb
