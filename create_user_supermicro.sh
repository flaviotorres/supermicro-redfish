#!/usr/bin/env bash
ADMIN_USER="admin_username"
ADMIN_PASS="admin_pass"
USER="new_username"
USER_PASS="new_user_pas"
SERVER=$1


Main(){
  # creating the temporary payload
	PAYLOAD=temp_payload_$(echo $RANDOM).json
	cat payload_template.json > $PAYLOAD
	sed -i "s/NEWUSER/$USER/g" $PAYLOAD
	sed -i "s/NEWPASS/$USER_PASS/g" $PAYLOAD

	curl -k -D- -u ${ADMIN_USER}:${ADMIN_PASS} -X POST --data @$PAYLOAD -H "Content-Type: application/json" https://${SERVER}/redfish/v1/AccountService/Accounts/

	rm -f ${PAYLOAD:=foo}
}

Help(){
	echo "$0 server_ip"
	exit 0
}

if [ -z "$SERVER" ];then
        Help
else
        Main
fi
