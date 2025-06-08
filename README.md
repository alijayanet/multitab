# ALIJAYA GENIEACS INSTALL MULTITAB


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
```
cp -ru genieacs /usr/lib/node_modules/
```
```
mkdir /root/db
cp cache.bson /root/db
cp cache.metadata.json /root/db
cp config.bson /root/db
cp config.metadata.json /root/db
cp permissions.bson /root/db
cp permissions.json /root/db
cp presets.bson /root/db
cp presets.metadata.json /root/db
cp provisions.bson /root/db
cp provisions.metadata.json /root/db
cp tasks.bson /root/db
cp tasks.metadata.json /root/db
cd 
```
```
mongorestore --db genieacs --drop /root/db
```
```
reboot
```

## Lisensi
© 2025 ALIJAYA ACS MULTITAB### SILAHKAN YANG INGIN BERBAGI

![Image](https://github.com/user-attachments/assets/724e5ac2-626e-4f2d-bd1f-1265b70b544f)

