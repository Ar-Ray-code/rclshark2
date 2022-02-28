#!/bin/bash

# How to execute (Install) 
# sudo bash ./install.bash <ros2-installed-dir>

# How to execute (Uninstall)
# sudo bash ./install.bash uninstall

PROJECT_DIR=$(cd $(dirname $0); pwd)
TARGET_DIR='rclshark2'
INSTALL_DIR='/opt'
COMPUTER_MSGS_VERSION='v2.0.0'
RCLSHARK_SMI_VERSION='v2.0.0'
BIN='/usr/local/bin'

SCRIPT_DIR=$(cd $(dirname $0); pwd)
_USER=${SCRIPT_DIR##*home/}
USER=${_USER%%/*}

RCLSHARK_WS=${INSTALL_DIR}'/'${TARGET_DIR}'_ws'

## Check superuser ======================================
if [ $(id -u) -ne 0 ]; then
    echo "You must execute this command as a superuser."
    echo "sudo bash ./install.bash ros_install_dir(/opt/ros/foxy)' or 'sudo bash ./install.bash uninstall'"
    exit 1
fi

## UNINSTALL =============================================
if [ $# -ne 1 ]; then
    echo "options failed ('sudo bash ./install.bash ros_install_dir(/opt/ros/foxy)' or 'sudo bash ./install.bash uninstall')"
    exit 1
fi

if [ "uninstall" = $1 ]; then
    echo "uninstall ..."
   
    echo "uninstall rclshark2.service"
    systemctl stop rclshark2.service
    systemctl disable rclshark2.service
    rm /etc/systemd/system/rclshark2.service
    
    systemctl daemon-reload
    rm -rf $INSTALL_DIR/${TARGET_DIR}_ws/
    # rm $BIN/rclshark-smi
    echo "uninstalled"
    exit 0
else 
    # $1 is directory ? 
    if [ -d $1 ]; then
        source $1/setup.bash
    # $1 is not directory ? -> error
    else
        echo "options failed ('sudo bash ./install.bash ros_install_dir(/opt/ros/foxy)' or 'sudo bash ./install.bash uninstall')"
    fi
fi

## INSTALL =============================================
if [ -z $ROS_DISTRO ]; then
    echo "options failed ('sudo bash ./install.bash ros_install_dir(/opt/ros/foxy)' or 'sudo bash ./install.bash uninstall')"
    exit 1
fi

rm -rf $RCLSHARK_WS/src
mkdir -p $RCLSHARK_WS/src
pip3 install -r $PROJECT_DIR/requirements.txt

cp -r $PROJECT_DIR/ $RCLSHARK_WS/src/$TARGET_DIR/

cd $RCLSHARK_WS && colcon build

for service_file in $RCLSHARK_WS/src/$TARGET_DIR/rclshark/service/rclshark2.service ; do
    echo "User=$USER" >> $service_file

    FILE=`basename $service_file`
    echo "$service_file"
    echo "setting "$FILE"..."

    cp $service_file /etc/systemd/system/
    systemctl enable $FILE
done

rm -rf /opt/rclshark2_ws/build /opt/rclshark2_ws/log /opt/rclshark2_ws/src
# cp $RCLSHARK_WS/src/rclshark/rclshark-smi/rclshark-smi.bash $BIN/rclshark-smi
# chmod +x $BIN/rclshark-smi

systemctl daemon-reload
systemctl start rclshark2.service

echo "                                                       (}                    "
echo "                                                     ./ |                    "
echo "                                                    /   |                    "
echo "                                                  ./    |                    "
echo "                                                 _/_____\@\                  "
echo "                                             _/%@@@@@@@@@@@@@@@*\            "
echo " Thank you                                 /?@                  @@\_         "
echo "    for your interest      _%%%_         #@                        @\        "
echo "         in my rclshark ! @@@ @@@@%     @@                          @@       "
echo "                          @@@@@@@@@@#  @           L            k    @@      "
echo "                           @@@@@@@@@@#:/           L            k  _  %@     "
echo "                             @@@@@@@@*@  R r  cc   L    SS  R r k ?    @     "
echo "                                %@@@@*@  Rr  C  c  L  SS    Rr  K/     %@    "
echo "                                 @@@@*@  R  C      L    S   R   K\     |@    "
echo "                                  %@@*@  R   Ccc   L  SS    R   K \=   /@    "
echo "                                    @*%                               @@     "
echo "                                      =#@                            @@      "
echo "                                        =#@                       @@#        "
echo "                                         @####@@@@@@@@@@@@@@@@@@%###%        "
echo "                                         @@@@@%##- ###              \@@@.    "
echo "                                          @@@@@@@@   \}                      "
echo "                                            +@@@@@@@@                        "
echo "                                               =@@@@@@@@     by Ar-Ray 2021  "

sleep 1

echo "------------------------------------------------------"
echo "installation completed"
# echo "run 'sudo systemctl start rclshark2.service' to start rclshark"
# echo "run 'rclshark-smi' to start rclshark-smi"
echo "------------------------------------------------------"

exit 0
