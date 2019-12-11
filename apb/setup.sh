#!/bin/bash

USERCOUNT=2
USERPREFIX=evals

LAUNCHER_SSO_ADDR=https://launcher-sso-launcher.apps.sso-3e67.open.redhat.com
LAUNCHER_ADMIN_USER=admin
LAUNCHER_ADMIN_PASS=wwCnmH5e8qWlRp4E4Jh4lqoGdPXUy0Fu
LAUNCHER_REALM=launcher_realm

OC_USER_PASS=Abt7MjWMb8v4ECS

LAUNCHER_SSO_TOKEN=$(curl -s -d "username=${LAUNCHER_ADMIN_USER}&password=${LAUNCHER_ADMIN_PASS}&grant_type=password&client_id=admin-cli" \
  -X POST $LAUNCHER_SSO_ADDR/auth/realms/master/protocol/openid-connect/token | \
  jq  -r '.access_token')

echo $LAUNCHER_SSO_TOKEN


usernames=$(awk 'BEGIN { for (i=1; i<='$USERCOUNT'; i++) printf("'$USERPREFIX'%02d ", i) }')
echo "Creating Users"
for value in $usernames
do 
    USERNAME=$value
    FIRSTNAME=$value
    LASTNAME=Workshopper
    echo $value
    curl -v -H "Authorization: Bearer ${LAUNCHER_SSO_TOKEN}" -H "Content-Type:application/json" -d '{"username":"'${USERNAME}'","enabled":true,"emailVerified": true,"firstName": "'${USERNAME}'","lastName": "Developer","email": "'${USERNAME}'@no-reply.com", "credentials":[{"type":"password","value":"'${OC_USER_PASS}'","temporary":false}]}' -X POST "${LAUNCHER_SSO_ADDR}/auth/admin/realms/${LAUNCHER_REALM}/users"

done

echo "creating workspaces"
for value in $usernames
do 
    USERNAME=$value
    LAUNCHER_USER_TOKEN=$(curl -s -d "username=${USERNAME}&password=${OC_USER_PASS}&grant_type=password&client_id=admin-cli" \
        -X POST $LAUNCHER_SSO_ADDR/auth/realms/$LAUNCHER_REALM/protocol/openid-connect/token | jq  -r '.access_token')

    TMPWORK=$(mktemp)
    sed 's/WORKSPACENAME/WORKSPACE'${i}'/g' workspace.json > $TMPWORK

    curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' \
    --header "Authorization: Bearer ${LAUNCHER_USER_TOKEN}" -d @${TMPWORK} \
    "${CODEREADY_SERVER_ADDR}/api/workspace?start-after-create=true&namespace=wksp-${USERNAME}"
    rm -f $TMPWORK
done
