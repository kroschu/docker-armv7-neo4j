#
# ARMv7hf image with Neo4j, meant for use on Raspberry Pi 2
#

FROM oysteinjakobsen/armv7-oracle-java8 

MAINTAINER Øystein Jakobsen <oystein.jakobsen@bouvet.no>

ENV \
  NEO4J_HOME=/var/lib/neo4j \
  PATH=/var/lib/neo4j/bin:$PATH

RUN \
  wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - && \
  echo 'deb http://debian.neo4j.org/repo stable/' | tee /etc/apt/sources.list.d/neo4j.list && \
  apt-get update && \
  apt-get install -y neo4j && \
  apt-get clean && \
  sed -i 's/#node_auto_indexing/node_auto_indexing/g' $NEO4J_HOME/conf/neo4j.properties && \
  sed -i 's/#node_keys_indexable/node_keys_indexable/g' $NEO4J_HOME/conf/neo4j.properties && \ 
  echo 'remote_shell_host=0.0.0.0' >> $NEO4J_HOME/conf/neo4j.properties

ADD launch.sh /

RUN \
  chmod +x /launch.sh && \
  ln -s $NEO4J_HOME/data /data

VOLUME /data

EXPOSE 7474 1337

CMD ["/bin/bash", "-c", "/launch.sh"]

