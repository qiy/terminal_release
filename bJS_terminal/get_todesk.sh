#  ------------------------------------------------------------------*
# @file    check_urb_status.sh
# @date    2023-08-24
# @author  jichun.feng
# @brief   check 5g net port status, recovery port when abnormal
#  ------------------------------------------------------------------*
# let Sys_uptime=0
#  ------------------------------------------------------------------
# @brief       determine the abnormal network port,then reset,route
#  ------------------------------------------------------------------*/
todesk_id=$(cat /opt/todesk/config/todeskd.conf | grep id | awk '{print $3}')
todesk_pass64=$(cat /opt/todesk/config/todeskd.conf | grep temppassword | awk '{print $3}')
todesk_pass=$(echo -n $todesk_pass64 | base64 -d)
echo "$todesk_id"
echo "$todesk_pass"
