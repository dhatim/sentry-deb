#!/bin/bash -ex

chmod 755 /wd /wd/pkg/build-pkg.sh

# need some packages from backports
echo "deb http://deb.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
mv /wd/pkg/backports_preferences /etc/apt/preferences.d
apt-get update

apt-get install --assume-yes python curl
curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python /tmp/get-pip.py
rm /tmp/get-pip.py

apt-get install --assume-yes --no-install-recommends python-dev dh-virtualenv gcc-multilib clang cmake libxml2-dev libxslt-dev libpq-dev libffi-dev libjpeg62-turbo-dev zlib1g-dev libssl-dev build-essential devscripts equivs git sudo

# install build dependencies for sentry-deb
cd /wd/pkg
mk-build-deps --install --tool "apt-get --assume-yes --no-install-recommends"

# rust compiler is required for libsourcemap
curl -sf https://static.rust-lang.org/rustup.sh | sh