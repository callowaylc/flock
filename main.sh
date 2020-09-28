#!/bin/bash
set -eu
trap 'release $id' EXIT INT TERM

## func
release() {
	trap - INT TERM EXIT
	logger -sp DEBUG "Released semaphore" "id=$1"
}

## env
: ${POLL:=5}
: ${SECONDS=0}

id=${1?reqarg}

## main
set -- "id=$id"

{ logger -sp DEBUG "Waiting to aquire semaphore" $@

	flock 200
	logger -sp DEBUG "Aquired semaphore" $@ "wait=$SECONDS"

	while : ;do
		logger -sp DEBUG "Polling" $@ "time=$SECONDS"
		sleep $POLL
	done

} 200>/dev/null
