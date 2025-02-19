#!/usr/bin/env bash

# Function to convert an IP address to hex (first three octets)
ip_to_hex() {
    local ip="$1"
    IFS='.' read -r o1 o2 o3 _ <<< "$ip"
    server_ip="$o1.$o2.$o3.0"

    hex_ip=""

    for char in $(echo "$server_ip" | grep -o .); do
      hex_ip+=$(printf '%02x' "'$char")
    done

    while [ ${#hex_ip} -lt 30 ]; do
      hex_ip+="00"
    done
    printf "%s" "$hex_ip"
}

ip_to_hex_local() {
    local ip="$1"
    hex_ip_local=""
    IFS='.' read -r o1 o2 _ _ <<< "$ip"

    server_ip_local="$o1.$o2."

    for char in $(echo "$server_ip_local" | grep -o .); do
      hex_ip_local+=$(printf '%02x' "'$char")
    done

    while [ ${#hex_ip_local} -lt 16 ]; do
      hex_ip_local+="00"
    done
    printf "%s" "$hex_ip_local"
}

# example of a nix attribute set in json 
# {
#  "WorldServer": {
#    "global": [
#      "0x3E2C27" # Offset
#    ]
#  },
#  "ZoneServer": {
#    "global": [
#      "0x14D1FA",
#      "0x152007"
#    ],
#    "local": [
#      "0x16AE07"
#    ]
#  }
# }

# Main script
main() {
    # INFO: servers input and use builtins.toJSON in the nix script
    # local servers="{\"WorldServer\":{\"global\":[\"0x3E2C27\"]},\"ZoneServer\":{\"global\":[\"0x14D1FA\",\"0x152007\"],\"local\":[\"0x16AE07\"]}}"
    local ip="$1"
    local servers="$2"
    local bin_patched="/root/server/_files/patched"
    local bin_folder="/root/server/_files/bin"
    mkdir -p $bin_patched

    clear
    # Convert the first three octets of the IP to hex
    local hex_ip
    local hex_ip_local

    hex_ip=$(ip_to_hex "$ip")
    hex_ip_local=$(ip_to_hex_local "$ip")

    local ip_bytes
    local ip_local_bytes

    ip_bytes=$(echo "$hex_ip" | sed 's/\(..\)/\\\x\1/g')
    ip_local_bytes=$(echo "$hex_ip_local" | sed 's/\(..\)/\\\x\1/g')

    ##################
    # Iterate over the servers and their offset types (local/global)
    for server in $(echo "$servers" | jq -r 'keys[]'); do
        echo "Coping file $server to $bin_patched folder ..."
        cp -f "${bin_folder}/${server}" "${bin_patched}/${server}"

        echo "Patching $server..."
        # Patch local offsets
        local local_offsets
        local_offsets=$(echo "$servers" | jq -r ".$server.local[]?")
        for offset in $local_offsets; do
            echo "  Patching LOCAL  IP offset $offset with $hex_ip_local..."
            # echo -n "$hex_local" | xxd -r -p | dd of="$server" bs=1 seek="$((offset))" conv=notrunc
            echo -en "$ip_local_bytes" | dd of="${bin_patched}/${server}" bs=1 seek=$((0x$offset)) count=${#ip_local_bytes} conv=notrunc >/dev/null 2>&1
        done

        # Patch global offsets
        local global_offsets
        global_offsets=$(echo "$servers" | jq -r ".$server.global[]?")
        for offset in $global_offsets; do
            echo "  Patching GLOBAL IP offset $offset with $hex_ip..."
            # echo -n "$hex_global" | xxd -r -p | dd of="$server" bs=1 seek="$((offset))" conv=notrunc
            echo -en "$ip_bytes" | dd of="${bin_patched}/${server}" bs=1 seek=$((0x$offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
        done
    done
    #
    # echo -en "$ip_bytes" | dd of="${gateway_fb}/${gateway_fb}" bs=1 seek=$((0x$gateway_offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
    # echo -en "$ip_bytes" | dd of="${login_fb}/${login_fb}" bs=1 seek=$((0x$login_offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
    # echo -en "$ip_bytes" | dd of="${mission_fb}/${mission_fb}" bs=1 seek=$((0x$mission_offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
    # echo -en "$ip_bytes" | dd of="${ticket_fb}/${ticket_fb}" bs=1 seek=$((0x$ticket_offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
    # echo -en "$ip_bytes" | dd of="${bin_folder}/${world_bin}" bs=1 seek=$((0x$world_offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
    # echo -en "$ip_bytes" | dd of="${bin_folder}/${zone_bin}" bs=1 seek=$((0x$zone_offset)) count=${#ip_bytes} conv=notrunc >/dev/null 2>&1
    #
    # cp -f ${bin_folder}/${world_bin} ${world101_fb}/${world101_fb}
    # cp -f ${bin_folder}/${world_bin} ${world102_fb}/${world102_fb}
    # cp -f ${bin_folder}/${world_bin} ${world109_fb}/${world109_fb}
    # cp -f ${bin_folder}/${zone_bin} ${zone101_fb}/${zone101_fb}
    # cp -f ${bin_folder}/${zone_bin} ${zone102_fb}/${zone102_fb}
    # cp -f ${bin_folder}/${zone_bin} ${zone109_fb}/${zone109_fb}

    echo "Patching complete!"
}

# Run the script
main "$@"

