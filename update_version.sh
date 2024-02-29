#!/bin/bash 
#  ------------------------------------------------------------------*
# @file    update_version.sh
# @date    2024-01-13
# @author  bjs
# @brief   
#  ------------------------------------------------------------------*

echo "update Apps Package,need about 2 seconds ..."

#  ------------------------------------------------------------------
# @brief       update release
#  ------------------------------------------------------------------*/
echo "update release ..."
cp -rf ./bJS_terminal /home/
ln -sf /home/bJS_terminal/lib/bJS_terminal.conf /etc/ld.so.conf.d/
sudo ldconfig

#  ------------------------------------------------------------------
# @brief      update service
#  ------------------------------------------------------------------*/
echo "update service ..."
sudo cp ./osp-local.service /lib/systemd/system/
sudo cp ./osp.local /etc/

#  ------------------------------------------------------------------
# @brief      update release
#  ------------------------------------------------------------------*/
systemctl enable osp-local.service
#systemctl start osp-local.service
#systemctl restart osp-local.service
#*********************************************END OF FILE**********************#
