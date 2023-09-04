# RDP trên Github Codespace
Tạo Rdp bằng cách này Vps sẽ hoạt động dưới 50h. Vps này chủ yếu để trải nghiệm Windows không được tự ý sử dụng đem ra đào coin, treo tool. Nếu có dấu hiệu sử dụng, trực tiếp ban khỏi Github.
# Cách cài đặt
```sudo su```

```wget -O cline1.sh https://raw.githubusercontent.com/VinDaiDe/githubcodespace/main/cline1.sh```


```chmod +x cline1.sh```


```./cline1.sh```
## Tạo trang mới
```sudo su```

```qemu-img resize filegz.img 1025G```

```clear```

```wget -O cline2.sh https://raw.githubusercontent.com/VinDaiDe/githubcodespace/main/cline2.sh```


```chmod +x cline2.sh```


./cline2.sh
# Cách để khởi động lại khi Vps dừng hoạt động
### Bước 1: Dán lệnh này vào và thay [token] bằng token của bạn
```curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok -y```
```ngrok config add-authtoken [token]```
### Bước 2: Tạo cổng rdp/vnc
```ngrok tcp 3389``` /
```ngrok tcp 5900```
### Bước 3: Tạo trang mới và copy lệnh này dán vào
```qemu-system-x86_64 \
-net nic -net user,hostfwd=tcp::3389-:3389 \
-m 12G -smp cores=4 \
-cpu max \
-enable-kvm \
-boot order=d \
-drive file=filegz.img,format=raw,if=virtio \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-vnc :0 -vga virtio

