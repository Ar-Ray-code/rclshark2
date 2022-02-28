# rclshark​ :turtle::shark:

latest : [v2.0.0](https://github.com/Ar-Ray-code/rclshark2/releases/tag/v2.0.0)

[解説（Zenn）](https://zenn.dev/array/articles/9fd8cb5941bb94)

[紹介ページ（github.io）](https://ar-ray-code.github.io/05_rclshark/index.html)

Monitor the status of computers on a network using the DDS function of ROS2.

![rclshark-title](images_for_readme/rclshark-title.png)

## Documents

- Zenn : https://zenn.dev/array/articles/9fd8cb5941bb94
- DockerHub : https://hub.docker.com/r/ray255ar/rclshark
- Computer_msgs : https://github.com/Ar-Ray-code/computer_msgs
- rclshark-smi : https://github.com/Ar-Ray-code/rclshark-smi
- Website : https://ar-ray-code.github.io/05_rclshark

## Requirements

- ROS2 foxy-base [Installation](https://docs.ros.org/en/foxy/Installation.html)
- python3-colcon-common-extensions
- python3-psutil

## Support

- Ubuntu 20.04 (x86_64, Armv8) (Full support)
- Raspberry Pi OS (aarch64) (Full support)
- <del>Windows 11 (x86_64) (rclshark-smi only)



## 1. rclshark​ :turtle: :shark:

Repository : https://github.com/Ar-Ray-code/rclshark

rclshark is an IP address display system that takes advantage of the DDS publishing nature of the ros2 node to the local network, and can recognize any device with ROS2 installed.
rclshark is also a service server, and has a function to Repositoryrt computer status using psutil.

<!-- See [rclshark-smi](https://github.com/Ar-Ray-code/rclshark#rclshark-smi-turtle-shark) for details. -->

---

### Installation

#### ROS-Foxy Installation

If you want to know how to install ROS-Foxy , please check [ROS2-Foxy-Installation](https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html).

```bash
# ROS-Foxy & depends Installation
sudo apt update && sudo apt install curl gnupg2 lsb-release python3-psutil python3-colcon-common-extensions build-essential git

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt install ros-foxy-base python3-colcon-common-extensions python3-psutil g++ cmake
```

#### Using colcon build

```bash
mkdir ~/rclshark2_dir
cd ~/rclshark2_dir
git clone https://github.com/Ar-Ray-code/rclshark2
colcon build
source install/setup.bash
```

#### Using install.bash (Automatic start)

Installed ROS2

If you want to know how to install ROS-Foxy , please check [ROS2-Foxy-Installation](https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html).

```bash
git clone https://github.com/Ar-Ray-code/rclshark2
cd rclshark2
sudo bash install.bash /opt/ros/foxy
```

---

### Quick check of rclshark

Since rclshark is an application that uses the basic functions of ROS2, you can find it with the ros2 command.

```bash
source ~/rclshark2_dir/install/setup.bash
ros2 topic list | grep rsk
> /rskc0a80b0f_ubuntu_i9rtx_pub
```

![](images_for_readme/rclshark_rostopic.png)


Now you can safely forget your IP address.:wink:

<!-- rosidl generate -o gen -t py -I$(ros2 pkg prefix --share std_msgs)/.. -->

## 2. rclshark-smi (v1.0.0)​ :turtle: :shark:

Repository : https://github.com/Ar-Ray-code/rclshark-smi

rclshark2 is not supported.

## About author

- author : [Ar-Ray](https://github.com/Ar-Ray-code)
- [Twitter](https://twitter.com/Ray255Ar)


