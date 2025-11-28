# Instructions

1. Clone the ch32fun repository:
```bash
git clone https://github.com/cnlohr/ch32fun.git
```
Refrence commit: `0a63345d3be8825ebd582d4b1e4213f9876a3d3d`

2. Install prerequisites:
```bash
sudo apt-get install build-essential libnewlib-dev gcc-riscv64-unknown-elf libusb-1.0-0-dev libudev-dev gdb-multiarch
```

3. Install plugdev rules for WCH-LINKe programmer
```bash
sudo cp minichlink/99-minichlink.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
```

4. Enter minichlink directory and build:
```bash
cd minichlink
make
```
