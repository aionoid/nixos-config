#!/usr/bin/env bash

export LC_ALL=C

B="[40;36m"
W="[40;37m"
# G="[40;32m"
# R="[40;31m"
# Y="[40;33m"
P="[40;35m"

  echo "${P} CREATING BACKUP!${W}"

	stty -echo
	read -rp "Enter CURRENT PostgreSQL Password: " db_pwd
	stty echo
  echo ""
  export PGPASSWORD=$db_pwd

  folder_name=backup_$(date +%Y_%m_%d_%H_%M_%S)
  sudo mkdir -p "/root/$server_folder/backup/${folder_name}"
  
  chmod -R 777 /root

	echo "Creating $db4_member backup"
  pg_dump -U postgres -Fp $db4_member > "/root/$server_folder/backup/${folder_name}/${db4_member}.sql"

	echo "Creating $db2_gateway backup"
  pg_dump -U postgres -Fp $db2_gateway  > "/root/$server_folder/backup/${folder_name}/${db2_gateway}.sql"

	echo "Creating $db3_account backup"
  pg_dump -U postgres -Fp $db3_account > "/root/$server_folder/backup/${folder_name}/${db3_account}.sql"

  echo "${B} BACKUP CREATED! > $folder_name ${W}"

