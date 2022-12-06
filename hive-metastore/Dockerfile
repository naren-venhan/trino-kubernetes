FROM openjdk:8u242-jre

# environment variables
ENV HADOOP_VERSION=3.3.2
ENV METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive-metastore


WORKDIR /opt

USER root
# dowload hive metastore + ADLS2 required packages
RUN curl -L https://downloads.apache.org/hive/hive-standalone-metastore-3.0.0/hive-standalone-metastore-3.0.0-bin.tar.gz | tar zxf - && \
    mv /opt/apache-hive-metastore-${METASTORE_VERSION}-bin ${HIVE_HOME} && \
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf - && \
    cp mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar ${HIVE_HOME}/lib/ 
    

RUN apt-get update && apt-get install -y netcat

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} 

USER hive

WORKDIR ${HIVE_HOME}/lib

RUN curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/${HADOOP_VERSION}/hadoop-azure-${HADOOP_VERSION}.jar -o hadoop-azure-${HADOOP_VERSION}.jar && \
    curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure-datalake/${HADOOP_VERSION}/hadoop-azure-datalake-${HADOOP_VERSION}.jar -o hadoop-azure-datalake-${HADOOP_VERSION}.jar

WORKDIR ${HADOOP_HOME}/share/hadoop/tools/lib

USER root
RUN apt install libssl-dev -y

RUN rm ${HIVE_HOME}/lib/guava-*.jar && \
    rm -rf  /opt/mysql-connector-java-8.0.19 && \
    rm -rf /opt/apache-hive-metastore-${METASTORE_VERSION}-bin && \
    rm -rf /opt/hadoop-${HADOOP_VERSION} 

# start metastore
USER hive
EXPOSE 9083

