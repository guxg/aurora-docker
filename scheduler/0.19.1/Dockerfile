FROM mesosphere/mesos-master:1.5.0
MAINTAINER Gu Xiangguo <xiangguo.gu@marketin.cn>

ARG AURORA_VERSION=0.19.1
ARG MESOS_REPLICATED_LOG_PATH=/var/lib/aurora/scheduler/db
ENV USER=aurora

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-8-jre-headless wget && \
    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

RUN wget -c https://apache.bintray.com/aurora/ubuntu-trusty/aurora-scheduler_${AURORA_VERSION}_amd64.deb && \
    dpkg -i aurora-scheduler_${AURORA_VERSION}_amd64.deb

RUN service aurora-scheduler stop && \
    mkdir -p $MESOS_REPLICATED_LOG_PATH && \
    mesos-log initialize --path=$MESOS_REPLICATED_LOG_PATH

RUN chown -R $USER:$USER $MESOS_REPLICATED_LOG_PATH

COPY scheduler.sh /home/aurora/scheduler.sh

RUN chown $USER:$USER /home/$USER/scheduler.sh && \
    chmod 500 /home/$USER/scheduler.sh

USER aurora

WORKDIR /home/$USER

ENTRYPOINT ["./scheduler.sh"]
