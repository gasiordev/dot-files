#!/bin/bash

CACHE_FILE=~/.secretcache/.naws.sh.cache

do_refresh=no;

for var in "$@"
do
  if [[ "x$var" == "x--refresh" ]]; then
    do_refresh=yes
  fi
done

if [[ ! -f "$CACHE_FILE" || "$do_refresh" == "yes" ]]; then
  #aws ec2 describe-instances --max-items=150 --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value,PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress,Subnet:SubnetId}' --output=table > "$CACHE_FILE";
  aws ec2 describe-instances --max-items=150 --output=json > "$CACHE_FILE";
fi

if [[ -f "$CACHE_FILE" ]]; then
  for i in `cat "$CACHE_FILE" | jq -c '.Reservations[].Instances[] | select(.State.Name=="running")' | base64`; do
    echo ${i} | base64 --decode | jq -r '[.PrivateIpAddress, if .PublicIpAddress == null then "-" else .PublicIpAddress end, (.Tags[] | select(.Key=="Name") | .Value)]' | jq -r 'join(" ")' | awk '{ printf "%-16s %-16s %-50s\n", $1, $2, $3}'
  done
else
  echo "Cache file not found. There might a problem with generating it"
  exit 1
fi
