#!/bin/bash

DOCKER_IMAGE="mdns/rancher-openvpn"
DOCKER_TAG="$1"

if [ "$DOCKER_TAG" = "" ]
then
	echo "Usage : $0 tag"
	exit 1
fi

[ ! -e "Dockerfile" ] && echo "Missing Dockerfile" && exit 2

docker build -t $DOCKER_IMAGE:$DOCKER_TAG .

if [ "$?" = "0" ]
then
	echo "Build done for tag $DOCKER_IMAGE:$DOCKER_TAG"
	echo "Launch example : "
	echo "	docker run -d --privileged=true --name vpn \\"
	echo "		-e AUTH_METHOD=ldap -p 1194:1194 $DOCKER_IMAGE:$DOCKER_TAG"
else
	echo "Build failed for tag $DOCKER_IMAGE:$DOCKER_TAG"
fi