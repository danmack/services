#!/bin/sh
set -e

CONTAINER_NAME="syslog-ng-lab"
IMAGENAME=syslog-ng-lab
CONTAINER_FE="podman"  # or CONTAINER_FE="docker"

$CONTAINER_FE container stop ${CONTAINER_NAME} || true > /dev/null 2>&1
$CONTAINER_FE container rm ${CONTAINER_NAME}   || true > /dev/null 2>&1

# minimal syslog-ng config

cat << EOF > syslog-ng.conf 

@version: 3.22

options {
    flush_lines (0);
    time_reopen (10);
    log_fifo_size (1000);
    chain_hostnames (off);
    use_dns (yes);
    use_fqdn (yes);
    create_dirs (no);
    keep_hostname (yes);
    create_dirs(yes); 
    dir_perm(0750);
    owner("root");
    group("root");
    perm(0640);
};

source syslog_udp { udp(ip("0.0.0.0") port(514)); };

destination d_remote_logs { file( "/var/log/${FULLHOST_FROM}.log"); };

log {  source(syslog_udp); destination(d_remote_logs); };

EOF

$CONTAINER_FE build -t $IMAGENAME --rm=true --force-rm=true .
echo ""
echo "Start your container with the command:"
echo ""
echo "mkdir -p logs; $CONTAINER_FE run --name ${CONTAINER_NAME} -d -v ${PWD}/logs:/var/log -p 514:514/udp ${IMAGENAME}"

rm syslog-ng.conf

