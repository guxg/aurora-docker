#!/bin/bash

# Check required Mesos env variables

if [ -z "$MESOS_PORT" ]; then
	echo "MESOS_PORT must not be empty"
	exit 1
fi

if [ -z "$MESOS_MASTER" ]; then
	echo "MESOS_MASTER must not be empty"
	exit 1
fi

if [ -z "$MESOS_SWITCH_USER" ]; then
	echo "MESOS_SWITCH_USER must not be empty"
	exit 1
fi

if [ -z "$MESOS_CONTAINERIZERS" ]; then
	echo "MESOS_CONTAINERIZERS must not be empty"
	exit 1
fi

if [ -z "$MESOS_LOG_DIR" ]; then
	echo "MESOS_LOG_DIR must not be empty"
	exit 1
fi

if [ -z "$MESOS_WORK_DIR" ]; then
	echo "MESOS_WORK_DIR must not be empty"
	exit 1
fi


# Check required Thermos executor env variables

if [ -z "$MESOS_ROOT" ]; then
	echo "MESOS_ROOT is not set, will be set to MESOS_WORK_DIR:$MESOS_WORK_DIR"
	MESOS_ROOT=$MESOS_WORK_DIR
elif [ "$MESOS_ROOT" != "$MESOS_WORK_DIR" ]; then
	echo "MESOS_ROOT is set to $MESOS_ROOT, but must match MESOS_WORK_DIR:$MESOS_WORK_DIR"
	exit 1

fi


OBSERVER_ARGS=(
  --port=${HTTP_PORT:-1338}
  --mesos-root=${MESOS_ROOT}
  --log_to_disk=NONE
  --log_to_stderr=google:INFO
)

#chown -R $USER:$USER $MESOS_ROOT $MESOS_WORK_DIR $MESOS_LOG_DIR

echo "Starting thermos observer ..."
exec "/usr/sbin/thermos_observer" "${OBSERVER_ARGS[@]}" &

echo "Starting Mesos slave ..."
exec /usr/sbin/mesos-slave
wait

tail -f /var/log/mesos


