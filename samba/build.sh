#!/bin/sh

CONTAINER_NAME="samba-server-lab"

LOCAL_SHARE="share"

docker container stop ${CONTAINER_NAME}  > /dev/null 2>&1
docker container rm ${CONTAINER_NAME}  > /dev/null 2>&1

# Simple samba config

cat << EOF > smb.conf 

#
# Example smb.conf for a wide open share
#
[global]
   workgroup = WORKGROUP
   security =  user
   map to guest = bad user
   guest account = nobody

[share]
    comment = share 
    public = yes
    path = share
    read only = no
    guest ok = yes
    only guest = yes
    writable = yes
    force group = nogroup
    force user = nobody
    force create mode = 0755
    force directory mode = 0755
    browsable = yes

EOF

mkdir -p ${LOCAL_SHARE} 

# Group may vary between nogroup and nobody
chown -R nobody:nogroup ${LOCAL_SHARE} 
chmod -R ugo+rwx ${LOCAL_SHARE}

OUTPUT=$(docker build --rm=true --force-rm=true . | grep "Successfully built")
CONTAINER=$(echo $OUTPUT | cut -d' ' -f3)
echo $OUTPUT
echo ""
echo "Start your container with the command:"
echo ""
echo "docker run --name ${CONTAINER_NAME} -d -v ${PWD}/${LOCAL_SHARE}:/share -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 ${CONTAINER}"

rm smb.conf
