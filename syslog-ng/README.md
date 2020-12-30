
Run syslog-ng in a docker container. Allows servers to log remotely to this central log server. Log files are saved to the host's filesystem in /var/log/remote_logs.  Ensure you don't have syslog listening already on the parent/host port 514/udp.

docker build .

docker run --name syslog-ng -d -v /var/log/remote_logs:/var/log -p 514:514/udp <your container id>

Configure your servers to log remotely to this service.

