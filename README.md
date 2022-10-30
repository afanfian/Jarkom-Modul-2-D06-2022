# Laporan Resmi Praktikum Modul 2 Jarkom Kelompok D06
Dokumen laporan resmi praktikum modul 2 Jarkom Kelompok D06 Jaringan Komputer D Tahun 2022/2023

### Anggota Kelompok:
Nama Lengkap                | NRP
--------------------------- | -------------
Fian Awamiry Maulana        | 5025201035 
Rere Arga Dewanata          | 5025201078 
Muhamad Ridho Pratama       | 5025201186

## Daftar Isi  
- [Laporan Resmi Praktikum Modul 2 Jarkom Kelompok D06](#laporan-resmi-praktikum-modul-2-jarkom-kelompok-d06)
    - [Anggota Kelompok:](#anggota-kelompok)
  - [Daftar Isi](#daftar-isi)
  - [Soal 1](#soal-1)
  - [Soal 2](#soal-2)
  - [Soal 3](#soal-3)
  - [Soal 4](#soal-4)
  - [Soal 5](#soal-5)
  - [Soal 6](#soal-6)
  - [Soal 7](#soal-7)
  - [Soal 8](#soal-8)
  - [Soal 9](#soal-9)
  - [Soal 10](#soal-10)
  - [Soal 11](#soal-11)
  - [Soal 12](#soal-12)
  - [Soal 13](#soal-13)
  - [Soal 14](#soal-14)
  - [Soal 15](#soal-15)
  - [Soal 16](#soal-16)
  - [Soal 17](#soal-17)
  - [Kendala Pengerjaan](#kendala-pengerjaan)

## Soal 1   
   WISE akan dijadikan sebagai DNS Master, Berlint akan dijadikan DNS Slave, dan Eden akan digunakan sebagai Web Server. Terdapat 2 Client yaitu SSS, dan Garden. Semua node terhubung pada router Ostania, sehingga dapat mengakses internet.  
   
   **Jawaban Soal 1**  
   
   1. Klik ```servers``` di kiri atas.
   2. Klik ```local```.
   3. Klik ```Add blank project```.
   4. Masukkan nama ```project``` yang diinginkan.
   5. Klik ```Add project```.
   6. Klik tombol `Add a node` di samping kiri.
   7. Lalu tarik `ubuntu-1` ke area kosong di halaman.
   8. Tunggu hingga proses loading selesai.
   9. Jika berhasil, maka akan menampilkan tampilan seperti berikut : <br>
![image](https://user-images.githubusercontent.com/72689610/139519228-16e8c278-119a-4ce7-8ad9-5e7be93f418d.png)  
   10. Dibawah ini merupakan topologi dari soal modul 2:  
   ![soal1_no10](https://user-images.githubusercontent.com/55425460/198859647-4b123e1c-d23a-46d8-8d46-54f9d4c2ffed.png)
   11. Kita perlu melakukan setting network pada masing-masing node dengan fitur `Edit network configuration`, untuk konfigurasi network pada masing - masing node diisi dengan setting sebagai berikut :
   - Ostania
   ```
   auto eth0
   iface eth0 inet dhcp

   auto eth1
   iface eth1 inet static
      address 10.18.1.1
      netmask 255.255.255.0

   auto eth2
   iface eth2 inet static
      address 10.18.2.1
      netmask 255.255.255.0
      
   auto eth3
   iface eth2 inet static
      address 10.18.3.1
      netmask 255.255.255.0
   ```
   - SSS
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.1.2
      netmask 255.255.255.0
      gateway 10.18.1.1
   ```
   - Garden
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.1.3
      netmask 255.255.255.0
      gateway 10.18.1.1
   ```
   - Wise
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.2.2
      netmask 255.255.255.0
      gateway 10.18.2.1
   ```
   - Berlint
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.3.2
      netmask 255.255.255.0
      gateway 10.18.3.1
   ```
   - Eden
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.3.3
      netmask 255.255.255.0
      gateway 10.18.3.1
  ```  
   12. Restart semua node.  
   13. Topologi sudah bisa berjalan secara lokal, namun untuk mengakses jaringan keluar maka perlu dilakukan beberapa konfigurasi sebagai berikut:
   - Ketikkan command berikut di `Ostania`
    ```
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.173.0.0/16
    ```

   - Ketikkan command `cat /etc/resolv.conf` di `Ostania` kemudian copy outputnya
   ```
   nameserver 192.168.122.1
   ```

   - Pada node Wise, SSS, Garden dan Eden, masukkan command yang didapat dari `Ostania` ke `/etc/resolv.conf`: 
   ```
   echo nameserver 192.168.122.1 > /etc/resolv.conf
   ```
   
   Berikut adalah screenshot melakukan `ping` ke google.com dari node `SSS`
   ![soal1_no13](https://user-images.githubusercontent.com/55425460/198862626-87d4e510-e5e9-4d8c-bc88-cfdd28f0ce00.png)

## Soal 2   
   Untuk mempermudah mendapatkan informasi mengenai misi dari Handler, bantulah Loid membuat website utama dengan akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise.  

   **Jawaban Soal 2**
1. Install semua package yang diperlukan terlebih dahulu
   1. Pada `Wise` dan `Berlint`, install bind9 dengan memasukkan command berikut:
      ```
      apt-get-update
      apt-get install bind9 -y
      ```
   2. Pada `SSS` dan `Garden`, install dnsutils dan lynx
      ```
      apt-get update
      apt-get install dnsutils lynx -y
      ```
   3. Pada `Eden`, install package berikut:
      ```
      apt-get update
      apt-get apache2 php libapache2-mod-php7.0 -y
      ```

2. Masukkan command berikut pada `Wise`
   ```
   nano /etc/bind/named.conf.local
   ```

3. Isikan configurasi zone domain **wise.d06.com** sesuai dengan syntax berikut:
   ```
   zone "wise.d06.com" {
      type master;
      file "/etc/bind/wise/wise.d06.com";
   };
   ```

4. Buat folder **wise** di dalam /etc/bind
  ```
  mkdir /etc/bind/wise
  ```

5. Copy file `db.local` pada path `/etc/bind` ke dalam folder **wise** yang baru saja dibuat dan ubah namanya menjadi `wise.d06.com`
  ```
  cp /etc/bind/db.local /etc/bind/wise/wise.d06.com
  ```

6. Buka file **wise.d06.com** dan edit seperti gambar berikut dengan IP 10.18.2.2 dan IP 10.18.3.3 serta record CNAME `www` <br>
   ![soal2_no8](https://user-images.githubusercontent.com/55425460/198859715-d561b877-12e1-48c8-b354-7465879d62b6.png)

7. Restart bind9 dengan command `service bind9 restart`

8. Comment nameserver `Ostania` pada `etc/resolv.conf` di node `SSS` dan `Garden` kemudian tambahkan `nameserver 10.18.2.2` <br>
   ![soal2_no10](https://user-images.githubusercontent.com/55425460/198859719-ebb59b6b-6100-4fb0-a15a-0550a275b270.png)

9.  Kemudian test dengan cara ping IP `wise.d06.com` dan `wise.d06.com` pada `SSS` atau `Garden` <br>
   ![soal2_no11](https://user-images.githubusercontent.com/55425460/198859739-4dbaa2b3-1e6c-4afd-a116-603a1a67634e.png)

## Soal 3  
   Setelah itu ia juga ingin membuat subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com yang diatur DNS-nya di WISE dan mengarah ke Eden.  
   
   **Jawaban Soal 3**
   1. Jalankan command `nano /etc/bind/kaizoku/wise.d06.com` dan masukkan data seperti gambar berikut untuk membuat subdomain dan aliasnya <br>
      ![soal3_no1](https://user-images.githubusercontent.com/55425460/198859756-b5bac97a-f84f-4332-a96b-49fef1c19792.png)

   2. Restart bind9 dengan menggunakan command `service bind9 restart`
   3. Kemudian test dengan cara ping IP `eden.wise.d06.com` dan `www.eden.wise.d06.com` pada `SSS` atau `Graden` <br>
     ![soal3_no3](https://user-images.githubusercontent.com/55425460/198859761-b95e44de-eb1e-4dae-a7b0-1082d5d5f1b8.png)

## Soal 4   
   Buat juga reverse domain untuk domain utama.  
   
   **Jawaban Soal 4**  
   1. Jalankan command `nano /etc/bind/named.conf.local` pada `Wise`
   2. Lalu tambahkan konfigurasi berikut ke dalam file `named.conf.local` dibawah zone `wise.d06.com`. Tambahkan reverse IP `10.18.2` yaitu `2.18.10`. 
	```
	zone "2.18.10.in-addr.arpa" {
	   type master;
	   file "/etc/bind/wise/2.18.10.in-addr.arpa";
	};
	```
	![soal4_no2](https://user-images.githubusercontent.com/55425460/198859772-7574a680-8187-4f5b-abb8-be7f5ab4e8d7.png)

   3. Copykan file `db.local` pada path `/etc/bind` ke dalam folder **wise** yang baru saja dibuat dan ubah namanya menjadi `2.18.10.in-addr.arpa`  
   4. Edit file `2.18.10.in-addr.arpaa` menggunakan command `nano/etc/bind/wise/2.18.10.in-addr.arpa` menjadi seperti gambar di bawah ini <br>
      ![soal4_no4](https://user-images.githubusercontent.com/55425460/198859791-aeefde1f-09e7-4363-9ffd-a0bcfa0ea73b.png)
   5. Restart bind9 dengan command `service bind9 restart`
   6. Test dengan cara mengetikkan command `host -t PTR "10.18.2.2"` pada `SSS`. Jika muncul seperti pada gambar berikut berarti sudah benar. <br>  
      ![soal4_no6](https://user-images.githubusercontent.com/55425460/198859804-a8dd7a39-30a5-4a58-9a4f-05c47fd0baf8.png)

      
## Soal 5   
   Agar dapat tetap dihubungi jika server WISE bermasalah, buatlah juga Berlint sebagai DNS Slave untuk domain utama.  
   
   **Jawaban Soal 5**  
   1. Edit file `/etc/bind/named.conf.local` pada `Wise` tepatnya pada zone `wise.d06.com` dan sesuaikan dengan syntax berikut
	 ```
	 zone "wise.d06.com" {
		type master;
		notify yes;
		also-notify { 10.18.3.2; };
		allow-transfer { 10.18.3.2; };
		file "/etc/bind/wise/wise.d06.com";
	};
	 ```
	![soal5_no1](https://user-images.githubusercontent.com/55425460/198859814-42df8001-365d-4ef6-9b30-fc3d780f5cda.png)

   2. Restart bind9 `Wise` dengan command `service bind9 restart`
   3. Kemudian buka file `/etc/bind/named.conf.local` pada `Berlint` dan tambahkan syntax berikut:
	 ```
	 zone "wise.d06.com" {
	    type slave;
	    masters { 10.18.2.2; };
	    file "/var/lib/bind/wise.d06.com";
	};
	 ```
	![soal5_no3](https://user-images.githubusercontent.com/55425460/198859819-972ce91f-e68b-44d1-bdc7-b0b29f0bf717.png)

   4. Restart bind9 `Berlint` dengan command `service bind9 restart`
   5. Test dengan cara mematikan bind9 pada `Wise` yaitu dengan mengetikkan comman `service bind9 stop`
  	![soal5_no5](https://user-images.githubusercontent.com/55425460/198859832-650f3f6d-f01a-4e6a-89dc-112d72135ff3.png)

   6. Di node `SSS` dan `Garden` tambahkan `nameserver 10.18.3.2`.
   7. Lalu ping ke semua domain atau subdomain yang telah dibuat.
   	![soal5_no7](https://user-images.githubusercontent.com/55425460/198859836-8d9756dd-f103-4c48-8858-ee0097b4655b.png)

   	
## Soal 6   
   Karena banyak informasi dari Handler, buatlah subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com yang didelegasikan dari WISE ke Berlint dengan IP menuju ke Eden dalam folder operation.  
      
   **Jawaban Soal 6**  
   1. Pada `Wise`, edit file `/etc/bind/wise/wise.d06.com` dan ubah menjadi seperti di bawah ini. <br>
	![soal6_no1](https://user-images.githubusercontent.com/55425460/198860327-bc4968ba-75c4-4102-a62b-96dc18db0fa6.png)

   2. Kemudian edit file `/etc/bind/named.conf.options` pada `Wise`, comment `dnssec-validation auto;` dan tambahkan `allow-query{any;};` <br>
   ![soal6_no2](https://user-images.githubusercontent.com/55425460/198860339-3e29f2bd-9950-4ede-ba14-28e2830e56a2.png)

   3. Restart bind9 pada `Wise` dengan command `service bind9 restart`
   4. Lakukan langkah kedua pada `Berlint`
   5. Lalu edit file `/etc/bind/named.conf.local` pada `Berlint` tambahkan syntax berikut:
      ```
         zone "operation.wise.d06.com" {
         type master;
         file "/etc/bind/wise/operation.wise.d06.com";
         };
      ```
	![soal6_no5](https://user-images.githubusercontent.com/55425460/198860354-aef8c607-a087-4f48-9fd9-033095a7e867.png)

   6. Kemudian buatlah folder `operation` pada `Berlint` dengan mengetikkan command `mkdir /etc/bind/operation`
   7. Dan ketikkan command `cp /etc/bind/db.local /etc/bind/operation/operation.wise.d06.com` pada `Berlint`
   8. Kemudian edit file `operation.wise.d06.com` pada `Berlint` menjadi seperti dibawah ini <br>
      ![soal6_no8](https://user-images.githubusercontent.com/55425460/198860357-af8c3386-6d23-4793-b268-d29e0dd19044.png)

   9. Restart bind9 `Berlint` dengan command `service bind9 restart`
   10. Kemudian test dengan cara ping IP `operation.wise.d06.com` dan `www.operation.wise.d06.com` pada `SSS` atau `Garden` <br>
      ![soal6_no10](https://user-images.githubusercontent.com/55425460/198860359-41a7fd0d-b8fd-4074-9329-0ae978297010.png)

      
## Soal 7   
   Untuk informasi yang lebih spesifik mengenai Operation Strix, buatlah subdomain melalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com yang mengarah ke Eden.  
      
   **Jawaban Soal 7**  
   1. Jalankan command `nano /etc/bind/wise/operation.wise.d06.com` pada `Berlint` dan edit seperti gambar berikut untuk membuat subdomain dan aliasnya <br>
   	![soal7_no1](https://user-images.githubusercontent.com/55425460/198860106-e51fb886-12a1-4750-9007-9aed97a2e9ea.png)

   2. Restart bind9 `Berlint` dengan command `service bind9 restart`
   3. Kemudian test dengan cara ping IP `strix.operation.wise.d06.com` dan `www.strix.operation.wise.d06.com` pada `SSS` atau `Garden` <br>
 	![soal7_no3](https://user-images.githubusercontent.com/55425460/198860112-9ab5dcc8-13ea-496c-80c8-07dbf70a39ea.png)

    
## Soal 8   
   Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver www.wise.yyy.com. Pertama, Loid membutuhkan webserver dengan DocumentRoot pada /var/www/wise.yyy.com.
    
   **Jawaban Soal 8**  
   Pada Node EDEN, lakukan langkah berikut:
   1. Copy file /etc/apache2/sites-available/000-default.conf ke /etc/apache2/sites-available/wise.d06.com.conf dengan command
      ```
      	cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wise.d06.com.conf 
      ```
   2. Edit file wise.d06.com.conf menjadi 
      ```
      <VirtualHost *:80>
         ServerAdmin webmaster@localhost
         DocumentRoot /var/www/wise.d06.com
         ServerName www.wise.d06.com
         ServerAlias www.wise.d06.com wise.d06.com
         
         ErrorLog ${APACHE_LOG_DIR}/error.log
         CustomLog ${APACHE_LOG_DIR}/access.log combined
      </VirtualHost>
      ```
   3. Mengaktifkan konfigurasi yang telah dibuat dengan command
      ```
      a2ensite wise.d06.com
      ```
   4. Download semua resource soal dan letakkan pada /var/www/eden.wise.d06.com
   5. Ketika Mengakses url www.wise.d06.com dengan lynx maka akan didapatkan hasil berikut.  
      ![soal8_no5](https://user-images.githubusercontent.com/55425460/198860388-08173071-973c-4327-a0c9-82ac763bca7c.png)

      
## Soal 9   
   Setelah itu, Loid juga membutuhkan agar url www.wise.yyy.com/index.php/home dapat menjadi menjadi www.wise.yyy.com/home.  
      
   **Jawaban Soal 9** 
   1. Edit file wise.d06.com.conf menjadi 
      ```
      <VirtualHost *:80>
         ServerAdmin webmaster@localhost
         DocumentRoot /var/www/wise.d06.com
         ServerName www.wise.d06.com
         ServerAlias www.wise.d06.com wise.d06.com

         <Directory /var/www/wise.d06.com.conf>
            Options +FollowSymLinks -Multiviews
            AllowOverride All
         </Directory>
         
         ErrorLog ${APACHE_LOG_DIR}/error.log
         CustomLog ${APACHE_LOG_DIR}/access.log combined
	   </VirtualHost>

      ```  
   2. Buat file .htaccess pada direktori /var/www/wise.d06.com lalu isikan dengan
      ```
      RewriteEngine On
      RewriteCond %{REQUEST_FILENAME} !-d
      RewriteRule ^home$ index.php/home
      ```    
   3. Restart apache2 dengan cara `service apache2 restart` 
   4. Ketika Mengakses url www.wise.d06.com/home dengan lynx maka akan didapatkan hasil berikut.  
      ![soal9_no4](https://user-images.githubusercontent.com/55425460/198860394-ff7a21e8-8133-4700-ad53-8f4cf7a35ef4.png)

      
## Soal 10   
   Setelah itu, pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com.  
      
   **Jawaban Soal 10** 
   1. Copy file 000-default.conf menjadi file eden.wise.d06.com.conf, lalu edit menjadi:
   ```
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/eden.wise.d06.com
      ServerName www.eden.wise.d06.com
      ServerAlias www.eden.wise.d06.com eden.wise.d06.com

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
   </VirtualHost>
   ```
   2. Buat folder /var/www/eden.wise.d06.com
      ```
      mkdir /var/www/eden.wise.d06.com
      ```
   3. Masukkan semua resource untuk eden.wise ke folder /var/www/eden.wise.d06.com
   4. Aktifkan file konfigurasi dengan `a2ensite eden.wise.d06.com`
   5. Restart apache dengan cara `service apache2 restart`
   6. Ketika Mengakses url www.eden.wise.d06.com dengan lynx maka akan didapatkan hasil berikut.  
      ![soal10_no3](https://user-images.githubusercontent.com/55425460/198860422-c16827e3-c8b5-4230-88cd-ed1c2a057634.png)

      
## Soal 11   
   Akan tetapi, pada folder /public, Loid ingin hanya dapat melakukan directory listing saja.  
      
   **Jawaban Soal 11** 
   1. Mengedit file eden.wise.d06.com.conf dengan menambahkan `Options +Indexes` untuk /public, dan `Options -Indexes` untuk /error menjadi seperti ini
   ```
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/eden.wise.d06.com
      ServerName www.eden.wise.d06.com
      ServerAlias www.eden.wise.d06.com eden.wise.d06.com

      <Directory /var/www/eden.wise.d06.com/public>
         Options +Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/error>
         Options -Indexes
      </Directory>

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
   </VirtualHost>
   ```
   2. Restart apache dengan cara `service apache2 restart`
   3. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/public dengan lynx.  
      ![soal11_no3](https://user-images.githubusercontent.com/55425460/198860436-6575a65e-3d0b-42e3-bd67-5b68af2d99ab.png)

      
## Soal 12   
   Tidak hanya itu, Loid juga ingin menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache.  
      
   **Jawaban Soal 12** 
   1. Mengedit file eden.wise.d06.com.conf dengan menambahkan `ErrorDocument 404 /error/404.html` menjadi seperti ini  

      ```
      <VirtualHost *:80>
         ServerAdmin webmaster@localhost
         DocumentRoot /var/www/eden.wise.d06.com
         ServerName www.eden.wise.d06.com
         ServerAlias www.eden.wise.d06.com eden.wise.d06.com

         <Directory /var/www/eden.wise.d06.com/public>
            Options +Indexes
         </Directory>

         <Directory /var/www/eden.wise.d06.com/error>
            Options -Indexes
         </Directory>

         ErrorDocument 404 /error/404.html

         ErrorLog ${APACHE_LOG_DIR}/error.log
         CustomLog ${APACHE_LOG_DIR}/access.log combined
      </VirtualHost>
      ```
   2. Restart apache dengan cara `service apache2 restart`
   3. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/cek dengan lynx.  
      ![soal12_no3](https://user-images.githubusercontent.com/55425460/198860444-78ad436c-d8e3-4f7e-be6a-2007ba94f1d1.png)

      
## Soal 13   
   Loid juga meminta Franky untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js (13).  
      
   **Jawaban Soal 13**  
   1. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/public/js dengan lynx.  
      ![soal13_no1](https://user-images.githubusercontent.com/55425460/198860467-3e1558e5-c189-4045-9c89-18f51588e500.png)
      
   2. Mengedit file eden.wise.d06.com.conf dengan menambahkan `Alias "/js" "/var/www/eden.wise.d06.com/public/js"` menjadi seperti ini
   ```
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/eden.wise.d06.com
      ServerName www.eden.wise.d06.com
      ServerAlias www.eden.wise.d06.com eden.wise.d06.com

      <Directory /var/www/eden.wise.d06.com/public>
         Options +Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/error>
         Options -Indexes
      </Directory>

      Alias "/js" "/var/www/eden.wise.d06.com/public/js"

      ErrorDocument 404 /error/404.html

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
   </VirtualHost>
   ```
   3. Restart apache dengan cara `service apache2 restart`
   4. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/js dengan lynx.  
      ![soal13_no4](https://user-images.githubusercontent.com/55425460/198860468-6908d586-b805-479e-b254-4c10951f2635.png)
      
## Soal 14   
   Loid meminta agar www.strix.operation.wise.yyy.com hanya bisa diakses dengan port 15000 dan port 15500.  
      
   **Jawaban Soal 14** 
   1. Di `/etc/apache2/sites-available`, buat dan edit file strix.operation.wise.d06.com.conf
      Ubah port pada tag <VirtualHost> menjadi 15000 dan 15500

   ```
      <VirtualHost *:15000 *:15500>

      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/strix.operation.wise.d06
      ServerName www.strix.operation.wise.d06.com
      ServerAlias www.strix.operation.wise.d06.com strix.operation.wise.d06.com

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined

      </VirtualHost>
   ```
   2. Menambahkan port pada /etc/apache2/ports.conf menjadi seperti ini
   ```
   Listen 80
   Listen 15000
   Listen 15500

   <IfModule ssl_module>
      Listen 443
   </IfModule>

   <IfModule mod_gnutls.c>
      Listen 443
   </IfModule>
   ```
   3. Buat folder /var/www/strix.operation.wise.d06, lalu masukkan semua resource soal strix.operation.wise ke folder tersebut
      ```
      mkdir /var/www/strix.operation.wise.d06
      ```
   4. Aktifkan konfigurasi strix.operation.wise.d06.com dengan `a2ensite strix.operation.wise.d06.com`
   5. Restart apache dengan cara `service apache2 restart`
   6. Berikut adalah tampilan ketika mengakses url www.strix.operation.wise.d06.com:15000 dengan lynx.  
      ![soal14_no4](https://user-images.githubusercontent.com/55425460/198860478-6ad7ac91-326f-4d10-a858-b3858092b6c8.png)

   7. Berikut adalah tampilan ketika mengakses url www.strix.operation.wise.d06.com:15500 dengan lynx.  
      ![soal14_no5](https://user-images.githubusercontent.com/55425460/198860485-fe9b17db-5f20-4d78-a019-ea1342e0ff32.png)

## Soal 15   
   Dengan autentikasi username Twilight dan password opStrix dan file di /var/www/strix.operation.wise.yyy (15).
      
   **Jawaban Soal 15** 

   1. Pada Eden, di file /etc/apache2/sites-available/strix.operation.wise.d06.com.conf, tambahkan line berikut:

   ```
   <Directory /var/www/strix.operation.wise.d06>
		AuthType Basic
		AuthName "Restricted Content"
		AuthUserFile /etc/apache2/.htpasswd
		Require valid-user
	</Directory>
   ```

   sehingga menjadi

   ```
   <VirtualHost *:15000 *:15500>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/strix.operation.wise.d06
      ServerName www.strix.operation.wise.d06.com
      ServerAlias www.strix.operation.wise.d06.com strix.operation.wise.d06.com

      <Directory /var/www/strix.operation.wise.d06>
         AuthType Basic
         AuthName "Restricted Content"
         AuthUserFile /etc/apache2/.htpasswd
         Require valid-user
      </Directory>

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined

   </VirtualHost>
   ```
   
   2. Lalu, buat file .htpasswd dengan username Twilight dan diletakkan di /etc/apache2, dengan cara menjalankan command `htpasswd -c /etc/apache2 Twilight`, lalu akan diminta untuk memasukkan password, ketikkan "opStrix" tanpa tanda petik.

   Berikut adalah screenshot saat mengakses www.strix.operation.wise.d06.com dengan port 15000 dan 15500
	![soal15_no2_password](https://user-images.githubusercontent.com/55425460/198860505-f1e6dfe1-a191-4814-8d8d-ffd15c450abe.png)
	![soal15_no2_username](https://user-images.githubusercontent.com/55425460/198860507-26d64fe8-be2b-4400-931a-34830b16fe08.png)

   
## Soal 16   
   Dan setiap kali mengakses IP Eden akan dialihkan secara otomatis ke www.wise.yyy.com (16).  
      
   **Jawaban Soal 16**

   Pada node Eden, di file /etc/apache2/sites-available/000-default.conf, ganti variabel DocumentRoot ke /var/www/wise.d06.com
   ```
   <VirtualHost *:80>
      DocumentRoot /var/www/wise.d06.com
   </VirtualHost>
   ```
   
   Berikut adalah hasil dari `ping 10.18.3.3`:
   ![soal16](https://user-images.githubusercontent.com/55425460/198860530-fa77c826-bcc4-4223-ae5c-c8bde5d5435a.png)


## Soal 17   
   Karena website www.eden.wise.yyy.com semakin banyak pengunjung dan banyak modifikasi sehingga banyak gambar-gambar yang random, maka Loid ingin mengubah request gambar yang memiliki substring “eden” akan diarahkan menuju eden.png. Bantulah Agent Twilight dan Organisasi WISE menjaga perdamaian! (17).   
      
   **Jawaban Soal 17**

   1. Pada Eden, tambahkan line berikut ke file /etc/apache2/sites-available/eden.wise.d06.com.conf
   ```
   <Directory /var/www/eden.wise.d06.com>
            AllowOverride All
   </Directory>
   ```
   2. Buat file .htaccess di /var/www/eden.wise.d06.com, lalu tambahkan line berikut
   ```
   RewriteEngine On
   RewriteRule ^(.*)eden(.*)$ http://www.eden.wise.d06.com/public/images/eden.png [L,R=301]
   ```

   Berikut adalah screenshot saat mengakses `www.eden.wise.d06.com/eden`:
   ![soal17](https://user-images.githubusercontent.com/55425460/198862679-72f39dcd-2232-4d08-99d7-046cfd6e8ad1.png)

## Kendala Pengerjaan
   - Terdapat masalah/error saat export/import portable object dari/ke versi GNS3 yang berbeda. Pada modul, dijelaskan untuk VirtualBox menggunakan versi GNS3 2.2.19 dan untuk VMWare menggunakan versi GNS3 2.2.26. Akan tetapi, portable project dari versi 2.2.26 (serta kami juga mencoba 2.2.34) tidak bisa di-import ke 2.2.19
   - Sempat bingung kapan menggunakan DNS record A dan kapan menggunakan CNAME saat ingin membuat alias
   - Beberapa alamat web server sempat tidak bisa diakses, tetapi bisa di-`ping` dan kami tidak menemukan error-nya, akhirnya kami memutuskan untuk membuat semuanya dari ulang
   - Pada no. 16, saat mengakses alamat Eden, malah ter-redirect ke alamat eden.wise.d06.com, bukan ke wise.d06.com
