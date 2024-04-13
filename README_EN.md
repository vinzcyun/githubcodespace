<div align="left">
<a href="/README_EN.md">English</a> &nbsp;|&nbsp;
<a href="/README.md">Tiếng Việt</a>
</div>


# RDP on Github Codespaces
Create an RDP using this method, and the VPS will operate under 50 hours. This VPS is primarily for experiencing Windows and should not be used for mining or running tools unauthorized. If there are signs of abuse over time, you will be directly banned from Github.

# Note
Upon restarting, some functions in the system may not work properly. It only operates on operating system files with the .GZ extension. Hitting Shutdown on this VPS will make it unable to restart.

# Future Updates
We will update additional features to choose RDP connection regions on Ngrok, add functionality to install .iso and .img files, and revamp the interface to be more intuitive.

# Installation
sudo su
wget -O cline1.sh https://raw.githubusercontent.com/vinzcyun/githubcodespace/main/cline1.sh
chmod +x cline1.sh
./cline1.sh


### Creating a New Page
sudo su
qemu-img resize filegz.img 1025G
# Change the value of 1025G to the storage size you want for the VPS
clear
wget -O cline2.sh https://raw.githubusercontent.com/vinzcyun/githubcodespace/main/cline2.sh
chmod +x cline2.sh
./cline2.sh


# How to Restart VPS When Codespaces Suddenly Stops Working
### Step 1: Paste this command and replace token with your token
sudo su
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok -y
ngrok config add-authtoken [token]

### Step 2: Create an rdp/vnc port
ngrok tcp 3389
# or
ngrok tcp 5900

### Step 3: Create a new page and copy and paste this command
sudo su
wget -O cline2.sh https://raw.githubusercontent.com/vinzcyun/githubcodespace/main/cline2.sh
chmod +x cline2.sh
./cline2.sh

### *If there's an error, you can use
sudo su
qemu-system-x86_64 
-net nic -net user,hostfwd=tcp::3389-:3389 
-m 12G -smp cores=4 
-cpu max 
-enable-kvm 
-boot order=d 
-drive file=filegz.img,format=raw,if=virtio 
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 
-device usb-tablet 
-vnc :0 -vga virtio
