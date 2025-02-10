#!/usr/bin/env bash

export LC_ALL=C

B="[40;36m"
W="[40;37m"
G="[40;32m"
# R="[40;31m"
Y="[40;33m"
# P="[40;35m"

  echo "${G} STARTING SERVER!${W}"
  echo -ne "${B}[>         ] TicketServer       \r${W}"
  sleep 1
  cd ~/server/TicketServer/ || return
  chmod 777 ./*
  ./TicketServer -p 7777 &>/dev/null &
  echo -ne "${B}[->        ] GatewayServer       \r${W}"
  sleep 3
  cd ~/server/GatewayServer/ || return
  chmod 777 ./*
  ./GatewayServer &>/dev/null &
  echo -ne "${B}[-->       ] LoginServer       \r${W}"
  sleep 4
  cd ~/server/LoginServer/ || return
  chmod 777 ./*
  ./LoginServer &>/dev/null &
  echo -ne "${B}[--->      ] MissionServer       \r${W}"
  sleep 3
  cd ~/server/MissionServer/ || return
  chmod 777 ./*
  ./MissionServer &>/dev/null &
  echo -ne "${B}[---->     ] WorldServer101       \r${W}"
  sleep 3
  cd ~/server/WorldServer101/ || return
  chmod 777 ./*
  ./WorldServer101 &>/dev/null &
  echo -ne "${B}[----->    ] ZoneServer101       \r${W}"
  sleep 5
  cd ~/server/ZoneServer101/ || return
  chmod 777 ./*
  ./ZoneServer101 &>/dev/null &
  echo -ne "${B}[------>   ] WorldServer102       \r${W}"
  sleep 4
  cd ~/server/WorldServer102/ || return
  chmod 777 ./*
  ./WorldServer102 &>/dev/null &
  echo -ne "${B}[------->  ] ZoneServer102       \r${W}"
  sleep 5
  cd ~/server/ZoneServer102/ || return
  chmod 777 ./*
  ./ZoneServer102 &>/dev/null &
  echo -ne "${B}[--------> ] WorldServer109       \r${W}"
  sleep 4
  cd ~/server/WorldServer109/ || return
  chmod 777 ./*
  ./WorldServer109 &>/dev/null &
  echo -ne "${B}[--------->] ZoneServer109       \r${W}"
  sleep 5
  cd ~/server/ZoneServer109/ || return
  chmod 777 ./*
  ./ZoneServer109 &>/dev/null &

  freemem=$(free -m | grep "Mem:" | awk '{print $4}')
  echo "${B} SERVER STARTED! ${Y}Memory Available: ${freemem} MB ${W}"

