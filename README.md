# AUTO INSTALL GENIEACS MULTITAB THEMA DARKMODE


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
chmod +x install.sh
```
```
bash install.sh
```

```
reboot
```
## Bagi yang sudah ter Install Genieacs 

```
cp -r genieacs /usr/lib/node_modules/
```
```
mongorestore --db genieacs --drop db
```
```
systemctl daemon-reload
systemctl stop --now genieacs-{cwmp,fs,ui,nbi}
systemctl start --now genieacs-{cwmp,fs,ui,nbi}
```
```
reboot
```
## Tampilan
https://github.com/alijayanet/multitab/issues/1#issue-3265263318
## Lisensi
© 2025 ALIJAYA ACS MULTITAB### SILAHKAN YANG INGIN BERBAGI

![Image](https://github.com/user-attachments/assets/724e5ac2-626e-4f2d-bd1f-1265b70b544f)

