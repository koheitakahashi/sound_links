FROM node:14.3

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /app
WORKDIR /app

ADD package.json /app/package.json
ADD yarn.lock /app/yarn.lock

RUN apt-get update -y && \
  apt-get upgrade -y && \
  yarn add core-js-pure@3.16.0 && \
  yarn add @vue/cli@next && \
  yarn install

ADD . /app

RUN yarn build

EXPOSE 8080

CMD ["yarn", "serve:production"]
