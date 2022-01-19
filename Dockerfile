# specifiy the image ' OS
FROM ubuntu:18.04
MAINTAINER Wissem Inoubli (inoubliwissem@gmail.com)
# create a new user and add it as sudoer
RUN useradd -m hduser && echo "hduser:supergroup" | chpasswd && adduser hduser sudo && echo "hduser     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && cd /usr/bin/ &&  ln -s python3 python
# set the workspace
WORKDIR /home/hduser

# install the required softwares (JDK, openssh, wget)
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget

# switech to the created user

USER hduser

# download hadoop and extract it


RUN wget -q https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz && tar zxvf hadoop-3.3.0.tar.gz && rm hadoop-3.3.0.tar.gz
RUN sudo service ssh start

RUN mv hadoop-3.3.0 hadoop

# share the public key
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 
ENV HADOOP_HOME=/home/hduser/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/sbin
ENV HADOOP_MAPRED_HOME=${HADOOP_HOME}
ENV HADOOP_COMMON_HOME=${HADOOP_HOME}
ENV HADOOP_HDFS_HOME=${HADOOP_HOME}
ENV YARN_HOME=${HADOOP_HOME}
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

COPY ssh_config /etc/ssh/ssh_config

# create hdfs directories 
RUN mkdir -p hadoop/hdfs/datanode
RUN mkdir -p hadoop/hdfs/namenode
RUN mkdir -p hadoop/logs

#set the hadoop configation files
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY core-site.xml $HADOOP_HOME/etc/hadoop/
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY yarn-site.xml $HADOOP_HOME/etc/hadoop/
COPY mapred-site.xml $HADOOP_HOME/etc/hadoop/



#open the used ports
EXPOSE 50070 50075 50010 50020 50090 8020 9000 9864 9870 10020 19888 8088 8030 8031 8032 8033 8040 8042 22

# format the HDFS system
RUN hdfs namenode -format

# start hadoop 's services 

RUN start-dfs.sh
RUN start-yarn.sh
 
