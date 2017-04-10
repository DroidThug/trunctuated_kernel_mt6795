#!/bin/sh

#
 # Custom build script
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
ANYKERNEL_DIR="$KERNEL_DIR/ak"
REPACK_DIR="$ANYKERNEL_DIR"
ZIP_MOVE="$KERNEL_DIR"
KERN_IMG=$KERNEL_DIR/arch/arm/boot/Image.gz-dtb
BASE_VER="Infernus"
VER="-v1-$(date +"%Y-%m-%d"-%H%M)-"
ZIP_VER="$BASE_VER$VER$TC"
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
export ARCH=arm64
export LD_LIBRARY_PATH="/home/droidthug/aarch64-linux-android-gcc-4.9/lib"
export CROSS_COMPILE="/home/droidthug/aarch64-linux-android-gcc-4.9/bin/aarch64-linux-android-"
export SUBARCH=arm64
export KBUILD_BUILD_USER="DroidThug"
export KBUILD_BUILD_HOST="EvoqueUnit"
STRIP="/home/droidthug/aarch64-linux-android-gcc-4.9/bin/aarch64-linux-android-strip"
MODULES_DIR=$KERNEL_DIR/arch/arm/boot/AnyKernel2/modules

echo -e "${green}"
echo "--------------------------------------------------------"
echo "      Initializing build to compile Ver: $ZIP_VER    "
echo "--------------------------------------------------------"

echo -e "$yellow***********************************************"
echo "          Compiling INFERNUS         "
echo -e "***********************************************$nocol"
rm -f $KERN_IMG
echo -e "$red***********************************************"
echo "          Cleaning Up Before Compile          "
echo -e "***********************************************$nocol"
$clean make clean && make mrproper
echo -e "$yellow***********************************************"
echo "          Initialising DEFCONFIG        "
echo -e "***********************************************$nocol"
make x500_defconfig 
echo -e "$yellow***********************************************"
echo "          Cooking INFERNUS         "
echo -e "***********************************************$nocol"
make -j8
