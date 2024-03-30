sudo systemctl stop todeskd.service
rm  /opt/todesk/config/todeskd.conf
sudo systemctl start todeskd.service
sudo systemctl restart todeskd.service
todesk
