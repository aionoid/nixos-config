#!/usr/bin/env bash

export LC_ALL=C

number_of_ch="$1"

B="[40;36m"
W="[40;37m"
# G="[40;32m"
R="[40;31m"
Y="[40;33m"
 # P="[40;35m"

echo "${R} STOPPING SERVER!${W}"
killall -9 LoginServer
killall -9 GatewayServer
killall -9 TicketServer
killall -9 MissionServer
for i in $(seq 1 "$number_of_ch"); do
  killall -9 "WorldServer10$i"
  killall -9 "ZoneServer10$i"
# killall -9 WorldServer102
# killall -9 ZoneServer102
done
killall -9 WorldServer109
killall -9 ZoneServer109
sleep 1

freemem=$(free -m | grep "Mem:" | awk '{print $4}')
echo "${B} SERVER STOPPED! ${Y}Memory Available: ${freemem} MB ${W}"
