# -*- coding: utf-8 -*-
import sys
from distutils.core import setup

if __name__ == '__main__' and sys.argv[1] == 'test':
    exit()

setup(
    name='sentry',
    version='8.13.0',
    author='Raphaël Berbain',
    author_email='rberbain@dhatim.com',
    packages=[],
    license='BSD',
    description='Sentry',
    classifiers=[
        'Environment :: Web Environment',
        'Framework :: Django',
    ],
)
