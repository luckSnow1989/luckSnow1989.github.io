FROM tomcat8-orajdk8-centos7:v1.2

MAINTAINER "蒋超<chao.jiang@yooli.com>"

LABEL   Date="2019-07-31" \
        Subscribe="SpringMVC项目，上线k8s测试环境"

ARG JAR_FILE
ARG BASH_HEAD="#!/bin/bash"
#生产环境推荐为一个容器分配5G内存，本地测试环境视情况而定或忽略该参数
ARG JAVA_OPTS='export CATALINA_OPTS="$CATALINA_OPTS -server -Xms1024M -Xmx1024M -Xmn512M"\n'
ARG JVM_SERVER_OPTS='export CATALINA_OPTS="$CATALINA_OPTS \
 -XX:MetaspaceSize=512M \
 -XX:MaxMetaspaceSize=512M \
 -Xverify:none \
 -XX:SurvivorRatio=8 \
 -XX:MaxTenuringThreshold=7 \
 -XX:GCTimeRatio=19 \
 -XX:+DisableExplicitGC \
 -XX:+UseParNewGC \
 -XX:+UseConcMarkSweepGC \
 -XX:+CMSPermGenSweepingEnabled \
 -XX:+CMSClassUnloadingEnabled \
 -XX:-CMSParallelRemarkEnabled \
 -XX:CMSInitiatingOccupancyFraction=70 \
 -XX:CompileCommandFile=.hotspot_compiler \
 -XX:+PrintGCDetails \
 -XX:+PrintGCTimeStamps \
 -XX:+PrintHeapAtGC \
 -XX:+PrintGCApplicationStoppedTime"\n'
ARG EXPOSE_PORT=8080
ARG LOG_ROOT_VOLUME
ARG PROJECT_ARTIFACTID
ARG SERVER_PUBLISH_NAME
ARG SETENV_FILE=/usr/local/tomcat/bin/setenv.sh
ENV PROJECT_ARTIFACTID=$PROJECT_ARTIFACTID
ENV LOG_VOLUME=$LOG_ROOT_VOLUME/$SERVER_PUBLISH_NAME
ENV JVM_GC_LOG='export CATALINA_OPTS="$CATALINA_OPTS -XX:HeapDumpPath=$LOG_VOLUME -XX:ErrorFile=$LOG_VOLUME/$PROJECT_ARTIFACTID-GC-ERR.log -Xloggc:$LOG_VOLUME/$PROJECT_ARTIFACTID-GC.log"'
#远程debug模式，默认端口为7474；启动参数引用该变量即可开启该模式
ENV REMOTE_DEBUG_MODEL="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=7474"
ENV EXPOSE_PORT=$EXPOSE_PORT
#指定时区
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#如果想指明存储卷的位置，应在容器启动时通过-v hostDir:containerDir指定
VOLUME $LOG_VOLUME

#指定容器的工作目录，必须在ADD指令之前！
WORKDIR /usr/local/tomcat

#如需指明映射的主机端口号，可在容器启动时通过-p hostPort:containerPort指定
EXPOSE $EXPOSE_PORT 7474 52996

#将虚拟机参数写入setenv.sh脚本
RUN echo $BASH_HEAD > $SETENV_FILE && echo -e $JAVA_OPTS$JVM_SERVER_OPTS$JVM_GC_LOG >> $SETENV_FILE && chmod 777 $SETENV_FILE
#指定需要制作成镜像的jar包
ADD $JAR_FILE /usr/local/tomcat/webapps/ROOT.war

ENTRYPOINT ["sh","-c","catalina.sh run"]
