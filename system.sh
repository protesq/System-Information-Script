#bin/bash

#CPU lcpu
if [ -f /proc/cpuinfo ]; then
    CPU=$(awk '/model name/ {print $4}' /proc/cpuinfo | head -n 1)
    echo "CPU: $CPU"
fi

#Memory
if [ -f /proc/meminfo ]; then
    MEMORY=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
    echo "Memory: $MEMORY KB"
fi

#OS
if [ -f /etc/os-release ]; then
    OS=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    echo "OS: $OS"
fi

#Kernel
if [ -f /proc/version ]; then
    KERNEL=$(cat /proc/version)
    echo "Kernel: $KERNEL"
fi

#Disk 
if [ -f /etc/fstab ]; then
    DISK=$(df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $1, $2, $3, $4, $5}')
    echo "Disk: $DISK"
fi

#Network
if command -v ipconfig >/dev/null 2>&1; then
    NETWORK=$(ipconfig | grep -A 1 "Wireless LAN adapter" | grep "IPv4 Address" | awk '{print $NF}')
    if [ -z "$NETWORK" ]; then
        NETWORK=$(ipconfig | grep "IPv4 Address" | head -n 1 | awk '{print $NF}')
    fi
    echo "Network IP: $NETWORK"
elif command -v ip >/dev/null 2>&1; then
    NETWORK=$(ip addr show | grep -E "inet.*global" | awk '{print $2}' | head -n 1)
    echo "Network IP: $NETWORK"
fi

#WiFi Password
if command -v netsh >/dev/null 2>&1; then
    WIFI_SSID=$(netsh wlan show profiles | grep "All User Profile" | head -n 1 | awk -F: '{print $2}' | sed 's/^ *//')
    if [ ! -z "$WIFI_SSID" ]; then
        WIFI_PASSWORD=$(netsh wlan show profile name="$WIFI_SSID" key=clear | grep "Key Content" | awk -F: '{print $2}' | sed 's/^ *//')
        echo "WiFi SSID: $WIFI_SSID"
        echo "WiFi Password: $WIFI_PASSWORD"
    fi
elif [ -f /etc/NetworkManager/system-connections/*.nmconnection ]; then
    WIFI_PASSWORD=$(grep -h "psk=" /etc/NetworkManager/system-connections/*.nmconnection 2>/dev/null | head -n 1 | cut -d'=' -f2)
    echo "WiFi Password: $WIFI_PASSWORD"
fi
