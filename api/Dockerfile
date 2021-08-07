FROM ruby:3.0.1

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev

RUN gem install bundler:2.2.19

RUN bundle install

ADD . /app
