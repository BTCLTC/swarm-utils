#!/bin/sh

swarm_utils_path=`pwd`
chmod a+x $swarm_utils_path/bin/*

replaced=""

homeExists=`cat /etc/profile | grep "export SWARM_UTILS_HOME=" | head -n 1`
if [ -n "$homeExists" ]; then
    sed -i /"export\ SWARM_UTILS_HOME=.*"/d /etc/profile
    replaced="yes"
fi 
echo """export SWARM_UTILS_HOME=$swarm_utils_path""" >> /etc/profile

pathExists=`cat /etc/profile | grep '$SWARM_UTILS_HOME/bin' | head -n 1`
if [ -n "$pathExists" ]; then
    sed -i /"export\ PATH=\$PATH\:\$SWARM_UTILS_HOME\/bin"/d /etc/profile
fi
echo 'export PATH=$PATH:$SWARM_UTILS_HOME/bin' >> /etc/profile

source /etc/profile
if [ "$replaced" == "yes" ]; then
    echo "install swarm-utils install done (replaced)."
else
    echo "install swarm-utils install done."
fi