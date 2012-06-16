#!/bin/sh

#
# node supervisor startup script for 500ties
# by default starting in production mode
#

cd /home/ties/500ties
NODE_ENV=production /usr/local/bin/supervisor server.js

