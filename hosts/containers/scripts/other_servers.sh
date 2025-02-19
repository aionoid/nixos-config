#!/bin/bash

# Define the server files
servers=("GatewayServer" "TicketServer" "LoginServer")

# Loop through each server file
for server in "${servers[@]}"; do
    # Define the destination folder
    destination_folder="${server}/"

    # Create the destination folder if it doesn't exist
    mkdir -p "$destination_folder"

    # Check if the file exists in the "patched" folder
    if [ -f "patched/${server}" ]; then
        echo "Copying ${server} from patched/ to ${destination_folder}"
        cp "patched/${server}" "${destination_folder}"
    else
        # If not in patched/, check and copy from bin/
        if [ -f "bin/${server}" ]; then
            echo "Copying ${server} from bin/ to ${destination_folder}"
            cp "bin/${server}" "${destination_folder}"
        else
            echo "Error: ${server} not found in patched/ or bin/"
        fi
    fi
done

echo "Script completed!"
