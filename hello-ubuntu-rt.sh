###
 # @Author: JC
 # @Date: 2022-07-14 21:11:41
 # @LastEditTime: 2022-07-16 17:28:27
 # @LastEditors: DESKTOP-S1QDRL5
 # @Description: In User Settings Edit
 # @FilePath: \sh\hello-ubuntu-rt.sh
### 

# 参考文档：https://github.com/UniversalRobots/Universal_Robots_Client_Library/blob/master/doc/real_time.md
# 使用方式： source ./hello-ubuntu-rt.sh



#!/bin/bash

sudo apt-get install   cpufrequtils libncurses5-dev libssl-dev build-essential openssl zlibc libelf-dev minizip libidn11-dev libidn11 bison flex dwarves  libncurses-dev  zstd  -y

git clone https://gitee.com/xiao-xiao-chao/linu-ubuntu-kernel-RT.git --depth=1 

wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.49-rt47.patch.gz

wget https://mirror.tuna.tsinghua.edu.cn/kernel/v5.x/linux-5.15.49.tar.gz



tar -zxvf   linux-5.15.49.tar.gz

gunzip patch-5.15.49-rt47.patch.gz


cd linux-5.15.49

patch -p1 < ../patch-5.15.49-rt47.patch


cp ../linu-ubuntu-kernel-RT/.config   .config


sudo make -j$(nproc)   deb-pkg

sudo make modules -j$(nproc)

sudo make bzImage -j$(nproc)

sudo make modules_install -j$(nproc)

sudo make install

sudo apt install ../linux-headers-*.deb   ../linux-image-*.deb

sudo update-grub

sudo groupadd realtime

sudo usermod -aG realtime $(whoami)

sh -c 'echo "
@realtime soft rtprio 99
@realtime soft priority 99
@realtime soft memlock 102400
@realtime hard rtprio 99
@realtime hard priority 99
@realtime hard memlock 102400
" >>/etc/security/limits.conf'

sudo systemctl disable ondemand
sudo systemctl enable cpufrequtils
sudo sh -c 'echo "GOVERNOR=performance" > /etc/default/cpufrequtils'
sudo systemctl daemon-reload && sudo systemctl restart cpufrequtils
