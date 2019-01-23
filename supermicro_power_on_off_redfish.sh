SERVER="my-server"
USER="ADMIN"
PASS="ADMIN"

# ON
curl -si -u $USER:$PASS -k -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{"Action": "Reset", "ResetType": "On"}' https://$SERVER/redfish/v1/Systems/1/Actions/ComputerSystem.Reset

#OFF
curl -si -u $USER:$PASS -k -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{"Action": "Reset", "ResetType": "ForceOff"}' https://$SERVER/redfish/v1/Systems/1/Actions/ComputerSystem.Reset

# Other methods available:
curl -si -u $USER:$PASS -k -XGET https://$SERVER/redfish/v1/Systems/1/

    "Actions": {
        "#ComputerSystem.Reset": {
            "target": "/redfish/v1/Systems/1/Actions/ComputerSystem.Reset",
            "ResetType@Redfish.AllowableValues": [
                "On",
                "ForceOff",
                "GracefulShutdown",
                "GracefulRestart",
                "ForceRestart",
                "Nmi",
                "ForceOn"
            ]
# http://redfish.dmtf.org/schemas/DSP0266_1.0.html
