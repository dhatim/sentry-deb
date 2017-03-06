#!/bin/sh -ex

cd /wd/pkg
dpkg-buildpackage -us -uc
cp /wd/*.deb /target

echo 'build complete'
