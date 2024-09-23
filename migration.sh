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

# ssh into server
# Not necessary if doing migration inside server

# MySQL Dump of database
echo "Creating a backup of your database:"

read -p "Enter database user [default=openemr]: " DB_USER
DB_USER=${DB_USER:-root}
read -p "Enter database password [default=openemr]: " DB_PASSWORD
DB_PASSWORD=${DB_PASSWORD:-root}

# Backup database
mysqldump openemr --opt --quote-names --hex-blob -u $DB_USER --password=$DB_PASSWORD | gzip > openemr.sql.gz

# Backup filesystem
# Refer to your OS and webserver documentation to obtain your webserver root directory. For example, Ubuntu's webserver root 
# directory is /var/www/html 
echo "Creating a backup of your openemr filesystem:"

read -p "Enter the path to your openemr filesystem [default=/var/www/html/openemr/]: " OPENEMR_PATH
OPENEMR_PATH=${OPENEMR_PATH:-"/var/www/html/openemr/"}

# tar -C $OPENEMR_PATH -zcf openemr.tar.gz ./
sudo tar -C $OPENEMR_PATH -zcf openemr.tar.gz ./ # 

# Combine the database and backups together
tar -cvf emr_backup.tar openemr.sql.gz openemr.tar.gz



# This page lists which files to backup and how to recover
# See https://www.open-emr.org/wiki/index.php/Backing_Up_Using_the_Built_In_Tools
# OPTIONAL
# Consider Percona XtraBackup. For large databases, such as those larger than 100 GB, this can provide a significantly
# better restoration time than some other tools.)
# See https://docs.aws.amazon.com/prescriptive-guidance/latest/migration-large-mysql-mariadb-databases/percona-xtrabackup.html
# https://github.com/openemr/openemr-devops/blob/master/docker/mysql-xtrabackup/xbackup-wrapper.sh
