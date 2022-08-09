###
 # @Author: JC
 # @Date: 2022-07-14 21:11:41
 # @LastEditTime: 2022-07-16 17:28:27
 # @LastEditors: DESKTOP-S1QDRL5
 # @Description: In User Settings Edit
 # @FilePath: \sh\hello-ubuntu-rt.sh
### 

# 使用方式： source ./hello-ubuntu-rt.sh
#!/bin/bash



sudo apt-get install libncurses5-dev libssl-dev build-essential openssl zlibc libelf-dev minizip libidn11-dev libidn11 bison flex dwarves  libncurses-dev  zstd  -y

git clone https://gitee.com/xiao-xiao-chao/linu-ubuntu-kernel-RT.git --depth=1  -b 18_04

wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.4.193-rt74.patch.gz

wget https://mirror.tuna.tsinghua.edu.cn/kernel/v5.x/linux-5.4.129.tar.gz



tar -zxvf   linux-5.4.129.tar.gz

gunzip patch-5.4.193-rt74.patch.gz


cd linux-5.4.129

patch -p1 < ../patch-5.4.193-rt74.patch


cp ../linu-ubuntu-kernel-RT/.config   .config


sudo make -j$(nproc)  

sudo make modules -j$(nproc)

sudo make bzImage -j$(nproc)

sudo make modules_install -j$(nproc)

sudo make install

sudo update-grub

sudo cp -r ../linux-5.4.129  /usr/src/linux-headers-5.4.129-rt74
  
