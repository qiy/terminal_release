sudo systemctl stop todeskd.service
sleep 1
rm  /opt/todesk/config/todeskd.conf
sleep 1
sudo systemctl start todeskd.service
sleep 1
sudo systemctl restart todeskd.service
sleep 1
todesk
sleep 1
