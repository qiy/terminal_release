#
#  ------------------------------------------------------------------*
# @file    start_release.sh
# @date    2024-01-12
# @author  bjs
# @brief   
#  ------------------------------------------------------------------*

echo "running release version 0.0.0.1 at 20240417..."
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
brctl delif brtap eth0
brctl delif brtap enx000ec677d959
brctl delbr brtap

#start openvpn
openvpn --config /etc/openvpn/client.ovpn &
sleep 10
brctl addbr brtap
brctl addif brtap tap0
brctl addif brtap enx000ec677d959
ifconfig brtap 10.8.0.2 up
ifconfig tap0 0.0.0.0 up

# start smart_home
cd /home/bJS_terminal/
rm smart_home.log
nice -n -20 taskset -c 2 ./smart_home 123 0 >> smart_home.log &
while [ 1 ]
do
    status_monitor > ./run_time.log
    task_flag=$(ps -elf | grep smart_home | wc -l)
    #echo $task_flag
	if [ "$task_flag" != "2" ]; then
		echo "smart_home is stuck"
		killall smart_home
        sleep 1
        nice -n -20 taskset -c 2 ./smart_home 123 0 >> smart_home.log &
    fi  
    sleep 5
##    ./ws_client user_name device_type &
done
#*********************************************END OF FILE**********************#

