#
#  ------------------------------------------------------------------*
# @file    start_release.sh
# @date    2024-01-12
# @author  bjs
# @brief   
#  ------------------------------------------------------------------*

echo "running release version 0.0.0.1 ..."
let Sys_uptime=0
#  ------------------------------------------------------------------
# @brief       determine ,route
#  ------------------------------------------------------------------*/
status_monitor()
{   
	Sys_uptime=$(cat /proc/uptime | awk '{print $1}')
    echo "Current system runtime:$Sys_uptime"
}
#  ------------------------------------------------------------------
  # @brief       loop reading device node
#  ------------------------------------------------------------------*/
cd /home/bJS_terminal/
taskset -c 2 ./smart_home 123 0 &
while [ 1 ]
do
    status_monitor > ./run_time.log
    sleep 1
##    ./ws_client user_name device_type &
done
#*********************************************END OF FILE**********************#

