#!/bin/bash

# Choose a strong password
MYPASS=Mysql12_

sudo systemctl stop mysqld
sudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables --skip-networking"
sudo systemctl start mysqld
# First reset the root password to blank
sudo mysql --user="root" --execute="UPDATE mysql.user SET authentication_string = '' WHERE User = 'root' AND Host = 'localhost' ; FLUSH PRIVILEGES"
sudo systemctl stop mysqld
sudo systemctl unset-environment MYSQLD_OPTS
sudo systemctl start mysqld
# Finally set root password to $MYPASS
sudo mysql --user="root" --password="" --connect-expired-password --execute="SET PASSWORD FOR 'root'@'localhost' = '$MYPASS'"
