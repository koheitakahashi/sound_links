FROM ruby:3.0.3

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  sudo nginx && \
    # NOTE:build時に libffi.so.6: cannot open shared object file: no such file or directory - /usr/local/bundle/gems/ffi-1.15.4/lib/ffi_c.so (loaderror) のエラーが発生した。 \
    #  そのため、以下のinstallとuninstallをしている。 \
    #  ref: https://github.com/ffi/ffi/issues/881#issuecomment-903958514
  gem uninstall ffi \
  gem install ffi -- --enable-system-libffi \
  bundle config build.ffi --enable-system-libffi \
  bundle add ffi \
  gem install bundler:2.2.19

RUN bundle install

ADD . /app
RUN mkdir -p tmp/sockets
RUN mkdir tmp/pids

RUN groupadd nginx
RUN useradd -g nginx nginx
ADD nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 3000

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
