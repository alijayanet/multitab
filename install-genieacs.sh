#!/bin/bash

echo "========================================="
echo "     ALIJAYA GENIEACS MULTITAB    "
echo "========================================="

# Fungsi untuk mengecek status instalasi
check_status() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 berhasil"
    else
        echo "❌ $1 gagal"
        exit 1
    fi
}

# Install NodeJS v20
echo "📦 Menginstal NodeJS v20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
check_status "Instalasi NodeJS"

# Install MongoDB
echo "📦 Menginstal MongoDB..."
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
check_status "Instalasi MongoDB"

# Start MongoDB
echo "🚀 Menjalankan MongoDB..."
sudo systemctl start mongod
sudo systemctl enable mongod
check_status "Menjalankan MongoDB"

# Install GenieACS
echo "📦 Menginstal GenieACS..."
sudo npm install -g genieacs
check_status "Instalasi GenieACS"

# Buat user sistem untuk GenieACS
echo "👤 Membuat user sistem GenieACS..."
sudo useradd --system --no-create-home --user-group genieacs
check_status "Pembuatan user sistem"

# Buat direktori yang diperlukan
echo "📁 Membuat direktori yang diperlukan..."
sudo mkdir -p /opt/genieacs/ext
sudo mkdir -p /var/log/genieacs
sudo chown genieacs:genieacs /opt/genieacs/ext
sudo chown genieacs:genieacs /var/log/genieacs
check_status "Pembuatan direktori"

# Buat file konfigurasi environment
echo "⚙️ Membuat file konfigurasi..."
cat > /tmp/genieacs.env << EOL
GENIEACS_CWMP_ACCESS_LOG_FILE=/var/log/genieacs/genieacs-cwmp-access.log
GENIEACS_NBI_ACCESS_LOG_FILE=/var/log/genieacs/genieacs-nbi-access.log
GENIEACS_FS_ACCESS_LOG_FILE=/var/log/genieacs/genieacs-fs-access.log
GENIEACS_UI_ACCESS_LOG_FILE=/var/log/genieacs/genieacs-ui-access.log
GENIEACS_DEBUG_FILE=/var/log/genieacs/genieacs-debug.yaml
NODE_OPTIONS=--enable-source-maps
GENIEACS_EXT_DIR=/opt/genieacs/ext
GENIEACS_UI_JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(128).toString('hex'))")
EOL

sudo mv /tmp/genieacs.env /opt/genieacs/genieacs.env
sudo chown genieacs:genieacs /opt/genieacs/genieacs.env
sudo chmod 600 /opt/genieacs/genieacs.env
check_status "Konfigurasi environment"

# Buat service files
echo "🔧 Membuat file service systemd..."

# CWMP Service
sudo tee /etc/systemd/system/genieacs-cwmp.service << EOL
[Unit]
Description=GenieACS CWMP
After=network.target

[Service]
User=genieacs
EnvironmentFile=/opt/genieacs/genieacs.env
ExecStart=/usr/bin/genieacs-cwmp

[Install]
WantedBy=default.target
EOL

# NBI Service
sudo tee /etc/systemd/system/genieacs-nbi.service << EOL
[Unit]
Description=GenieACS NBI
After=network.target

[Service]
User=genieacs
EnvironmentFile=/opt/genieacs/genieacs.env
ExecStart=/usr/bin/genieacs-nbi

[Install]
WantedBy=default.target
EOL

# FS Service
sudo tee /etc/systemd/system/genieacs-fs.service << EOL
[Unit]
Description=GenieACS FS
After=network.target

[Service]
User=genieacs
EnvironmentFile=/opt/genieacs/genieacs.env
ExecStart=/usr/bin/genieacs-fs

[Install]
WantedBy=default.target
EOL

# UI Service
sudo tee /etc/systemd/system/genieacs-ui.service << EOL
[Unit]
Description=GenieACS UI
After=network.target

[Service]
User=genieacs
EnvironmentFile=/opt/genieacs/genieacs.env
ExecStart=/usr/bin/genieacs-ui

[Install]
WantedBy=default.target
EOL

# Konfigurasi logrotate
echo "📝 Mengkonfigurasi logrotate..."
sudo tee /etc/logrotate.d/genieacs << EOL
/var/log/genieacs/*.log /var/log/genieacs/*.yaml {
    daily
    rotate 30
    compress
    delaycompress
    dateext
}
EOL

# Enable dan start services
echo "🚀 Mengaktifkan dan menjalankan services..."
sudo systemctl daemon-reload

for service in genieacs-cwmp genieacs-nbi genieacs-fs genieacs-ui; do
    sudo systemctl enable $service
    sudo systemctl start $service
    sudo systemctl status $service
    check_status "Service $service"
done

# Copy folder genieacs ke /usr/lib/node_modules
echo "📋 Menyalin folder genieacs ke /usr/lib/node_modules..."
if [ -d "./genieacs" ]; then
    sudo cp -ru genieacs /usr/lib/node_modules
    check_status "Penyalinan folder genieacs"
else
    echo "❌ Folder genieacs tidak ditemukan di direktori saat ini"
    exit 1
fi

# Restore database jika ada
if [ -d "./db" ]; then
    echo "💾 Memulihkan database..."
    mongorestore --db genieacs ./db
    check_status "Pemulihan database"
    
    # Restart services setelah restore database
    echo "🔄 Me-restart services..."
    for service in genieacs-cwmp genieacs-nbi genieacs-fs genieacs-ui; do
        sudo systemctl restart $service
        check_status "Restart service $service"
    done
fi

echo "========================================="
echo "    INSTALASI SELESAI!                  "
echo "=========================================" 