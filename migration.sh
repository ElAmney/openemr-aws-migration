#!/bin/sh

check_aws_install () {
	AWS_EXIT_CODE=22
	which aws &>/dev/null
	[ $? -ne 0 ] && echo "Please make sure that aws is properly installed." && exit $AWS_EXIT_CODE
}

check_docker_install () {
	DOCKER_EXIT_CODE=22
	which docker &>/dev/null
	[ $? -ne 0 ] && echo "Please make sure that docker is properly installed." && exit $DOCKER_EXIT_CODE
}

check_docker_daemon_running () {
	DOCKER_DAEMON_EXIT_CODE=22
	docker version &>/dev/null
	[ $? -ne 0 ] && echo "Please make sure that the docker daemon is running properly." && exit $DOCKER_DAEMON_EXIT_CODE
}

check_aws_install

check_docker_install

check_docker_daemon_running

cat << EOF
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ Welcome to the OpenEMR local to AWS Migration script+
+++++++++++++++++++++++++++++++++++++++++++++++++++++++

This script will help you migrate your current local OpenEMR server to AWS based on your required needs.
Please follow the instructions to help guide you through this process.

EOF

