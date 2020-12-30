#!/bin/sh

CONTAINER_NAME="samba-server-eee48"

# the name of the directory on the host where the smb files will be stored
# if you change the name here, you also need to change it in the smb.conf.
LOCAL_SHARE="/share"

docker container stop ${CONTAINER_NAME}  > /dev/null 2>&1
docker container rm ${CONTAINER_NAME}  > /dev/null 2>&1

mkdir -p ${LOCAL_SHARE} 

# Group may vary between nogroup and nobody
chown -R nobody:nogroup /share
chmod -R ugo+rwx /share

OUTPUT=$(docker build --rm=true --force-rm=true . | grep "Successfully built")
echo $OUTPUT
CONTAINER=$(echo $OUTPUT | cut -d' ' -f3)
echo ""
echo "Start your container with the command:"
echo "docker run --name ${CONTAINER_NAME} -d -v ${LOCAL_SHARE}:/share -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 ${CONTAINER}"


