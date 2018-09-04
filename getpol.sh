#!/bin/bash

export APIKEY="'x-api-key: b86d2ec293faae411c31b3160819c591'"
export policiesURL="https://api.newrelic.com/v2/alerts_policies.json"
export contenttype="'content-type: application/json'"

#echo "curl --request GET --url $policiesURL --header $contenttype --header $APIKEY " |sh

policies=`curl --request GET --url $policiesURL   --header $contenttype --header 'x-api-key: b86d2ec293faae411c31b3160819c591'  |jq -r -c '. | {policies: .policies[].name}' | cut -d '"' -f4 `


for i in $policies; do

if [[ $i == "PRO-StandardPrueba1" ]];then

 echo "La politica PRO-Standard ya existe"

fi
done

#if [[ $policyexist -eq 1 ]]; then
#curl --request POST \
 # --url https://api.newrelic.com/v2/alerts_policies.json \
 # --header 'content-type: application/json' \
 # --header 'x-api-key: b86d2ec293faae411c31b3160819c591' \
 # --data '{
 # "policy": {
 #   "incident_preference": "PER_CONDITION_AND_TARGET",
 #   "name": "PRO-StandardPrueba1"
 # }
#}'
#fi

