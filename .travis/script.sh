#!/usr/bin/env bash

if [ "${TRAVIS_EVENT_TYPE}" == push ] &&
       echo "${TRAVIS_TAG}" | egrep '^[0-9]+\.[0-9]+\.[0-9]+$'
then
    # the build is triggered by a tag push, and the tag looks like
    # a version number: proceed with release
    mvn versions:set -DnewVersion=${TRAVIS_TAG}
    mvn install
    
    # deploy to bintray
    DEB_FILE_NAME="$(basename ${TRAVIS_BUILD_DIR}/target/*.deb)"
    DEB_FILE_PATH="${TRAVIS_BUILD_DIR}/target/${DEB_FILE_NAME}"
    echo "Uploading ${DEB_FILE_NAME} to bintray..."
    curl -T "${DEB_FILE_PATH}" -u${BINTRAY_NAME}:${BINTRAY_KEY} "https://api.bintray.com/content/dhatim/deb/sentry/${TRAVIS_TAG}/${DEB_FILE_NAME};deb_distribution=stable;deb_component=main;deb_architecture=amd64"
    echo "Publishing version ${TRAVIS_TAG}..."
    curl -X POST -u${BINTRAY_NAME}:${BINTRAY_KEY} "https://api.bintray.com/content/dhatim/deb/sentry/${TRAVIS_TAG}/publish"
else
    # this is a regular build
    mvn install
fi
