FROM centos:centos7

LABEL name="CentOS7 with JDK8"

ENV JAVA_VERSION 8
ENV JAVA_URL http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz
ENV JAVA_FOLDER_NAME jdk1.8.0_92
ENV JDK_HOME /usr/java/${JAVA_FOLDER_NAME}
ENV JAVA_HOME /usr/java/${JAVA_FOLDER_NAME}/jre

RUN mkdir -p /usr/java

RUN curl \
	-L \
	-H "Cookie: oraclelicense=accept-securebackup-cookie" \
	"${JAVA_URL}" | \ 
	tar -xz -C /usr/java && \
	chown -R root:root ${JDK_HOME}

CMD ["/bin/bash"]
