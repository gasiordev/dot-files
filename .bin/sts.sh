#!/bin/bash

function invalid_args() {
  echo "Error: Invalid or missing argument"
  echo "Syntax: sts.sh ROLE_ARN SESSION_NAME"
  exit 1
}

role_arn=$1
session_name=$2

if [[ "x$role_arn" == "x" ]]; then
  invalid_args
fi

if [[ "x$session_name" == "x" ]]; then
  invalid_args
fi

aws sts assume-role --role-arn=$role_arn --role-session-name=$session_name | grep "AccessKeyId\|SecretAccessKey\|SessionToken" | sed 's/^ *//g' | sed 's/"AccessKeyId": /export AWS_ACCESS_KEY_ID=/g' | sed 's/"SecretAccessKey": /export AWS_SECRET_ACCESS_KEY=/g' | sed 's/"SessionToken": /export AWS_SESSION_TOKEN=/g' | sed 's/,$//g'

