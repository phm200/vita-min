FROM ruby:2.6.5

# System prerequisites
RUN apt-get update \
 && apt-get -y install build-essential libpq-dev pdftk ghostscript poppler-utils

# ClamAV dependencies
RUN apt-get -y install openssl libssl-dev libcurl4-openssl-dev zlib1g-dev libpng-dev libxml2-dev libjson-c-dev libbz2-dev libpcre3-dev ncurses-dev libmspack0 libtfm1 logrotate

# ClamAV installation
RUN wget -q -O /tmp/clamav-freshclam.deb http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav-freshclam_0.102.2+dfsg-0+deb10u1_amd64.deb \
 && wget -q -O /tmp/libclamav9.deb http://ftp.mx.debian.org/debian/pool/main/c/clamav/libclamav9_0.102.2+dfsg-0+deb10u1_amd64.deb \
 && wget -q -O /tmp/clamav-base.deb http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav-base_0.102.2+dfsg-0+deb10u1_all.deb \
 && wget -q -O /tmp/clamav-daemon.deb http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav-daemon_0.102.2+dfsg-0+deb10u1_amd64.deb \
 && wget -q -O /tmp/clamav.deb http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav_0.102.2+dfsg-0+deb10u1_amd64.deb \
 && dpkg -i /tmp/libclamav9.deb /tmp/clamav-base.deb /tmp/clamav-freshclam.deb /tmp/clamav-daemon.deb /tmp/clamav.deb \
 && update-rc.d clamav-freshclam enable && service clamav-freshclam start \
 && update-rc.d clamav-daemon enable && service clamav-daemon start

# TODO: yank these when install is good
# dpkg -i libclamav9_0.102.2+dfsg-0+deb10u1_amd64.deb
# dpkg -i clamav-freshclam_0.102.2+dfsg-0+deb10u1_amd64.deb
# dpkg -i clamav_0.102.2+dfsg-0+deb10u1_amd64.deb
# dpkg -i clamav-daemon_0.102.2+dfsg-0+deb10u1_amd64.deb

# ClamAV service setup

# Cleanup apt/lists/*
RUN rm -rf /var/lib/apt/lists/*

# If you require additional OS dependencies, install them here:
# RUN apt-get update \
#  && apt-get -y install imagemagick nodejs \
#  && rm -rf /var/lib/apt/lists/*

ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app
RUN bundle install

ADD . /app

# Collect assets. This approach is not fully production-ready, but
# will help you experiment with Aptible Deploy before bothering with assets.
# Review http://go.aptible.com/assets for production-ready advice.
RUN set -a \
 && . ./.aptible.env \
 && bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
