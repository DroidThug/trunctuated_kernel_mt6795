#!/bin/sh

#
 # Custom build script by DroidThug
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
#
restore='\033[0m'
KERNEL_DIR=$PWD
KERNEL="Image.gz-dtb"
ZIP_MOVE="$KERNEL_DIR"
KERN_IMG=$KERNEL_DIR/arch/arm64/boot/Image.gz-dtb
BASE_VER="Trunctuated"
VER="-v1-$(date +"%Y-%m-%d"-%H%M)-NovaAlpha"
export ZIP_VER="$BASE_VER$VER$TC"
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[01;32m'
red='\033[0;31m'
blink_red='\033[05;31m'
nocol='\033[0m'
TC="UBERTC"
# Modify the following variable if you want to build
export KBUILD_BUILD_USER="DroidThug"
MODULES_DIR=$KERNEL_DIR/arch/arm/boot/AnyKernel2/modules
if [ -d "/home/travis" ]; then
export KBUILD_BUILD_HOST="TravisCI"
echo "Hello from Travis!"
echo "Skipping export variables. I iz da kewl bot!"
is_travis=true
else
echo "Hello Human!"
export KBUILD_BUILD_HOST="EvoqueUnit"
export ARCH=arm64
export LD_LIBRARY_PATH="/home/DroidThug/aarch64-linux-android-gcc-4.9/lib"
export CROSS_COMPILE="/home/DroidThug/aarch64-linux-android-gcc-4.9/bin/aarch64-linux-android-"
export SUBARCH=arm64
export STRIP="/home/DroidThug/aarch64-linux-android-gcc-4.9/bin/aarch64-linux-android-"
is_hooman=true
fi

compile_clean_dirty ()
{
if(whiptail --title "TRUNCTUATED KERNEL" --yesno "Would you like to keep this build clean?" 10 70) then
    echo -e "$green Cleaning $ZIP_VER Kernel! $nocol"
    echo -e "$red***********************************************"
    echo "          Cleaning Up Before Compile          "
    echo -e "***********************************************$nocol"
    make clean && make mrproper
else
      echo -e "$red Keeping it Dirty! Eww? $nocol"
fi
}

echo -e "${green}"
echo "--------------------------------------------------------"
echo "      Initializing build to compile Ver: $ZIP_VER    "
echo "--------------------------------------------------------"

if [ "$is_travis" = true ] ; then
    echo 'Cleaning by default!'
    make clean && make mrproper
elif [ "$is_hooman" = true ] ; then
    echo 'Choose hooman! Choose wisely!'
    compile_clean_dirty
fi
make cyanogenmod_x500_defconfig 
time make -j8

