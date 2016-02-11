#!/bin/sh

# Toggle Turbo Boost for Ivy Bridge CPUs (should work for all newer Core)
# Requires a fairly new Linux kernel (let's say 3.0+)
# Written by Donjan Rodic, released for free use

# check current real frequency with  sudo turbostat -s -i1


# SOURCES
# https://github.com/DropD/fnc-simplex/blob/master/linux_turboboost.sh
# http://askubuntu.com/questions/619875/disabling-intel-turbo-boost-in-ubuntu


# EXPLANATION AND MANUAL ALTERNATIVE
# Its the CPU Register 0x1a0 which isn't initialised by the BIOS correctly.

# Install msr-tools for rdmsr and wrmsr:
#dnf install msr-tools

# To check this open a terminal and write:
#sudo modprobe msr
#sudo rdmsr -p"0" 0x1a0 -f 38:38

# If this outputs "1" then the Turbomode is disabled. Write this to enable it on both cores:
#sudo modprobe msr
#sudo wrmsr -p"0" 0x1a0 0x850089
#sudo wrmsr -p"1" 0x1a0 0x850089

# WARNING: need to be executed as root, the original used "sudo", nto suitable for an automatic script


modprobe msr

# all_cores FOO
# perform FOO(i) for each core i
all_cores() {
  NPROCS=`cat /proc/cpuinfo | grep "core id" | wc -l`
  NPROCS=$(($NPROCS - 1))
  for i in `seq 0 1 $NPROCS`; do
    $1 $i
  done
}


# report Turbo Boost state on core $1
read_tb() {
  ret=`rdmsr -p"$1" 0x1a0 -f 38:38`
  [ $ret -eq 0 ] && echo "$1": on || echo "$1": off
}

# enable Turbo Boost on core $1
enable_tb() {
  wrmsr -p"$1" 0x1a0 0x850089
}

# disable Turbo Boost on core $1
disable_tb() {
  wrmsr -p"$1" 0x1a0 0x4000850089
}


if [ "$1" = "on" ]; then
  all_cores enable_tb
  all_cores read_tb
elif [ "$1" = "off" ]; then
  all_cores disable_tb
  all_cores read_tb
elif [ "$1" = "list" ]; then
  all_cores read_tb
else
  echo "usage: turboboost.sh on | off | list"
fi
