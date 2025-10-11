FROM orajdk8-centos7:v1.1

MAINTAINER "蒋超<chao.jiang@yooli.com>"

LABEL   Date="2019-08-02" \
        Subscribe="上线k8s测试环境"

ARG JAR_FILE
ARG EXPOSE_PORT=8080
ARG LOG_ROOT_VOLUME
ARG PROJECT_ARTIFACTID
#JVM内存限定参数
ARG JAVA_OPTS="-server -Xmx1024M -Xms1024M -Xmn512M"
ENV JVM_SERVER_OPTS="-Xss256K \
 -XX:MetaspaceSize=512M \
 -XX:MaxMetaspaceSize=512M \
 -XX:+DisableExplicitGC \
 -XX:SurvivorRatio=8 \
 -XX:+UseConcMarkSweepGC \
 -XX:+UseParNewGC \
 -XX:+CMSParallelRemarkEnabled \
 -XX:+CMSClassUnloadingEnabled \
 -XX:LargePageSizeInBytes=128M \
 -XX:+UseFastAccessorMethods \
 -XX:+UseCMSInitiatingOccupancyOnly \
 -XX:CMSInitiatingOccupancyFraction=80 \
 -XX:SoftRefLRUPolicyMSPerMB=0 \
 -XX:+PrintClassHistogram \
 -XX:+PrintGCDetails \
 -XX:+PrintGCTimeStamps \
 -XX:+PrintHeapAtGC \
 -XX:+PrintGCDetails \
 -XX:+PrintGCDateStamps \
 -XX:+PrintHeapAtGC \
 -XX:+PrintGCApplicationStoppedTime"
#环境变量
ENV JAVA_OPTS=$JAVA_OPTS
ENV PROJECT_ARTIFACTID=$PROJECT_ARTIFACTID
ENV LOG_VOLUME=$LOG_ROOT_VOLUME/$PROJECT_ARTIFACTID
ENV JVM_GC_LOG="-XX:HeapDumpPath=$LOG_VOLUME -XX:ErrorFile=$LOG_VOLUME/$PROJECT_ARTIFACTID-GC-ERR.log -Xloggc:$LOG_VOLUME/$PROJECT_ARTIFACTID-GC.log"
ENV JAVA_SECURITY_EGD="-Djava.security.egd=file:/dev/./urandom"
#远程debug模式，默认端口为7474；启动参数引用该变量即可开启该模式
ENV REMOTE_DEBUG_MODEL="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=7474"
ENV EXPOSE_PORT=$EXPOSE_PORT
#注意：这个环境变量打开的话，springBoot项目配置的端口就会被pom中传递过来的EXPOSE_PORT覆盖
ENV SERVER_PORT=$EXPOSE_PORT
#指定时区
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#如果想指明存储卷的位置，可在容器启动时通过-v hostDir:containerDir指定
VOLUME $LOG_VOLUME

#指定容器的工作目录，必须在ADD指令之前！
WORKDIR /workDir

#如需指明映射的主机端口号，可在容器启动时通过-p hostPort:containerPort指定
EXPOSE $EXPOSE_PORT 7474

#指定需要制作成镜像的jar包
ADD $JAR_FILE app.jar

ENTRYPOINT ["sh","-c","java $JAVA_OPTS $JVM_SERVER_OPTS $JVM_GC_LOG $JAVA_SECURITY_EGD -jar app.jar"]
