#!/bin/bash

echo "Bắt đầu quá trình cài đặt và cấu hình máy ảo"

# Cập nhật danh sách gói
echo "Đang cập nhật danh sách gói..."
sudo apt update -q

# Cài đặt qemu-kvm
echo "Đang cài đặt qemu-kvm..."
sudo apt install qemu-kvm -y -q

# Tạo ổ đĩa ảo với dung lượng 20G
echo "Đang tạo ổ đĩa ảo với dung lượng 20GB..."
qemu-img create -f raw filegz.img 20G -q

# Xóa màn hình
clear

# Yêu cầu người dùng nhập link tệp Gz và tải về vào filegz.img
echo "Vui lòng nhập link của file Gz để tải về và giải nén vào ổ đĩa ảo."
read -p "Nhập link file Gz: " url && wget l -O- --no-check-certificate "$url" | gunzip | dd of=filegz.img

# Xóa màn hình
clear

# Thêm kho ngrok và cài đặt ngrok
echo "Đang cấu hình kho ngrok và cài đặt ngrok..."
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update -q
sudo apt install ngrok -y -q

# Xóa màn hình
clear

# Yêu cầu người dùng nhập authtoken ngrok và kích hoạt authtoken
echo "Vui lòng nhập authtoken của ngrok để kích hoạt dịch vụ."
read -p "Nhập authtoken ngrok: " token
ngrok authtoken "$token"

# Khởi động ngrok để chuyển tiếp cổng 3389 và ẩn quá trình nền
echo "Đang khởi động dịch vụ ngrok để chuyển tiếp cổng 3389..."
ngrok tcp 3389 &>/dev/null & clear
echo "Vui lòng nhập dung lượng mới cho ổ đĩa ảo (vd: 30G)."
read -p "Nhập dung lượng ổ đĩa: " disk_size
qemu-img resize filegz.img "$disk_size"

# Khởi chạy máy ảo qemu
echo "Đang khởi động máy ảo..."
qemu-system-x86_64 \
-net nic -net user,hostfwd=tcp::3389-:3389 \
-m 12G -smp 4 \
-cpu host \
-enable-kvm \
-boot order=d \
-drive file=filegz.img,format=raw,if=virtio \
-device usb-ehci \
-device usb-tablet \
-vnc :0 -vga virtio

echo "Đã xảy ra lỗi."
