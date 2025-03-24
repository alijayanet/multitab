#!/bin/bash

# Memeriksa apakah nvm sudah terinstal
if ! command -v nvm &> /dev/null
then
    echo "nvm tidak ditemukan. Menginstal nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    # Memuat nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Menginstal Node.js versi 20 atau lebih
echo "Menginstal Node.js versi 20..."
nvm install 20
nvm use 20

# Memastikan npm terinstal
if ! command -v npm &> /dev/null
then
    echo "npm tidak ditemukan. Menginstal npm..."
    npm install -g npm
fi

# Memeriksa apakah direktori saat ini adalah repositori Git
if [ ! -d ".git" ]; then
    echo "Direktori saat ini bukan repositori Git. Mengkloning repositori..."
    git clone https://github.com/genieacs/genieacs.git
    cd genieacs || exit
else
    echo "Direktori saat ini adalah repositori Git."
fi

# Menginstal MongoDB
if ! command -v mongo &> /dev/null
then
    echo "MongoDB tidak ditemukan. Menginstal MongoDB..."
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/multiverse amd64 mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    sudo systemctl start mongod
    sudo systemctl enable mongod
fi

# Menginstal GenieACS secara global
echo "Menginstal GenieACS secara global..."
sudo npm install -g genieacs

# Mengatur genieacs-ui dengan ui-jwt-secret
echo "Mengatur genieacs-ui dengan ui-jwt-secret..."
genieacs-ui --ui-jwt-secret secret

# Menginstal dependensi
echo "Menginstal dependensi..."
npm install

# Menjalankan build
echo "Membangun proyek..."
npm run build

# Merestore database dari backup
echo "Merestore database dari backup..."
sudo mongorestore --db=genieacs --drop genieacs

echo "Instalasi selesai. Anda dapat menjalankan proyek dengan perintah yang sesuai."
