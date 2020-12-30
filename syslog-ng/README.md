
Run syslog-ng-lab in a docker container. Allows servers to log remotely to this central log server. Log files are saved to the host's filesystem in ${PWD}/logs.  Ensure you don't have syslog listening already on the parent host port 514/udp.

Run:  sh ./build.sh

Configure your servers to log remotely to this service via IP address.

