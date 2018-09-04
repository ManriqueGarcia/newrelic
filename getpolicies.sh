#!/bin/bash

## API VAR ##
API_KEY="b86d2ec293faae411c31b3160819c591"
policiesURL="https://api.newrelic.com/v2/alerts_policies.json"
contenttype="'content-type: application/json'"
listpolicies=""

## Check if curl is installed 

if [ ! -x /usr/bin/curl ]; then
  echo "Please install curl"
  exit 1
fi

## Check if jq is installed
if [ ! -x /usr/bin/jq ]; then
  echo "Please install jq"
  exit 1
fi

## Check if python is installed
if [ ! -x /usr/bin/python ]; then
  echo "Please install python"
  exit 1
fi

## POLICIES FUNCTION


policyexist=0  
listpolicies=$(curl -X GET 'https://api.newrelic.com/v2/alerts_policies.json' -H "X-Api-Key: b86d2ec293faae411c31b3160819c591" -s -G -d "filter[name]=PRO-Standard" |jq '.policies[] .name')

## Check if policy exists
echo $listpolicies
echo "Checking if policy exist"
echo "------------------------"
for i in $listpolicies; do
  if [[ $i == '"PRO-Standard"' ]];then
  echo "ERROR: PRO-Standard policy exist"
  echo "--------------------------------"
  echo "Policies: $listpolicies"
  policyexist=1
  fi
done

## Create policy if no exist

if [[ $policyexist -eq 0 ]]; then
echo "Policy PRO-Standard doesn't exist"
echo "----------------------------------"
echo "Creating Policy"
curl -s -i --request POST --url https://api.newrelic.com/v2/alerts_policies.json --header 'content-type: application/json' --header 'x-api-key: b86d2ec293faae411c31b3160819c591' \
  --data '{
  "policy": {
    "incident_preference": "PER_CONDITION_AND_TARGET",
    "name": "PRO-Standard"
  }
}'
fi

