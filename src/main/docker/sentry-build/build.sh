#!/bin/sh -ex

# build libsourcemap
#cd /wd
#git clone https://github.com/getsentry/libsourcemap
#cd libsourcemap
#git checkout tags/0.5.0
#pip install --upgrade pip cffi
#make develop

# build sentry-deb
cd /wd
dpkg-buildpackage -us -uc

echo 'build complete'
