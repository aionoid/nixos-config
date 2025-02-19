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
      echo "$B SERVER STATUS: $Y Memory Available: $freemem MB $W"
    '';
    gshelp = pkgs.writers.writeBashBin "gshelp" ''
      export LC_ALL=C
      echo "Game Server 'gs' commands to use"
      echo "gsstart - Start Sever"
      echo "gsstop - Stop Server"
      echo "gsrestart - Restart Server"
      echo "gsstatus - Show Server Memory Usage"
      echo "gsbackup - Create DB backup '${db_members}, ${db_account}, ${db_gateway} '"
      echo "gsrestore - Restore Backup  |create a backup in a folder like <folder name ex: backup_2025_03_04_12_45_00>"
      echo "gsclear - Clear Server Logs"
    '';
    gspatch = pkgs.writers.writeBashBin "gspatch" ''
      export LC_ALL=C
      in_patch "${server_address}" '${builtins.toJSON patch_info}'

    '';
    gsinstall = pkgs.writers.writeBashBin "gsinstall" ''
      #1. create folders
      cp_servers
      cp_world_zone 2
      gateway_server_setup="[Common]
      AccountDBIP=${server_address}
      AccountDBName=${db_gateway}
      AccountDBUser=postgres
      AccountDBPW=${db_password}
      BillingGatewayPort=5560
      HttpServerPort=7878
      "
      echo "$gateway_server_setup" > "/root/server/GatewayServer/setup.ini"             # Write the content to the file
      login_server_setup ="[LoginServer]
      LoginServerPort=6543"
      echo "$login_server_setup" > "/root/server/LoginServer/setup.ini"             # Write the content to the file
      ticket_server_setup = "TicketServerIP=127.0.0.1
      TicketServerPort=7777"
      echo "$ticket_server_setup" > "/root/server/TicketServer/setup.ini"             # Write the content to the file

      # Define the content to be written to each file
      content="# Cross World ID
      CrossWorldID=__CrossWorldID__
      # Territory World ID
      TerritoryWorldID=__TerritoryWorldID__
      # Colosseum World ID
      ColosseumWorldID=__ColosseumWorldID__
      "
      # Loop to create files config00.ini to config09.ini
      for i in {0..9}; do
          filename=$(printf "config%02d.ini" "$i")  # Format the filename with leading zero
          echo "$content" > "/root/server/$filename"             # Write the content to the file
          echo "Created $filename"
      done
      echo "created config0N.ini files successfully!"
      #2. copy bin/bin_patched files to there folders
      #3. create config files in bins folders
      #4. edit config.ini and setup.ini files
    '';
  in [
    (writeShellScriptBin "gsstart" (builtins.readFile ./start.sh))
    (writeShellScriptBin "gsstop" (builtins.readFile ./stop.sh))
    (writeShellScriptBin "gsclear" (builtins.readFile ./clear.sh))
    (writeShellScriptBin "in_patch" (builtins.readFile ./patch.sh))
    (writeShellScriptBin "cp_servers" (builtins.readFile ./other_servers.sh))
    (writeShellScriptBin "cp_world_zone" (builtins.readFile ./world_zone.sh))
    gsrestore
    gsrestart
    gsinstall
    gsbackup
    gsstatus
    gspatch
    gshelp
  ];
}
