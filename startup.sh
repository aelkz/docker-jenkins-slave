#!/bin/bash
set -e

if ! [ $# -gt 1 ]; then
   echo "launch with args: <jnlpUrl> <secret>"
   exit 1
fi

set -x

/usr/bin/Xvfb :1 &

# download slave jar
wget http://jenkins:8080/jnlpJars/slave.jar -O slave.jar
DISPLAY=:1
exec java -jar slave.jar -jnlpUrl $1 -secret $2
