apt update
apt install qemu-kvm -y
qemu-img create -f raw filegz.img 20G
read -p "Nhập link file Gz: " url && wget -O- --no-check-certificate "$url" | gunzip | dd of=filegz.img
clear
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update
sudo apt install ngrok -y &&
read -p "Nhập authtoken ngrok: " token && ngrok authtoken "$token" && ngrok tcp 3389 &>/dev/null &
sudo su
qemu-img resize filegz.img 1025G
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