#!/bin/bash

USERCOUNT=50
USERPREFIX=evals%02d
KEYCLOAK_ADDR=http://keycloak-workspaces.apps.sso-3e67.open.redhat.com
KEYCLOAK_USER=admin
KEYCLOAK_PASS=admin
KEYCLOAK_REALM=codeready
KEYCLOAK_USER_PASS=openshift
KEYCLOAK_REALM=codeready
CODEREADY_SERVER_ADDR=http://codeready-workspaces.apps.sso-3e67.open.redhat.com

KEYCLOAK_TOKEN=$(curl -s -d "username=${KEYCLOAK_USER}&password=${KEYCLOAK_PASS}&grant_type=password&client_id=admin-cli" \
  -X POST ${KEYCLOAK_ADDR}/auth/realms/master/protocol/openid-connect/token | \
  jq  -r '.access_token')

echo $KEYCLOAK_TOKEN

usernames=$(awk 'BEGIN { for (i=11; i<='$USERCOUNT'; i++) printf("'$USERPREFIX' ", i) }')
for value in $usernames
do 
    curl -v -H "Authorization: Bearer ${KEYCLOAK_TOKEN}" -H "Content-Type:application/json" -d '{"username":"'${value}'","enabled":true,"emailVerified": true,"firstName": "'${value}'","lastName": "Workshopper","email": "'${value}'@no-reply.com", "credentials":[{"type":"password","value":"'${KEYCLOAK_USER_PASS}'","temporary":false}]}' -X POST "${KEYCLOAK_ADDR}/auth/admin/realms/${KEYCLOAK_REALM}/users"
    echo "user creation requested for "$value
done



echo "creating workspaces"
for evals in $usernames
do 

KEYCLOAK_USER_TOKEN=$(curl -s -d "username=${evals}&password=${KEYCLOAK_USER_PASS}&grant_type=password&client_id=admin-cli" -X POST ${KEYCLOAK_ADDR}/auth/realms/${KEYCLOAK_REALM}/protocol/openid-connect/token | jq  -r '.access_token')

echo $KEYCLOAK_USER_TOKEN

    TMPWORK=$(mktemp)
    sed 's/WORKSPACENAME/wksp-'${evals}'/g' workspace.json > $TMPWORK

    curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' \
    --header "Authorization: Bearer ${KEYCLOAK_USER_TOKEN}" -d @${TMPWORK} \
    "${CODEREADY_SERVER_ADDR}/api/workspace?start-after-create=true&namespace=${evals}"
    rm -f $TMPWORK
    echo "workspace creation requested for "$evals "server: "$KEYCLOAK_ADDR
done
