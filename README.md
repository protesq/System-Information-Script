# System Information Script

Sistem bilgilerini toplayan cross-platform bash script'i.

## Özellikler

- **CPU:** İşlemci model bilgisi
- **Memory:** Toplam RAM miktarı
- **OS:** İşletim sistemi adı
- **Kernel:** Kernel versiyonu
- **Disk:** Disk kullanım bilgileri
- **Network:** Aktif IP adresi
- **WiFi:** Bağlı WiFi ağı ve şifresi

## Kullanım

```bash
bash system.sh
```

## Platform Desteği

### Windows
- `ipconfig` ile network bilgisi
- `netsh wlan` ile WiFi bilgileri
- PowerShell uyumlu

### Linux
- `ip addr` / `ifconfig` ile network
- NetworkManager / wpa_supplicant ile WiFi
- Standard Linux komutları

## Örnek Çıktı

```
CPU: Intel
Memory: 16437400 KB
OS: "Microsoft Windows 10 Pro"
Kernel: MINGW64_NT-10.0-26100 version 3.6.3-774c51e...
Disk: C:/Program Files/Git 930G 577G 354G
Network IP: 192.168.1.100
WiFi SSID: MyNetwork
WiFi Password: mypassword123
```

## Python Entegrasyonu

### Doğrudan çalıştırma:
```python
import subprocess
result = subprocess.run(['bash', 'system.sh'], capture_output=True, text=True)
print(result.stdout)
```

### Fonksiyon tabanlı:
```python
def get_system_info():
    return subprocess.run(['bash', 'system.sh'], capture_output=True, text=True).stdout
```

## Gereksinimler

- Bash (Git Bash Windows'ta)
- `awk`, `grep`, `cut` komutları
- Windows: `ipconfig`, `netsh`
- Linux: `ip` veya `ifconfig`

## Notlar

- WiFi şifre gösterimi admin yetkileri gerektirebilir
- Bazı sistem bilgileri platforma göre değişebilir
- Script cross-platform uyumlu tasarlanmıştır
