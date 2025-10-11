FROM saturn3-orajdk8-centos7:v1.1

MAINTAINER "万文庆<wenqing.wan@yooli.com>"

LABEL   Date="2019-09-04" \
        Subscribe="使用Saturn基础镜像上线k8s测试环境"

ARG SATURN_NAMESPACE
ARG JAR_FILE
ARG LOG_ROOT_VOLUME
ARG PROJECT_ARTIFACTID
ARG VIP_SATURN_CONSOLE_URI
ARG JVM_SIZE="-Xmx2g -Xms2g -Xmn1g"

ENV LOG_VOLUME=$LOG_ROOT_VOLUME/$PROJECT_ARTIFACTID
ENV VIP_SATURN_CONSOLE_URI=$VIP_SATURN_CONSOLE_URI
ENV SATURN_NAMESPACE=$SATURN_NAMESPACE
ENV SATURN_EXECUTORNAME=none
ENV JVM_SIZE=$JVM_SIZE
#指定时区
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#如果想指明存储卷的位置，可在容器启动时通过-v hostDir:containerDir指定
VOLUME $LOG_VOLUME

ADD $JAR_FILE /app.zip
RUN chmod 755 /app.zip && unzip /app.zip

CMD ["sh","-c","saturn-executor.sh start -n $SATURN_NAMESPACE -e $SATURN_EXECUTORNAME -r foreground -d /root/app -sld $LOG_VOLUME -DVIP_SATURN_CONSOLE_URI=$VIP_SATURN_CONSOLE_URI"]