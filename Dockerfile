#version: 2.0
FROM ubuntu:20.04

#Owner: Bahaeddine feriani

ARG DEBIAN_FRONTEND=noninteractive
ENV HADOOP_VERSION=3.3.5
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install wget && \
    apt-get -y install ssh && \
    apt-get -y install pdsh && \
    apt-get -y install rsync;

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;
    
# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz && \
    tar -xzf hadoop-3.3.5.tar.gz && \
    mv hadoop-3.3.5 /opt/hadoop
COPY ./config /opt/hadoop/etc/hadoop/
COPY ./shell/namenode.sh /
COPY ./shell/yarn.sh /
COPY ./shell/datanode.sh /
COPY ./shell/manager.sh /

COPY ./startup.sh /


#environment variables
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV USER=root
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
RUN hdfs namenode -format

CMD ["/bin/bash","startup.sh"]
