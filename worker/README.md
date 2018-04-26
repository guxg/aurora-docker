# aurora-exectuor-docker

Aurora observer (thermos_observer) running at mesos-agent.

## Package

https://packages.ubuntu.com/search?suite=xenial&arch=amd64&searchon=names&keywords=python2.7

https://github.com/mesosphere/mesos-deb-packaging/issues/51


```

docker exec -it mesos-agent-01 /bin/bash

# dpkg -S /usr/lib/python2.7/site-packages
mesos: /usr/lib/python2.7/site-packages

RUN mv /usr/lib/python2.7/site-packages/* /usr/lib/python2.7/dist-packages/ && \
    rm -rf /usr/lib/python2.7/site-packages && \
	ln -s /usr/lib/python2.7/dist-packages /usr/lib/python2.7/site-packages

```

## Build Docker Images

docker build -t marketin/aurora-worker .


## Running the container

hostIp=$(ipconfig getifaddr en0)  
name="mesos-aurora-worker"

docker run --privileged -p 6080:8080 \
    -e MESOS_PORT=5051
	-e CLUSTER_NAME=foo \
	-e NATIVE_LOG_QUORUM_SIZE=1 \
	-e ZK_ENDPOINTS=${hostIp}:2181  \
	-e MESOS_MASTERS=zk://${hostIp}:2181/mesos \
	-e HOSTNAME=${hostIp} \
	--name=${name} \
	marketin/aurora-scheduler


http://localhost:7080/	

