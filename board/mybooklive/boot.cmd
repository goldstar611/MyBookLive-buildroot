echo Boot from U-boot configuration
setenv md0_args 'setenv bootargs root=/dev/sda1 rw rootfstype=ext3 rootflags=data=ordered'
setenv load_sata 'sata init; ext2load sata 1:1 ${kernel_addr_r} /boot/uImage; ext2load sata 1:1 ${fdt_addr_r} /boot/apollo3g.dtb'
setenv boot_sata 'run load_sata; run md0_args addtty; bootm ${kernel_addr_r} - ${fdt_addr_r}'
echo ==== Loading Linux kernel, Device tree, Root filesystem ====
run boot_sata

