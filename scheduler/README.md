# aurora-scheduler-docker

## Build Docker Images

docker build -t marketin/aurora-scheduler .

## Running the container

hostIp=$(ipconfig getifaddr en0)  
name="mesos-aurora-scheduler"

docker run -p 8080:8080 \
	-e CLUSTER_NAME=foo \
	-e NATIVE_LOG_QUORUM_SIZE=1 \
	-e ZK_ENDPOINTS=${hostIp}:2181  \
	-e MESOS_MASTERS=zk://${hostIp}:2181/mesos \
	-e HOSTNAME=${hostIp} \
	--name=${name} \
	marketin/aurora-scheduler


http://localhost:7080/	

