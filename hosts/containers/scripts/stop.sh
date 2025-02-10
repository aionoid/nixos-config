#!/usr/bin/env bash

export LC_ALL=C

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
killall -9 WorldServer101
killall -9 ZoneServer101
killall -9 WorldServer102
killall -9 ZoneServer102
killall -9 WorldServer109
killall -9 ZoneServer109
sleep 1

freemem=$(free -m | grep "Mem:" | awk '{print $4}')
echo "${B} SERVER STOPPED! ${Y}Memory Available: ${freemem} MB ${W}"
