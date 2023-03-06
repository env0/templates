#!/usr/bin/env bash

decode_base64() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}

decode_jwt(){
   decode_base64 $(echo -n $2 | cut -d "." -f $1) | jq .
}

decode_jwt 1 $ENV0_OIDC_TOKEN

# Decode JWT Payload
decode_jwt 2 $ENV0_OIDC_TOKEN
