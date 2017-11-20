#!/bin/bash -ex

chmod 755 /wd /wd/pkg/build-pkg.sh

apt-get update
apt-get --assume-yes --no-install-recommends install dh-virtualenv devscripts equivs libpq-dev python-dev libc6-i386

# install build dependencies for sentry-deb
cd /wd/pkg
mk-build-deps --install --tool "apt-get --assume-yes --no-install-recommends"
