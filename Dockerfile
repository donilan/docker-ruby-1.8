FROM ubuntu:14.04
MAINTAINER Doni <doni.leong@gmail.com>

#Install Ruby 1.8

ENV BUILD_PACKAGES="bash curl tzdata ca-certificates wget less ssh autoconf bison " \
    DEV_PACKAGES="ruby1.8 ruby1.8-dev rubygems1.8 libc-dev libffi-dev libmysqlclient-dev libsqlite3-dev libxml2-dev libxslt-dev libgmp3-dev libgdbm3 libgdbm-dev libmysqlclient-dev libncurses5-dev libreadline-dev  libssl-dev libyaml-dev zlib1g-dev software-properties-common" \
    RUBY_PACKAGES="git openssl" \
    APP=/app

RUN set -ex \
    && apt-get update \
    && apt-get -y install software-properties-common \
    && add-apt-repository -y ppa:brightbox/ruby-ng \
    && apt-get update \
    && apt-get install -qq -y --force-yes build-essential --fix-missing --no-install-recommends \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES \
    && mkdir -p "$APP" \
    && echo 'gem: --no-document' > /usr/local/etc/gemrc \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR $APP

RUN gem update && gem install bundler

EXPOSE 3000
