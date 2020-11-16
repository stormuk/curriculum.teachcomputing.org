FROM ruby:2.6.6-alpine
RUN apk --no-cache add build-base curl postgresql-dev tzdata nodejs chromium chromium-chromedriver yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY package.json yarn.lock ./
RUN yarn install
COPY . /app
CMD ./scripts/docker-entrypoint.sh
