

This container is a samba server with wide open permissions on the share.

Edit build.sh to specify the share path on the local host where files will be saved. Also,
specify the name of the container. The default container name is samba-server-eee48.
Each time the build.sh is run, the container will be stopped and removed.

Run build.sh in this directory to start the server.

Here is an example of the run command:
docker run --name samba-server -d -v /share:/share -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 0e94e8243668



