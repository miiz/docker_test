FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

#Kafka version
ENV KAFKA_VERSION 2.11-1.0.0

#Kafka home location
ENV KAFKA_HOME /opt/kafka

#Use the root user to install and setup
USER root

#Zookeeper port
EXPOSE 2181

#Kafka port
EXPOSE 9092

#Copy files
COPY kafka_$KAFKA_VERSION /opt/kafka_$KAFKA_VERSION
COPY config /opt/kafka_$KAFKA_VERSION/config

#Link kafka
RUN cd /opt && \
    ln -s kafka_$KAFKA_VERSION kafka

#Add the kafka directory to $PATH
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
ENV PATH /opt/kafka/bin:$PATH

WORKDIR /opt/kafka

ENTRYPOINT ["zookeeper-server-start.sh","config/zookeeper.properties"]






