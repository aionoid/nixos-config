#!/bin/bash

# Define the server files
servers=("GatewayServer" "TicketServer" "LoginServer" "MissionServer")
server_root="/root/server"
server_files="$server_root/_files"

# Loop through each server file
for server in "${servers[@]}"; do
    # Define the destination folder
    destination_folder="$server_root/${server}/"

    # Create the destination folder if it doesn't exist
    mkdir -p "$destination_folder"

    # Check if the file exists in the "patched" folder
    if [ -f "$server_files/patched/${server}" ]; then
        echo "Copying ${server} from $server_files/patched/ to ${destination_folder}"
        cp "$server_files/patched/${server}" "${destination_folder}"
    else
        # If not in patched/, check and copy from bin/
        if [ -f "$server_files/bin/${server}" ]; then
            echo "Copying ${server} from $server_files/bin/ to ${destination_folder}"
            cp "$server_files/bin/${server}" "${destination_folder}"
        else
            echo "Error: ${server} not found in patched/ or bin/"
        fi
    fi
done

echo "Script completed!"
