FROM centos:centos7

LABEL name="CentOS7 with JDK8"

ENV JAVA_VERSION 8
ENV JAVA_FOLDER_NAME jdk1.8.0_202
ENV JDK_HOME /usr/java/${JAVA_FOLDER_NAME}
ENV JAVA_HOME /usr/java/${JAVA_FOLDER_NAME}/jre

COPY java-installer.sh /
RUN /java-installer.sh
RUN rm /java-installer.sh

CMD ["/bin/bash"]
