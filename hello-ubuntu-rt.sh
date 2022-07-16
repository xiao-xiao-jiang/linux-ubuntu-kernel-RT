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

  
wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.49-rt47.patch.gz


wget https://mirror.tuna.tsinghua.edu.cn/kernel/v5.x/linux-5.15.49.tar.gz


tar -zxvf   linux-5.15.49.tar.gz

gunzip patch-5.15.49-rt47.patch.gz


cd linux-5.15.49

patch -p1 < ../patch-5.15.49-rt47.patch


wget https://github.com/xiao-xiao-jiang/linu-ubuntu-kernel-RT/blob/master/.config


sudo make -j$(nproc)  

sudo make modules -j$(nproc)

sudo make bzImage -j$(nproc)

sudo make modules_install -j$(nproc)

sudo make install

sudo update-grub
