############################################################
# Dockerfile to build Mongo2.4 container images
# Based on Centos
############################################################
FROM centos:centos6
MAINTAINER The Mongodb2.4 docker image: andrycolt007@gmail.com

#Comment
RUN echo 'Add Epel centos 6 repo'
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# Comment
RUN echo 'Install net-tools package'
RUN yum clean all && yum makecache && yum install -y net-tools && yum install -y htop && yum install -y openssh-server &&  yum install -y python-setuptools && easy_install supervisor

RUN yum update -y

#Configure ssh
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN chkconfig sshd on
RUN service sshd start

# Mongo DB install setup
RUN yum install mongodb-server-2.4.14-1.el6.x86_64 mongodb libmongodb -y
# Mongo DB install setup
ADD files/set_mongodb_password.sh /root/set_mongodb_password.sh
RUN /bin/bash /root/set_mongodb_password.sh

RUN sed -i 's/^bind_ip/#bind_ip/g' /etc/mongodb.conf
RUN sed -i 's/^#auth=true/auth=true/g' /etc/mongodb.conf

