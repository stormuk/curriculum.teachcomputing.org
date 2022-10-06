FROM ruby:3.1.2-alpine
RUN apk --no-cache add build-base curl postgresql-dev tzdata nodejs chromium chromium-chromedriver yarn
RUN mkdir /app
WORKDIR /app
