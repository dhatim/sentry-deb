# sentry-deb

The goal of this project is to package [sentry](https://getsentry.com)
for [debian](https://www.debian.org). It leverages
[dh-virtualenv](https://github.com/spotify/dh-virtualenv) to perform
the actual work. The primary OS target is debian 8 "jessie"; It might
or might not work on other debian and debian based systems.

## Usage

From the *same OS version* as your target, do:

    $ git clone git@github.com:dhatim/sentry-deb.git
    $ cd sentry-deb/pkg
    $ dpkg-buildpackage -us -uc
    $ cd ..
    $ ls -1
    README.md
    sentry_8.13.0-1.dsc
    sentry_8.13.0-1.tar.gz
    sentry_8.13.0-1_amd64.changes
    sentry_8.13.0-1_amd64.deb

## some more details

### sentry

The target sentry version is 8.10.0. postinst calls `sentry init
/etc/sentry/sentry.conf.py` if this file doesn't exist already, so as
to provide a sample configuration file.

### postgresql

The package adds a dependency on the postgresql driver, so it is ready
to use with a postgresql database.

### supervisor

The package is made to depend on supervisor, and provides a suitable
supervisor configuration file so that sentry server and workers start
as services, managed by supervisor.

### service

Please note that *The sentry service won't start by default on package
installation*.  You'll have to configure whatever it is that needs to
be configured, and tickle supervisor so it picks up the changes, i.e.:

    # supervisorctl reread
    # supervisorctl update

### upgrade procedure

```bash
$ sudo supervisorctl stop sentry-web
sentry-web: stopped
$ sudo supervisorctl stop sentry-worker
sentry-worker: stopped
$ sudo apt-get update
$ sudo apt-get install sentry
$ sudo /usr/share/python/sentry/bin/sentry --config /etc/sentry/sentry.conf.py upgrade
...
$ sudo supervisorctl start sentry-worker
sentry-worker: started
$ sudo supervisorctl start sentry-web
sentry-web: started
```
