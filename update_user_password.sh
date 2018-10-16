#!/usr/bin/env bash
ADMIN_USER="admin_user"
ADMIN_PASS="admin_pass"
USER_TO_CHANGE_PWD="admin_user"
USER_PASS="admin_new_pass"
SERVER=$1


Main(){
  # creating the temporary payload
	PAYLOAD=temp_payload_$(echo $RANDOM).json
	cat payload_template_update_password.json > $PAYLOAD
	sed -i "s/NEWUSER/$USER/g" $PAYLOAD
	sed -i "s/NEWPASS/$USER_PASS/g" $PAYLOAD

	# pulls the list of accounts and find the ID of the USER_TO_CHANGE_PWD account
        ACCOUNTS=$(curl -s -k -u ${ADMIN_USER}:${ADMIN_PASS} -X GET https://${SERVER}/redfish/v1/AccountService/Accounts/ | jq -r .Members|grep Accounts | tr -d \"  |cut -d \/ -f6)
        for ACCOUNT_ID in $ACCOUNTS;do
                USERNAME=$(curl -s -k -u ${ADMIN_USER}:${ADMIN_PASS} -X GET https://${SERVER}/redfish/v1/AccountService/Accounts/$ACCOUNT_ID/ | jq -r .UserName)
                if [ "$USERNAME" == "$USER_TO_CHANGE_PWD" ];then
                        echo "Account ID $ACCOUNT_ID is $USER_TO_CHANGE_PWD, updating password."
			curl -k -D- -u ${ADMIN_USER}:${ADMIN_PASS} -X PATCH --data @$PAYLOAD -H "Content-Type: application/json" https://${SERVER}/redfish/v1/AccountService/Accounts/$ACCOUNT_ID/
                fi
	done


	rm -f ${PAYLOAD:=foo}
}

Help(){
	echo "$0 ilo_ip"
	exit 0
}

if [ -z "$SERVER" ];then
        Help
else
        Main
fi
