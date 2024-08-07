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
# @brief  启动openvpn
#  ------------------------------------------------------------------*/
run_openvpn()
{
    ps -ef | grep -F "openvpn" | grep -v -F "grep" > /dev/null
    if [ $? -ne 0 ]
    then
        openvpn --config /etc/openvpn/client.ovpn &
    fi
}

#  ------------------------------------------------------------------
# @brief  关闭openvpn
#  ------------------------------------------------------------------*/
killall_openvpn()
{
    ps -ef | grep -F "openvpn" | grep -v -F "grep" > /dev/null
    if [ $? -eq 0 ]
    then
        killall openvpn
    fi
}

#  ------------------------------------------------------------------
  # @brief       holdBrTap_eth0tap0
#  ------------------------------------------------------------------*/
holdbrTap_eth0tap0()
{
    value_temp=$(brctl show | grep brTap)
    if [ "${value_temp}" == "" ];then
		ip link add brTap type bridge
		#ifconfig brTap 10.8.0.33 netmask 255.255.255.0 up
		ip link set brTap up
		# brctl stp brTap on
	else
	    value_temp=$(brctl show | grep tap0)
		if [ "${value_temp}" == "" ];then
			value_temp=$(ifconfig | grep tap0)
			if [ "${value_temp}" != "" ];then
				ip link set tap0 master brTap
				ifconfig tap0 0.0.0.0
				ifconfig brTap 10.8.0.11 netmask 255.255.255.0 up
			fi
		fi

		value_temp=$(brctl show | grep enx000ec677d959)
		if [ "${value_temp}" == "" ]
		then
			ip link set enx000ec677d959 master brTap
			ip link set enx000ec677d959 up
		fi
    fi
}

#  ------------------------------------------------------------------
  # @brief       delbrTap_eth0tap0
#  ------------------------------------------------------------------*/
delbrTap_eth0tap0()
{
    value_temp=$(brctl show | grep brTap)
    if [ "${value_temp}" != "" ];then
		brctl delif brTap enx000ec677d959
		brctl delif brTap tap0		

		ifconfig brTap down
		brctl delbr brTap
    fi
}

#  ------------------------------------------------------------------
  # @brief       init start
#  ------------------------------------------------------------------*/
run_openvpn
holdbrTap_eth0tap0
# start smart_home
cd /home/bJS_terminal/
rm smart_home.log
nice -n -20 taskset -c 2 ./smart_home 123 0 >> smart_home.log &

#  ------------------------------------------------------------------
  # @brief       loop
#  ------------------------------------------------------------------*/
while [ 1 ]
do
	run_openvpn
	holdbrTap_eth0tap0
    status_monitor > ./run_time.log
    task_flag=$(ps -elf | grep smart_home | wc -l)
    #echo $task_flag
	if [ "$task_flag" != "2" ]; then
		echo "smart_home is stuck"
		killall smart_home
        sleep 1
        nice -n -20 taskset -c 2 ./smart_home 123 0 >> smart_home.log &
    fi  
    sleep 10
    #./ws_client user_name device_type &
done
#*********************************************END OF FILE**********************#
