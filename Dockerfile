FROM ruby:2.5.1-slim

USER root

RUN apt-get update -qq && apt-get install -y \
 build-essential libpq-dev libxml2-dev libxslt1-dev imagemagick apt-transport-https curl nano

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
 apt-get update && apt-get install -y yarn

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/bookstore-elasticsearch

RUN useradd -m -d $APP_USER_HOME $APP_USER

RUN mkdir /var/www && \
 chown -R $APP_USER:$APP_USER /var/www && \
 chown -R $APP_USER $APP_USER_HOME

WORKDIR $APP_HOME

USER $APP_USER

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

COPY . .

USER root

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER

RUN bin/rails assets:precompile

CMD bundle exec puma -C config/puma.rb
