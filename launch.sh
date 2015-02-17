#!/bin/bash

sed -i "s/#org.neo4j.server.webserver.address=0.0.0.0/org.neo4j.server.webserver.address=$HOSTNAME/g" $NEO4J_HOME/conf/neo4j-server.properties

limit=`ulimit -n`
if [ "$limit" -lt 65536 ]; then
    ulimit -n 65536;
fi
    
$NEO4J_HOME/bin/neo4j start && tail -F $NEO4J_HOME/data/log/*.log
