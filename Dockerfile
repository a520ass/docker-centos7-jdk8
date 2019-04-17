FROM centos:centos7

LABEL name="CentOS7 with JDK8"

#修改时间和时区 https://blog.csdn.net/alinyua/article/details/80944543
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
#安装中文支持
RUN yum -y install kde-l10n-Chinese telnet && \
    yum -y reinstall glibc-common && \
    yum clean all && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
#设置环境变量
ENV LC_ALL "zh_CN.UTF-8"

COPY java-installer.sh /
RUN /java-installer.sh
RUN rm /java-installer.sh

ENV JAVA_FOLDER_NAME jdk1.8.0_211-amd64
ENV JAVA_HOME /usr/java/${JAVA_FOLDER_NAME}
ENV JRE_HOME /usr/java/${JAVA_FOLDER_NAME}/jre
ENV PATH=$JAVA_HOME/bin:$PATH \
    CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tool.jar:$JAVA_HOME/lib

CMD ["/bin/bash"]
