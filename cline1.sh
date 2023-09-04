apt update && apt install qemu-kvm -y &&
qemu-img create -f raw filegz.img 20G && clear
read -p "Nhập link file Gz: " url && wget -O- --no-check-certificate "$url" | gunzip | dd of=filegz.img && clear && curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok -y &&
read -p "Nhập authtoken ngrok: " token && ngrok authtoken "$token" && ngrok tcp 3389 && clear
