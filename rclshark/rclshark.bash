#!/bin/bash
RCLSHARK_WS='/opt/rclshark2_ws'
source $RCLSHARK_WS/install/setup.bash

IP_NAME=`ip -4 a | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127 | tr -d .`
while [[ -z ${IP_NAME} ]]; do
	IP_NAME=`ip -4 a | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127 | tr -d .`
	sleep 2
done

/opt/rclshark2_ws/install/rclshark/lib/rclshark/rclshark
wait