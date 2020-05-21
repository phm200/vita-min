# vita-min

Vita-Min is a Rails app that helps people access the VITA program through a digital intake form, a "valet" drop-off workflow using Zendesk, and a national landing page to find the nearest VITA site.

## Setup

```bash
# 1. Install Ruby using your preferred installation method. For example, to
# install it with rbenv:
brew install rbenv
rbenv install

# 2. Install postgresql using your preferred installation method. You'll need
# the PostGIS extension as well.
brew install postgresql postgis

# 3. Install bundler & system dependencies
gem install bundler
rbenv rehash
bundle install
brew install imagemagick poppler ghostscript

# 4. Install PDFtk
# Download from: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg

# 5. Get the secret key from LastPass / someone who has it set up.
echo "[secret key]" > config/master.key

# 6. Install ClamAV
brew install clamav

# you may want to add /usr/local/sbin to your path at this point
# setup instructions at http://make.a.gist.about.this
```

The directory `/usr/local/sbin` needs to exist for the installation 
to be successful.

If you're on an older initial install of brew, your /usr/local
directory won't be owned by you, it'll be owned by root. It's also 
possible that you won't be able to change the ownership of that 
directory due to MacOS controls against changing system directories.

Team Hard Way instructions:
```
mkdir /usr/local/sbin
sudo chown YourUserName:YourGroup /usr/local/sbin

```

After installing `clamav`, copy the example config files:

```
cp /usr/local/etc/clamav/clamd.conf.example /usr/local/etc/clamav/clamd.conf
cp /usr/local/etc/clamav/freshclam.conf.example /usr/local/etc/clamav/freshclam.conf
```

TODO: add plist for great justice

TODO: write linux service file if deploying broadly

   apt-get install openssl libssl-dev libcurl4-openssl-dev zlib1g-dev libpng-dev libxml2-dev libjson-c-dev libbz2-dev libpcre3-dev ncurses-dev libmspack0 libtfm1
   wget http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav-freshclam_0.102.2+dfsg-0+deb10u1_amd64.deb
   wget http://ftp.mx.debian.org/debian/pool/main/c/clamav/libclamav9_0.102.2+dfsg-0+deb10u1_amd64.deb
   wget http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav-daemon_0.102.2+dfsg-0+deb10u1_amd64.deb
   wget http://ftp.mx.debian.org/debian/pool/main/c/clamav/clamav_0.102.2+dfsg-0+deb10u1_amd64.deb

   dpkg -i libclamav9_0.102.2+dfsg-0+deb10u1_amd64.deb
   dpkg -i clamav-freshclam_0.102.2+dfsg-0+deb10u1_amd64.deb
   dpkg -i clamav_0.102.2+dfsg-0+deb10u1_amd64.deb
   dpkg -i clamav-daemon_0.102.2+dfsg-0+deb10u1_amd64.deb
   update-rc.d clamav-daemon enable
   update-rc.d clamav-freshclam enable
   service clamav-daemon start
   service clamav-freshclam start

## Running background jobs in development

In development, you'll need to manually start the delayed_job worker using the following command:

```shell
rails jobs:work
```

## Run some tests!

The `[options]` and `[path]` are optional.

To run the test suite:

`bundle exec rspec [options] [path]`

To run only the failing tests:

`bundle exec rspec --only-failures`

To run the tests with coverage (path not recommended):

`COVERAGE=y bundle exec rspec [options]`

To run the test suite continuously:

`bundle exec guard`

## Tidy Up!

This repo has `rubocop` installed. To check:

`rubocop [app lib ...]`

The rubocop settings files is in the root directory as `.rubocop.yml`

### Integration with RubyMine

RubyMine integrates Rubocop by default. Settings can be found in the Preferences
menu, under Editor > Inspections > Ruby > Gems and Gem Management > Rubocop.

## Environments

## Deploying the Application

Notes on deployment (and tagged release) can be found in
[doc/environments-and-deployment.md](doc/environments-and-deployment.md).



