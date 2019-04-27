echo Boot from U-boot configuration
setenv boot_args 'setenv bootargs root=/dev/sda1 rw rootfstype=ext4 rootflags=data=ordered'

setenv load_part1 'ext2load sata 0:1 ${kernel_addr_r} /boot/uImage; ext2load sata 0:1 ${fdt_addr_r} /boot/apollo3g.dtb'
setenv load_part2 'ext2load sata 1:1 ${kernel_addr_r} /boot/uImage; ext2load sata 1:1 ${fdt_addr_r} /boot/apollo3g.dtb'

setenv load_sata 'sata init; if run load_part1; then echo Loaded part 1; elif run load_part2; then echo Loaded part 2; fi'
setenv boot_sata 'run load_sata; run boot_args addtty; bootm ${kernel_addr_r} - ${fdt_addr_r}'

echo ==== Loading Linux kernel, Device tree, Root filesystem ====
run boot_sata

