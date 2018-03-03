# MyBookLive-buildroot
This is a default configuration for generating a root files system (rootfs) for the Western Digital My Book Live. Now that Debian has declared PowerPC as a end of life architecture, the need for generating and loading a custom Linux OS will be higher to pull in security updates and product patches.

The latest WD My Book Live GPL Source Code can be found at https://support.wdc.com/downloads.aspx?p=132&lang=en


    # Install some dependencies to get started (taken from sample vagrant file)
    sudo apt update
    sudo apt install build-essential libncurses5-dev git libc6:i386 unzip bc
    sudo apt autoremove
    sudo apt clean

    # Clone the master buildroot and MyBookLive-buildroot repos
    git clone https://github.com/buildroot/buildroot.git
    git clone https://github.com/goldstar611/MyBookLive-buildroot.git

    # Copy the MyBookLive defconfig and board package into buildroot directory
    cp -R MyBookLive-buildroot/configs/* buildroot/configs
    cp -R MyBookLive-buildroot/board/* buildroot/board

    # Get additional dependencies for make gconfig
    sudo apt-get install libgtk2.0-dev libglib2.0-dev libglade2-dev

    # Load the default configuration for the MyBookLive (A PowerPC 446 architecture)
    cd buildroot
    make mybooklive_defconfig
    make gconfig

    # If you chose busybox as init then you can configure some "hidden" options
    #make busybox-gconfig

    # If you chose uClibc as toolchain then you can configure some "hidden" options
    #make uclibc-menuconfig

    # If you want to adjust kernel options before compiling
    #make linux-gconfig

    # After adjusting all build options you should make the top level target
    # You should never use make -jN with Buildroot: Instead, configure the BR2_JLEVEL option
    make

    # If you are building with gcc6 and receive the following error:
    # arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][0] {aka long long unsigned int[32][0]}' [-Warray-bounds] offsetof(struct thread_fp_state, fpr[32][0]));
    # Then you need to apply patch 35b7ce4f8f290794d3b89db7461e8c568b5defa1 
    # See https://lists.debian.org/debian-gcc/2016/08/msg00137.html for the patch
