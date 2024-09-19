#!/bin/bash

# Prerequisites Checks
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

# Begin Migration
cat << EOF
++++++++++++++++++++++++++++++++++++++++++++++
+ Welcome to the OpenEMR AWS Migration script+
++++++++++++++++++++++++++++++++++++++++++++++

This script will help you migrate your current local OpenEMR server to AWS based on your required needs.
Please follow the instructions to help guide you through this process.

EOF

# MySQL Dump of database
echo "Creating a backup of your database container:"

read -p "Enter container name [default=production-mysql-1]: " CONTAINER_NAME
CONTAINER_NAME=${CONTAINER_NAME:-production-mysql-1}
read -p "Enter database user [default=root]: " DB_USER
DB_USER=${DB_USER:-root}
read -p "Enter database password [default=root]: " DB_PASSWORD
DB_PASSWORD=${DB_PASSWORD:-root}

# docker exec $CONTAINER_NAME /usr/bin/mysqldump --all-databases -u $DB_USER --password=$DB_PASSWORD > backup_db.sql

# ToDo (Consider Percona XtraBackup. For large databases, such as those larger than 100 GB, this can provide a significantly 
# better restoration time than some other tools.)
# See https://docs.aws.amazon.com/prescriptive-guidance/latest/migration-large-mysql-mariadb-databases/percona-xtrabackup.html
