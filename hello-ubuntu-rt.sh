###
 # @Author: JC
 # @Date: 2022-07-14 21:11:41
 # @LastEditTime: 2022-07-14 21:11:54
 # @LastEditors: DESKTOP-S1QDRL5
 # @Description: In User Settings Edit
 # @FilePath: \sh\hello-ubuntu-rt.sh
### 

sudo apt-get install libncurses5-dev libssl-dev build-essential openssl zlibc libelf-dev minizip libidn11-dev libidn11 bison flex dwarves  -y

wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.49-rt47.patch.gz

wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.15.49.tar.gz

tar -zxvf   linux-5.15.49.tar.gz
gunzip patch-5.15.49-rt47.patch.gz

cd linux-5.15.49

patch -p1 < ../patch-5.15.49-rt47.patch

wget .config

sudo make -j

sudo make modules
sudo make bzImage
sudo make modules_install -j
sudo make install 
sudo update-grub
sudo reboot

