sudo apt update
apt install qemu-kvm -y
qemu-img create -f raw filegz.img 20G
clear
read -p "Nhập link file Gz: " url && wget -O- --no-check-certificate "$url" | gunzip | dd of=filegz.img
clear
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt install ngrok -y
clear
read -p "Nhập authtoken ngrok: " token
ngrok authtoken "$token" && ngrok tcp 3389 --region ap &>/dev/null &
sudo su
clear
read -p "Nhập dung lượng ổ đĩa: " disk_size
qemu-img resize filegz.img "$disk_size"
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