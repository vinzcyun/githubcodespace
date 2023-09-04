qemu-system-x86_64 \
-net nic -net user,hostfwd=tcp::3389-:3389 \
-m 12G -smp cores=4 \
-cpu max \
-enable-kvm \
-boot order=d \
-drive file=filegz.img,format=raw,if=virtio \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-vnc :0 -vga virtio
