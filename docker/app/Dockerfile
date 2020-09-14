FROM ruby:2.7.1

# install rails dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm
RUN apt remove -y cmdtest && apt remove -y yarn
RUN npm install -g yarn

ENV APP_HOME /var/www/application
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN bundle install
RUN yarn install

COPY . $APP_HOME/

EXPOSE 3000
