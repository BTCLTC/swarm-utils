#!/bin/sh

swarm_utils_path=`pwd`
chmod a+x $swarm_utils_path/bin/*
pathExists=`cat /etc/profile | grep "$swarm_utils_path/bin" | head -n 1`
if [ -n "$pathExists" ]; then
    echo swarm-utils has already installed.
else
    echo "export PATH=\$PATH:$swarm_utils_path/bin" >> /etc/profile
    source /etc/profile
    echo install swarm-utils install done.
fi 