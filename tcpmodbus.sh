#!/bin/sh
echo "----- start download plugin serialmodbus rtu -------"
echo "----- create folder -------"
mkdir -p /home/cudo/squash-agent/plugins
chmod -R 755 /home/cudo/squash-agent/plugins
cd /home/cudo/squash-agent/plugins/

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id= 1MRd2uL2iO9lYX\-LneMstH2TISSaUxZr9' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1MRd2uL2iO9lYX-LneMstH2TISSaUxZr9" -O tcpmodbus.tar && rm -rf /tmp/cookies.txt
tar xvf tcpmodbus.tar
rm -rf tcpmodbus.tar
cd /home/cudo/squash-agent/plugins/tcpmodbus
find /home/cudo/squash-agent/plugins/tcpmodbus -type f -exec chmod -R 755 {} \;
rm -rf /usr/lib/systemd/system/tcpmodbus.service

touch /usr/lib/systemd/system/tcpmodbus.service
printf "[Unit]\nDescription=Squash - PLUGIN - MODBUS TCP/IP\n[Service]\nType=simple\nRestart=always\nRestartSec=5s\nExecStart=/home/cudo/squash-agent/plugins/tcpmodbus/tcpmodbus\nWorkingDirectory=/home/cudo/squash-agent/plugins/tcpmodbus/\n[Install]\nWantedBy=multi-user.target" >/usr/lib/systemd/system/tcpmodbus.service
cp /home/cudo/squash-agent/plugins/snmp/license.lic /home/cudo/squash-agent/plugins/tcpmodbus/
systemctl start tcpmodbus.service
systemctl enable tcpmodbus.service