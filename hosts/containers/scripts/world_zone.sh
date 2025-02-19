#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <number>"
    echo "  <number>: A number from 1 to 8"
    exit 1
}

# Check if the input is provided and valid
if [ -z "$1" ] || ! [[ "$1" =~ ^[1-8]$ ]]; then
    usage
fi

# Get the input number
number=$1

# Define the server files
servers=("WorldServer" "ZoneServer")
server_root="/root/server"
server_files="$server_root/_files"

# Loop through each server file
for server in "${servers[@]}"; do
    # Create folders and files for numbers 1 to the input number
    for i in $(seq 1 "$number"); do
        destination_folder="$server_root/${server}10${i}/"
        destination_file="${server}10${i}"

        # Create the destination folder if it doesn't exist
        mkdir -p "$destination_folder"

        # Check if the file exists in the "patched" folder
        if [ -f "$server_files/patched/${server}" ]; then
            echo "Copying ${server} from $server_files/patched/ to ${destination_folder}"
            cp "$server_files/patched/${server}" "${destination_folder}${destination_file}"
        else
            # If not in patched/, check and copy from bin/
            if [ -f "$server_files/bin/${server}" ]; then
                echo "Copying ${server} from $server_files/bin/ to ${destination_folder}"
                cp "$server_files/bin/${server}" "${destination_folder}${destination_file}"
            else
                echo "Error: ${server} not found in patched/ or bin/"
            fi
        fi

        # Create setup.ini for WorldServer or ZoneServer
        if [ "$server" == "WorldServer" ]; then
            world_server_id="${i}0"  # Append 0 to the number (e.g., 1 → 10, 2 → 20, etc.)
            setup_ini_content="[WorldServer]
WorldServerID=10${world_server_id}"
            echo "$setup_ini_content" > "${destination_folder}setup.ini"
            echo "Created ${destination_folder}setup.ini"
        elif [ "$server" == "ZoneServer" ]; then
            zone_server_id="${i}1"  # Append 1 to the number (e.g., 1 → 11, 2 → 21, etc.)
            setup_ini_content="[ZoneServer]
ZoneServerID=10${zone_server_id}
ZoneServerLogLevel=2
ZoneServerAssert=0
GMToolPort=10320
CGIPort=20060
CGIKey=0KjaM85BjfqjA"
            echo "$setup_ini_content" > "${destination_folder}setup.ini"
            echo "Created ${destination_folder}setup.ini"
        fi
    done

    # Always create folder and file for number 9
    destination_folder="$server_root/${server}109/"
    destination_file="${server}109"

    # Create the destination folder if it doesn't exist
    mkdir -p "$destination_folder"

    # Check if the file exists in the "patched" folder
    if [ -f "$server_files/patched/${server}" ]; then
        echo "Copying ${server} from $server_files/patched/ to ${destination_folder}"
        cp "$server_files/patched/${server}" "${destination_folder}${destination_file}"
    else
        # If not in patched/, check and copy from bin/
        if [ -f "$server_files/bin/${server}" ]; then
            echo "Copying ${server} from $server_files/bin/ to ${destination_folder}"
            cp "$server_files/bin/${server}" "${destination_folder}${destination_file}"
        else
            echo "Error: ${server} not found in $server_files/patched/ or $server_files/bin/"
        fi
    fi

    # Create setup.ini for WorldServer or ZoneServer (number 9)
    if [ "$server" == "WorldServer" ]; then
        setup_ini_content="[WorldServer]
WorldServerID=1090"
        echo "$setup_ini_content" > "${destination_folder}setup.ini"
        echo "Created ${destination_folder}setup.ini"
    elif [ "$server" == "ZoneServer" ]; then
        setup_ini_content="[ZoneServer]
ZoneServerID=1091
ZoneServerLogLevel=2
ZoneServerAssert=0
GMToolPort=10920
CGIPort=20960
CGIKey=0KjaM85BjfqjA"
        echo "$setup_ini_content" > "${destination_folder}setup.ini"
        echo "Created ${destination_folder}setup.ini"
    fi
done

echo "Script completed!"
