#
#  ------------------------------------------------------------------*
# @file    start_release.sh
# @date    2024-01-12
# @author  bjs
# @brief   
#  ------------------------------------------------------------------*

let Sys_uptime=0
video_product="534d"
#  ------------------------------------------------------------------
# @brief       determine ,route
#  ------------------------------------------------------------------*/
video_usb_bus=$(lsusb | grep $video_product | awk '{print $2}')
video_usb_device=$(lsusb | grep $video_product | awk '{print $4}' | tr -d ':')
##echo $video_usb_bus
##echo $video_usb_device
./usb-reset /dev/bus/usb/$video_usb_bus/$video_usb_device
echo "reset video usb device..."
#*********************************************END OF FILE**********************#

