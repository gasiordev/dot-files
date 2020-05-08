#!/bin/bash

CACHE_FILE=~/.secretcache/.naws.sh

do_refresh=no;
profile="default";

for var in "$@"
do
  if [[ "x$var" == "x--refresh" ]]; then
    do_refresh=yes
  fi
  if [[ "x$var" =~ ^x--profile=[a-z0-9]+$ ]]; then
    profile=${var/--profile=/}
  fi
done

profile_cache_file="$CACHE_FILE"."$profile"

if [[ ! -f "$profile_cache_file" || "$do_refresh" == "yes" ]]; then
  aws --profile=$profile ec2 describe-instances --max-items=150 --output=json > "$profile_cache_file";
fi

if [[ -f "$profile_cache_file" ]]; then
  for i in `cat "$profile_cache_file" | jq -c '.Reservations[].Instances[] | select(.State.Name=="running")' | base64`; do
    echo ${i} | base64 --decode | jq -r '[.PrivateIpAddress, if .PublicIpAddress == null then "-" else .PublicIpAddress end, (.Tags[] | select(.Key=="Name") | .Value)]' | jq -r 'join(" ")' | awk '{ printf "%-16s %-16s %-50s\n", $1, $2, $3}'
  done
else
  echo "Cache file not found. There might a problem with generating it"
  exit 1
fi
