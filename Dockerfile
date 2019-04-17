FROM centos:centos7

LABEL name="CentOS7 with JDK8"

#修改时间和时区 https://blog.csdn.net/alinyua/article/details/80944543
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

COPY java-installer.sh /
RUN /java-installer.sh
RUN rm /java-installer.sh

ENV JAVA_FOLDER_NAME jdk1.8.0_211-amd64
ENV JAVA_HOME /usr/java/${JAVA_FOLDER_NAME}
ENV JRE_HOME /usr/java/${JAVA_FOLDER_NAME}/jre
ENV PATH=$JAVA_HOME/bin:$PATH \
    CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tool.jar:$JAVA_HOME/lib

CMD ["/bin/bash"]
