#!/bin/bash
TOKEN=$(cat k8s-setup/userInfraToken)
INFRA=$(cat k8s-setup/user-infra.json)
#echo $TOKEN
#echo $INFRA

curl -v --location --request POST '192.168.50.10:30000/api/v1/infrastructure' --header "x-access-token: $TOKEN" --header 'Content-Type: application/json' --data-raw "$INFRA"
