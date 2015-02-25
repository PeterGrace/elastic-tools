#!/bin/bash
#This script will turn on maintenance mode for an elastic cluster.  When `maint.sh 1` is issued, elastic will not attempt to heal missing shards.
#
#You would use this script in an upgrade scenario or when you are anticipating removing a node for a specific purpose for a short period of time.
#
#`maint.sh 0` will turn off this maintenance mode and make the shards come back online.  Only execute this after the node is back online and connected to the cluster.
#
if [ -z $1 ]
then
        echo "0 or 1"
        exit
fi

if [ $1 -eq 1 ]
then
        DATA="{\"transient\":{\"cluster.routing.allocation.enable\":\"none\",\"cluster.routing.allocation.disable_allocation\" : true}}"
else
        DATA="{\"transient\":{\"cluster.routing.allocation.enable\":\"all\",\"cluster.routing.allocation.disable_allocation\" : false}}"
fi


curl -XPUT localhost:9200/_cluster/settings?pretty=true -d "${DATA}"

