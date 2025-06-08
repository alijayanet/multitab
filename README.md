# ALIJAYA GENIEACS INSTALL MULTITAB

Script instalasi otomatis untuk GenieACS dengan dukungan NodeJS v20 dan MongoDB.

## Persyaratan Sistem
- Ubuntu/Debian based system dengan systemd
- Akses root/sudo
- Koneksi internet yang stabil

## Fitur
- Instalasi NodeJS v20
- Instalasi MongoDB (mendukung ARM64 dan x86)
- Instalasi GenieACS versi terbaru
- Konfigurasi otomatis semua komponen GenieACS:
  - CWMP Service
  - NBI Service
  - FS Service
  - UI Service
- Konfigurasi logrotate
- Restore database (opsional)
- Restart layanan

## Cara Penggunaan
```
apt install git curl -y
```
```
git clone https://github.com/alijayanet/multitab
```
```
cd multitab
```

1. Berikan izin eksekusi pada script:
```bash
chmod +x install-genieacs.sh
```

2. Jalankan script sebagai root:
```bash
sudo ./install-genieacs.sh
```

## Struktur Folder
- `install-genieacs.sh` - Script instalasi utama
- `db/` - Folder berisi backup database MongoDB (opsional)

## Catatan
- Pastikan folder `db` berisi backup database yang valid jika ingin melakukan restore
- Script akan menampilkan status setiap langkah instalasi
- Jika terjadi error, script akan berhenti dan menampilkan pesan error
- Semua service GenieACS akan dijalankan sebagai user sistem `genieacs`
- Log akan disimpan di `/var/log/genieacs/`

## Troubleshooting
Jika terjadi masalah saat instalasi:
1. Periksa log MongoDB: `sudo journalctl -u mongod`
2. Periksa log GenieACS: `sudo journalctl -u genieacs-*`
3. Periksa versi NodeJS: `node -v`
4. Periksa status GenieACS: `genieacs --version`
5. Periksa status services: `sudo systemctl status genieacs-*`

## Port Default
- CWMP: 7547
- NBI: 7557
- FS: 7567
- UI: 3000

## COPPY PASTE SCRIPT PAGE MULTITAB
- coppy paste scrip yang ada di file multitab device.txt ke 
- admin config multitab page 

## Lisensi
© 2025 ALIJAYA ACS MULTITAB
