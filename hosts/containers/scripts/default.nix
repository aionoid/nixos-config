{
  pkgs,
  db_password,
  db_members,
  db_gateway,
  db_account,
  db_encoding,
  server_address,
  patch_info,
  ...
}: {
  environment.systemPackages = with pkgs; let
    gsbackup = pkgs.writers.writeBashBin "gsbackup_db" ''
      export LC_ALL=C

      B="[40;36m"
      W="[40;37m"
      G="[40;32m"
      R="[40;31m"
      Y="[40;33m"
      P="[40;35m"

        echo "$P CREATING BACKUP!$W"

      	# stty -echo
      	# read -rp "Enter CURRENT PostgreSQL Password: " db_pwd
      	# stty echo
      	#  echo ""
        export PGPASSWORD=${db_password}

        folder_name=backup_$(date +%Y_%m_%d_%H_%M_%S)
        sudo mkdir -p "/root/server/backup/$folder_name"

        chmod -R 777 /root

      	echo "Creating ${db_members} backup"
        pg_dump -U postgres -Fp ${db_members} > "/root/server/backup/$folder_name/${db_members}.sql"

      	echo "Creating ${db_gateway} backup"
        pg_dump -U postgres -Fp ${db_gateway} > "/root/server/backup/$folder_name/${db_gateway}.sql"

      	echo "Creating ${db_account} backup"
        pg_dump -U postgres -Fp ${db_account} > "/root/server/backup/$folder_name/${db_account}.sql"

        echo "$B BACKUP CREATED! > $folder_name $W"

    '';

    gsrestore = pkgs.writers.writeBashBin "gsrestore_db" ''
      export LC_ALL=C

      B="[40;36m"
      W="[40;37m"
      G="[40;32m"
      R="[40;31m"
      Y="[40;33m"
      P="[40;35m"

       echo "$P RESTORING BACKUP!$W"

       if [ -z "$2" ]; then
         echo "Please Use: restore <folder name ex: backup_2025_01_01_08_55_10>"
         exit 1
       fi

       if [ ! -d "/root/server/backup/$2" ]; then
         echo "Backup Folder Not Found"
         exit 1
       fi

       if [ "$(find /root/server/backup/"$2" -name "${db_members}.sql" -o -name "${db_gateway}.sql" -o -name "${db_account}.sql" | wc -l)" -ne 3 ]; then
         echo "Some Backup Files '${db_members}.sql, ${db_gateway}.sql, ${db_account}.sql' Not Found!"
         exit 1
       fi

      # stty -echo
      # read -rp "Enter CURRENT PostgreSQL Password: " db_pwd
      # stty echo
      echo ""
      export PGPASSWORD=${db_password}

      # service postgresql restart

       folder_name=$2

      echo "Restoring ${db_members} backup"
      psql -U postgres -c "DROP DATABASE ${db_members};"
      psql -U postgres -c "create database ${db_members} encoding '${db_encoding}' template template0;"
       psql -U postgres -d ${db_members} -f /root/server/backup/$folder_name/${db_members}.sql

      echo "Restoring ${db_gateway} backup"
      psql -U postgres -c "DROP DATABASE ${db_gateway};"
      psql -U postgres -c "create database ${db_gateway} encoding '${db_encoding}' template template0;"
       psql -U postgres -d ${db_gateway} -f /root/server/backup/$folder_name/${db_gateway}.sql

      echo "Restoring ${db_account} backup"
      psql -U postgres -c "DROP DATABASE ${db_account};"
      psql -U postgres -c "create database ${db_account} encoding '${db_encoding}' template template0;"
       psql -U postgres -d ${db_account} -f /root/server/backup/$folder_name/${db_account}.sql

       chmod -R 777 /root

       echo "$B BACKUP RESTORATION DONE! > $folder_name $W"

    '';
    gsrestart = pkgs.writers.writeBashBin "gsrestart" ''
      export LC_ALL=C

      sstop
      sleep 2
      sstart
    '';
    gsstatus = pkgs.writers.writeBashBin "gsstatus" ''
      export LC_ALL=C

      freemem=$(free -m | grep "Mem:" | awk '{print $4}')
      echo "${B} SERVER STATUS: ${Y}Memory Available: ${freemem} MB ${W}"
    '';
    gshelp = pkgs.writers.writeBashBin "gshelp" ''
      export LC_ALL=C
      echo "Game Server 'gs' commands to use"
      echo "gsstart - Start Sever"
      echo "gsstop - Stop Server"
      echo "gsrestart - Restart Server"
      echo "gsstatus - Show Server Memory Usage"
      echo "gsbackup - Create DB backup '${db_members}, ${db_account}, ${db_gateway} '"
      echo "gsrestore - Restore Backup  |create a backup in a folder like <folder name ex: backup_2025_01_17_02_55_10>"
      echo "gsclear - Clear Server Logs"
    '';
    gspatch = pkgs.writers.writeBashBin "gspatch" ''
      export LC_ALL=C
      in_patch ${server_address} ${patch_info}

    '';
  in [
    (writeShellScriptBin "gsstart" (builtins.readFile ./start.sh))
    (writeShellScriptBin "gsstop" (builtins.readFile ./stop.sh))
    (writeShellScriptBin "gsclear" (builtins.readFile ./clear.sh))
    (writeShellScriptBin "in_patch" (builtins.readFile ./patch.sh))
    gsrestore
    gsrestart
    gsbackup
    gsstatus
    gspatch
    gshelp
  ];
}
