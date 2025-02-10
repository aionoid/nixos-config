#!/usr/bin/env bash

export LC_ALL=C

# B="[40;36m"
W="[40;37m"
# G="[40;32m"
# R="[40;31m"
# Y="[40;33m"
P="[40;35m"

echo "$P CLEANING LOGS! $W"

cat /dev/null >/var/log/syslog
cat /dev/null >/var/log/wtmp
cat /dev/null >/var/log/maillog
cat /dev/null >/var/log/messages
cat /dev/null >/var/log/openwebmail.log
cat /dev/null >/var/log/maillog
cat /dev/null >/var/log/secure

find . -name "*.log.*" -type f -print -exec rm -rf {} \;

