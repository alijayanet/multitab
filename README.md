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
<img width="1358" height="650" alt="Image" src="https://github.com/user-attachments/assets/d2689a26-9eed-4449-a0d3-2edffddd7bc6" />
<img width="1358" height="650" alt="Image" src="https://github.com/user-attachments/assets/c13ed312-d007-4cc2-987d-e82f171dd7ce" />
<img width="1358" height="650" alt="Image" src="https://github.com/user-attachments/assets/fdf7acae-cd32-404d-a50e-d77b59156ea5" />
<img width="1358" height="650" alt="Image" src="https://github.com/user-attachments/assets/2d530df8-beb3-493e-ad04-8bafbc39ad3f" />
## Lisensi
© 2025 ALIJAYA ACS MULTITAB### SILAHKAN YANG INGIN BERBAGI

![Image](https://github.com/user-attachments/assets/724e5ac2-626e-4f2d-bd1f-1265b70b544f)

