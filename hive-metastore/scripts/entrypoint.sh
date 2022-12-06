#!/bin/sh

# export HADOOP_HOME=/opt/hadoop-3.3.2
#vexport HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.2.jar
# export JAVA_HOME=/usr/local/openjdk-8
# export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}

echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 3306 ..."

while ! nc -z ${METASTORE_DB_HOSTNAME} 3306; do
  sleep 1
done

echo "Database on ${METASTORE_DB_HOSTNAME}:3306 started"
echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:3306"

/opt/hive-metastore/bin/schematool -initSchema -dbType mysql
/opt/hive-metastore/bin/start-metastore
