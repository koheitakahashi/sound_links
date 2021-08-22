FROM node:14.3

WORKDIR /app

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update -y && \
  apt-get upgrade -y && \
  npm install core-js-pure@3.16.0 && \
  npm install @vue/cli@next && \
  yarn install

RUN npm rebuild node-sass

ADD . /app

RUN yarn build

EXPOSE 8080

CMD ["yarn", "serve:production"]
