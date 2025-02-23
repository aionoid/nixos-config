#!/usr/bin/env bash

export LC_ALL=C

number_of_ch="$1"

B="[40;36m"
W="[40;37m"
G="[40;32m"
# R="[40;31m"
Y="[40;33m"
# P="[40;35m"

echo "${G} STARTING SERVER!${W}"
echo -ne "${B}[>         ] TicketServer       \r${W}"
sleep 1
cd /root/server/TicketServer/ || return
chmod 777 ./*
./TicketServer -p 7777 &>/dev/null &
echo -ne "${B}[->        ] GatewayServer       \r${W}"
sleep 3
cd /root/server/GatewayServer/ || return
chmod 777 ./*
./GatewayServer &>/dev/null &
echo -ne "${B}[-->       ] LoginServer       \r${W}"
sleep 4
cd /root/server/LoginServer/ || return
chmod 777 ./*
./LoginServer &>/dev/null &
echo -ne "${B}[--->      ] MissionServer       \r${W}"
sleep 3
cd /root/server/MissionServer/ || return
chmod 777 ./*
./MissionServer &>/dev/null &
##---> for world/zone servers

for i in $(seq 1 "$number_of_ch"); do
  echo -ne "${B}[---->     ] WorldServer10${i}       \r${W}"
  sleep 2
  cd "/root/server/WorldServer10${i}/" || return
  chmod 777 ./*
  ./WorldServer10${i} &>/dev/null &
  sleep 2
  echo -ne "${B}[----->    ] ZoneServer10${i}       \r${W}"
  sleep 3
  cd "/root/server/ZoneServer10${i}/" || return
  chmod 777 ./*
  ./ZoneServer10${i} &>/dev/null &
  sleep 2
  # echo -ne "${B}[------>   ] WorldServer102       \r${W}"
  # sleep 4
  # cd /root/server/WorldServer102/ || return
  # chmod 777 ./*
  # ./WorldServer102 &>/dev/null &
  # echo -ne "${B}[------->  ] ZoneServer102       \r${W}"
  # sleep 5
  # cd /root/server/ZoneServer102/ || return
  # chmod 777 ./*
  # ./ZoneServer102 &>/dev/null &
done
##<--- end max 8
echo -ne "${B}[--------> ] WorldServer109       \r${W}"
sleep 2
cd /root/server/WorldServer109/ || return
chmod 777 ./*
./WorldServer109 &>/dev/null &
sleep 2
echo -ne "${B}[--------->] ZoneServer109       \r${W}"
sleep 2
cd /root/server/ZoneServer109/ || return
chmod 777 ./*
./ZoneServer109 &>/dev/null &
sleep 2

freemem=$(free -m | grep "Mem:" | awk '{print $4}')
echo "${B} SERVER STARTED! ${Y}Memory Available: ${freemem} MB ${W}"

