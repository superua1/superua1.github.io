---
layout: tutorial
title:  "Log Kayıtları"
author: Taylan Özgür Bildik
excerpt: "Linux üzerindeki log kayıtları hakkında kısa bilgilendirme."
tags: [rsyslogd, dmesg]
categories: [egitimserisi, temel_linux]
cover: logcover.png
ders: 20
toc: true  
---


# Log Kayıtları

Sistemde meydana gelen hatalar, işlemler, değişiklikler ve neredeyse her faaliyet kayıt altına alınarak saklanır. Kayıt altına alınan bilgilere ”**log**” deniyor. Kontrol etmesi kolay olabilmesi için de elbette farklı türdeki bilgileri barındırmak için ayrı ayrı kayıtlar yani loglar tutuluyor. 

Bu sayede sistemle ilgili bir sorunu gidermeye çalışmak veya sistemde yetkisiz oturum açma girişimlerini kontrol etmek için elimizde veriler bulunabiliyor. Bu bölümde, log dosyalarının nerede tutulduğu, hangi bilgileri nasıl alabileceğimizden çok kısaca bahsediyor olacağız. 

Günümüzde modern Linux sistemlerinde log tutmak için **`rsyslogd`** isimli yapı kullanılıyor. Ayrıca bu yapıya ek olarak systemd’nin kapsayıcılık ilkesi dolayısıyla sunulan **`Systemd-journald`** loglama çözümü ****de mevcut. Fakat biz bu bölümde yalnızca temel seviyede bilgi edinmek üzere sistem üzerindeki standart log kayıtlarına değiniyor olacağız.

# Log Dosyalarının Konumu

`rsyslogd` tarafından üretilen ve yönetilen log dosyaları kategorize şekilde ***/var/log/*** dizini altında tutuluyor. Ayrıca sistem üzerindeki diğer çeşitli araçlar da genellikle kendi amaçları doğrultusunda yine ***/var/log/*** dizini altında log kayıtları tutuyorlar. 

Hemen `ls /var/log/` komutu ile dizin içeriğine göz atalım.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ ls /var/log/
alternatives.log       boot.log         daemon.log.3.gz  dpkg.log.6.gz   lastlog              nginx              syslog.4.gz
alternatives.log.1     boot.log.1       daemon.log.4.gz  dpkg.log.7.gz   lightdm              openvpn            sysstat
alternatives.log.2.gz  boot.log.2       debug            dpkg.log.8.gz   macchanger.log       postgresql         user.log
alternatives.log.3.gz  boot.log.3       debug.1          faillog         macchanger.log.1.gz  private            user.log.1
alternatives.log.4.gz  boot.log.4       debug.2.gz       fontconfig.log  macchanger.log.2.gz  README             user.log.2.gz
alternatives.log.5.gz  boot.log.5       debug.3.gz       inetsim         macchanger.log.3.gz  runit              user.log.3.gz
apache2                boot.log.6       debug.4.gz       installer       macchanger.log.4.gz  samba              user.log.4.gz
apt                    boot.log.7       dpkg.log         journal         messages             speech-dispatcher  wtmp
auth.log               btmp             dpkg.log.1       kern.log        messages.1           stunnel4           Xorg.0.log
auth.log.1             btmp.1           dpkg.log.2.gz    kern.log.1      messages.2.gz        syslog             Xorg.0.log.old
auth.log.2.gz          daemon.log       dpkg.log.3.gz    kern.log.2.gz   messages.3.gz        syslog.1           Xorg.1.log
auth.log.3.gz          daemon.log.1     dpkg.log.4.gz    kern.log.3.gz   messages.4.gz        syslog.2.gz        Xorg.1.log.old
auth.log.4.gz          daemon.log.2.gz  dpkg.log.5.gz    kern.log.4.gz   mysql                syslog.3.gz
```

Kullanmakta olduğunuz sistemde mevcut bulunan araçlar ve bu araçların ürettiği log kayıtlarına göre sizin aldığınız çıktı biraz farklı olabilir. Biz bu bölümde `rsyslogd` aracılığı ile sistem tarafından üretilen başlıca kayıtlara odaklanacağız. 

Kayıtlar standart dosya biçiminde tutulduğu için `cat` `grep` `head` `tail` gibi araçlar yardımıyla tüm kayıtları okuyup filtreleyebiliyoruz. Zaten daha önce metinsel verilerini nasıl işleyeceğimizi ele aldığımız için ihtiyaç duyduğunuz tüm araçların kullanım bilgisine sahipsiniz.

Ayrıca kayıt dosyaları, Redhat ve Debian tabanlı dağıtımlarda farklı isimlerde tutulabildiği için ben başlıklara her ikisini de eklemiş olacağım.  

Elbette kayıtları okumak için yönetici ayrıcalıklarına sahip olmak gerek. Standart kullanıcıların logları okuması güvenlik gereği mümkün değildir.

## syslog | messages

Uygulamalar, hizmetler ve sistem bileşenleri, çeşitli olaylar, hata mesajları, bilgi mesajları ve hata ayıklama mesajları gibi tüm kayıtlar ***/var/log/*** dizini altında *syslog* veya *messages* dosyalarında tutuluyor. Debian tabanlı dağıtımlar “**syslog**” ismi ile kayıt tutuyorken, Redhat tabanlı dağıtımlarda “**messages**” ismiyle aynı kayıtlar tutuluyor.

Ben debian dağıtımı üzerinden çalıştığım için en son 5 kayıt satırını okumak için `tail -n 5 /var/log/syslog` komutunu giriyorum. Siz Redhat üzerinde ***messages*** dosyasını okuyabilirsiniz.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ tail -n 5 /var/log/syslog
Jul 27 12:49:12 linuxdersleri systemd[1]: run-user-130.mount: Deactivated successfully.
Jul 27 12:49:12 linuxdersleri systemd[1]: user-runtime-dir@130.service: Deactivated successfully.
Jul 27 12:49:12 linuxdersleri systemd[1]: Stopped User Runtime Directory /run/user/130.
Jul 27 12:49:12 linuxdersleri systemd[1]: Removed slice User Slice of UID 130.
Jul 27 12:49:12 linuxdersleri systemd[1]: user-130.slice: Consumed 1.983s CPU time.
```

Örneğin NetworkManager hakkında sorun yaşamaya başladıysam `grep -i “networkmanager” /var/log/syslog | tail` komutunu girip son 10 kaydı inceleyebilirim.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ grep -i  networkmanager /var/log/syslog | tail                                                                                    
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.4240] policy: set 'Wired connection 1' (eth0) as default for IPv4 routing and DNS
Jul 27 07:14:35 linuxdersleri dbus-daemon[527]: [system] Activating via systemd: service name='org.freedesktop.resolve1' unit='dbus-org.freedesktop.resolve1.service' requested by ':1.4' (uid=0 pid=528 comm="/usr/sbin/NetworkManager --no-daemon ")
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.6018] device (eth0): state change: ip-check -> secondaries (reason 'none', sys-iface-state: 'managed')
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.6019] device (eth0): state change: secondaries -> activated (reason 'none', sys-iface-state: 'managed')
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.6022] manager: NetworkManager state is now CONNECTED_SITE
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.6023] device (eth0): Activation: successful, device activated.
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.6028] manager: NetworkManager state is now CONNECTED_GLOBAL
Jul 27 07:14:35 linuxdersleri NetworkManager[528]: <info>  [1690456475.6031] manager: startup complete
Jul 27 07:14:45 linuxdersleri systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.
Jul 27 07:56:36 linuxdersleri NetworkManager[528]: <info>  [1690458996.1981] agent-manager: agent[47b5561f98f13db4,:1.46/org.freedesktop.nm-applet/1000]: agent registered
```

Tarih bilgisine ve olay bilgisine bakarak, varsa bir değişim ya da hata kaynağını fark etmem mümkün olabilir. Benzer şekilde servisler, uygulamalar, çekirdek ve sistem geneli için bu dosya içeriğini kontrol etmemiz mümkün. 

En son kayıtlara ulaşmak için ***syslog*** dosyasını okudum. Fakat tüm kayıtlar bir tek bu dosyadan ibaret değil elbette. Geçmişten günümüzde tüm kayıtlar sıralı şekilde numaralandırılıp arşivleniyor. Bu durumu teyit etmek için `ls -l /var/log/syslog*`  komutunu girebiliriz. 

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ ls -l /var/log/syslog*
-rw-r----- 1 root adm 717817 Jul 27 12:49 /var/log/syslog
-rw-r----- 1 root adm 500455 Jul 24 09:04 /var/log/syslog.1
-rw-r----- 1 root adm 295719 Jul 16 06:56 /var/log/syslog.2.gz
-rw-r----- 1 root adm 437888 Jul  9 05:05 /var/log/syslog.3.gz
-rw-r----- 1 root adm 428440 Jul  2 09:15 /var/log/syslog.4.gz
```

Gördüğünüz gibi sırasıyla isimlendirilişmiş ***syslog.1** **syslog2.gz*** … şeklinde kayıtlar mevcut. Eğer daha önceki tarihlerde yer alan bir kayda bakmanız gerekiyorsan en yeniden eskiye doğru kayıtları inceleyebilirsiniz. Bu yaklaşım sayesinde kayıtların sistem üzerindeki dağınıklığı ve fazladan alan kullanımı önlenmiş oluyor. 

## auth.log | secure

Oturum açma ve kimlik doğrulama hakkında tutulan kayıtlardır. Örneğin Debian tabanlı dağıtımda en sonra oturum açma kayıtlarını görmek için `tail /var/log/auth.log` komutunu girebiliriz. 

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ tail /var/log/auth.log                                                                                                            
Jul 27 13:35:01 linuxdersleri CRON[68832]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:35:01 linuxdersleri CRON[68832]: pam_unix(cron:session): session closed for user root
Jul 27 13:36:42 linuxdersleri lightdm: gkr-pam: unable to locate daemon control file
Jul 27 13:36:42 linuxdersleri lightdm: gkr-pam: stashed password to try later in open session
Jul 27 13:36:42 linuxdersleri lightdm: pam_unix(lightdm-greeter:session): session closed for user lightdm
Jul 27 13:36:42 linuxdersleri systemd-logind[532]: Removed session c7.
Jul 27 13:39:01 linuxdersleri CRON[69797]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:39:01 linuxdersleri CRON[69797]: pam_unix(cron:session): session closed for user root
Jul 27 13:45:01 linuxdersleri CRON[71281]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:45:01 linuxdersleri CRON[71281]: pam_unix(cron:session): session closed for user root
```

Buradaki çıktılar oturum açma ve kimlik doğrulama hakkında sunulan bilgilerdir. Değişimi gözlemlemek için `sudo echo deneme` komutunu girip, parolamız ile onay verip daha sonra log kayıtlarını kontrol edebiliriz.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ sudo echo deneme                                                                                                                  
[sudo] password for taylan: 
deneme

┌──(taylan㉿linuxdersleri)-[~]
└─$ tail /var/log/auth.log                                                                                                            
Jul 27 13:36:42 linuxdersleri lightdm: gkr-pam: stashed password to try later in open session
Jul 27 13:36:42 linuxdersleri lightdm: pam_unix(lightdm-greeter:session): session closed for user lightdm
Jul 27 13:36:42 linuxdersleri systemd-logind[532]: Removed session c7.
Jul 27 13:39:01 linuxdersleri CRON[69797]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:39:01 linuxdersleri CRON[69797]: pam_unix(cron:session): session closed for user root
Jul 27 13:45:01 linuxdersleri CRON[71281]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:45:01 linuxdersleri CRON[71281]: pam_unix(cron:session): session closed for user root
Jul 27 13:48:16 linuxdersleri sudo:   taylan : TTY=pts/0 ; PWD=/home/taylan ; USER=root ; COMMAND=/usr/bin/echo deneme
Jul 27 13:48:16 linuxdersleri sudo: pam_unix(sudo:session): session opened for user root(uid=0) by (uid=1000)
Jul 27 13:48:16 linuxdersleri sudo: pam_unix(sudo:session): session closed for user root
```

Bakın **taylan** kullanıcısının **pts/0** konsolunda, ***/home/taylan*** dizinindeyken **root** kullanıcısı olarak `/urs/bin/echo deneme` komutunu çalıştırmak istediği ve yetkilendirmenin onaylandığı buradaki çıktılarda açıkça görülebiliyor. 

Benzer şekilde farklı bir kullanıcı hesabında oturum açıp değişimi gözlemleyebiliriz.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ su nil
Password: 
┌──(nil㉿linuxdersleri)-[/home/taylan]
└─$ tail /var/log/auth.log
tail: cannot open '/var/log/auth.log' for reading: Permission denied

┌──(nil㉿linuxdersleri)-[/home/taylan]
└─$ sudo tail /var/log/auth.log                                                                                                   
Jul 27 13:39:01 linuxdersleri CRON[69797]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:39:01 linuxdersleri CRON[69797]: pam_unix(cron:session): session closed for user root
Jul 27 13:45:01 linuxdersleri CRON[71281]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Jul 27 13:45:01 linuxdersleri CRON[71281]: pam_unix(cron:session): session closed for user root
Jul 27 13:48:16 linuxdersleri sudo:   taylan : TTY=pts/0 ; PWD=/home/taylan ; USER=root ; COMMAND=/usr/bin/echo deneme
Jul 27 13:48:16 linuxdersleri sudo: pam_unix(sudo:session): session opened for user root(uid=0) by (uid=1000)
Jul 27 13:48:16 linuxdersleri sudo: pam_unix(sudo:session): session closed for user root
Jul 27 13:50:04 linuxdersleri su: (to nil) taylan on pts/0
Jul 27 13:50:04 linuxdersleri su: pam_unix(su:session): session opened for user nil(uid=1001) by (uid=1000)
Jul 27 13:54:01 linuxdersleri sudo:      nil : TTY=pts/0 ; PWD=/home/taylan ; USER=root ; COMMAND=/usr/bin/tail /var/log/auth.log
```

Gördüğünüz gibi **taylan** kullanıcısının `su` ile **nil** kullanıcı hesabında oturum açtığı ve daha sonra yetkili şekilde log kayıtlarını incelediğini buradaki kayıtlardan işlem tarihiyle birlikte kontrol edebiliyoruz. **nil** kullanıcısını daha önce sistem yöneticisi grubuna eklediğim için `sudo` üzerinden log kayıtlarını okuyabildi. Fakat standart kullanıcılar bu kayıtları okuyamazlar.

Özetle Debian üzerinde “***auth.log***” Redhat üzerinde ise “***secure***” dosyaları üzerinden, oturum açma, kimlik doğrulama gibi işlemlerin kayıtlarını öğrenebiliyoruz. Örneğin bir kullanıcı sudo ile bir komut çalıştırmayı dener ama başarısız olursa yani parolayı yanlış girer veya yetkisi olmadığı halde işlemi yapmaya çalışırsa bu durum da kayıt ediliyor. Ben denemek için taylan kullanıcısı üzerinden `sudo` komutundan sonra sorulan parolayı bilerek 3 kez yanlış giriyorum.

```bash
──(taylan㉿linuxdersleri)-[~]
└─$ sudo echo deneme
[sudo] password for taylan: 
Sorry, try again.
[sudo] password for taylan: 
Sorry, try again.
[sudo] password for taylan: 
sudo: 3 incorrect password attempts

┌──(taylan㉿linuxdersleri)-[~]
└─$ tail -3 /var/log/auth.log
Jul 27 14:00:30 linuxdersleri sudo: pam_unix(sudo:session): session closed for user root
Jul 27 14:00:55 linuxdersleri sudo: pam_unix(sudo:auth): authentication failure; logname= uid=1000 euid=0 tty=/dev/pts/0 ruser=taylan rhost=  user=taylan
Jul 27 14:01:06 linuxdersleri sudo:   taylan : 3 incorrect password attempts ; TTY=pts/0 ; PWD=/home/taylan ; USER=root ; COMMAND=/usr/bin/echo deneme
```

Bakın taylan kullanıcısının 3 kez hatalı parola denemesi yaptığı burada açıkça yazıyor. Bu kayıtlara bakarak olası şüpheli durumlar ve davranışları anlamlandırmaya çalışabilirsiniz.

## boot.log

Önyükleme yani boot aşamasından sistem başlatılana kadar gerçekleşen tüm işlemlerin kayıtlarına ***/var/log/boot.log*** dosyası üzerinden ulaşabilirsiniz. 

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ sudo cat /var/log/boot.log                                                                                                       
[  OK  ] Finished Rotate log files.
[  OK  ] Finished Raise network interfaces.
[  OK  ] Started User Login Management.
[  OK  ] Started Virtualbox guest utils.
[  OK  ] Started Authorization Manager.
         Starting Modem Manager...
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
         Starting The Apache HTTP Server...
         Starting Permit User Sessions...
[  OK  ] Finished Permit User Sessions.
         Starting Light Display Manager...
         Starting Hold until boot process finishes up...
         Starting Hostname Service...
[  OK  ] Started Hostname Service.
[  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
```

Kayıtlar dolduğu için son önyüklemenin tamamını göremedim. Eğer bakmak istersem önceki kayda gözatabilirim.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ sudo cat /var/log/boot.log.1 
[  OK  ] Finished Rotate log files.
[  OK  ] Started User Login Management.
[  OK  ] Started Virtualbox guest utils.
[  OK  ] Finished Raise network interfaces.
[  OK  ] Started Authorization Manager.
         Starting Modem Manager...
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
         Starting The Apache HTTP Server...
         Starting Permit User Sessions...
[  OK  ] Finished Permit User Sessions.
         Starting Light Display Manager...
         Starting Hold until boot process finishes up...
         Starting Hostname Service...
[  OK  ] Started Hostname Service.
------------ Thu Jul 27 07:14:17 EDT 2023 ------------
/dev/sda1: recovering journal
/dev/sda1: Clearing orphaned inode 4457265 (uid=1000, gid=1000, mode=0100600, size=1574)
/dev/sda1: Clearing orphaned inode 4457264 (uid=1000, gid=1000, mode=0100600, size=1897296)
/dev/sda1: Clearing orphaned inode 4457261 (uid=1000, gid=1000, mode=0100600, size=6296)
/dev/sda1: Clearing orphaned inode 4456488 (uid=0, gid=0, mode=0100666, size=0)
/dev/sda1: clean, 338151/5185536 files, 3546889/20721152 blocks
[  OK  ] Finished Tell Plymouth To Write Out Runtime Data.
[  OK  ] Started Rule-based Manager for Device Events and Files.
         Starting Show Plymouth Boot Screen...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Reached target Path Units.
[  OK  ] Reached target Sound Card.
[  OK  ] Found device VBOX_HARDDISK 5.
         Activating swap /dev/disk/by-uuid/00253fba-ff78-4f04-b189-fbc974082345...
[  OK  ] Activated swap /dev/disk/by-uuid/00253fba-ff78-4f04-b189-fbc974082345.
[  OK  ] Reached target Swaps.
[  OK  ] Finished Flush Journal to Persistent Storage.
         Starting Create Volatile Files and Directories...
[  OK  ] Finished Create Volatile Files and Directories.
[  OK  ] Started Entropy Daemon based on the HAVEGE algorithm.
         Starting Record System Boot/Shutdown in UTMP...
[  OK  ] Finished Record System Boot/Shutdown in UTMP.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily dpkg database backup timer.
[  OK  ] Started Periodic ext4 Online Metadata Check for All Filesystems.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Daily man-db regeneration.
[  OK  ] Started Clean PHP session files every 30 mins.
[  OK  ] Started Update the plocate database daily.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started zaman.service için zamanlanmış görev tanımı.
[  OK  ] Reached target Timer Units.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Socket Units.
[  OK  ] Reached target Basic System.
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started D-Bus System Message Bus.
         Starting Network Manager...
         Starting Remove Stale Online ext4 Metadata Check Snapshots...
         Starting Authorization Manager...
         Starting System Logging Service...
         Starting User Login Management...
         Starting Virtualbox guest utils...
[  OK  ] Started zaman.sh isimli betik dosyasını çalıştıran servisin açıklamasıdır..
         Starting Clean php session files...
         Starting Rotate log files...
         Starting Daily man-db regeneration...
[  OK  ] Finished Remove Stale Online ext4 Metadata Check Snapshots.
[  OK  ] Started System Logging Service.
```

Gördüğünüz gibi kayıtlar sırasında önyükleme tarihi tam olarak satır arasında belirliyor. Bu sayede ilgili tarihteki önyükleme aşamasında verilen çıktıları kontrol edebiliyoruz.

## kern

Çekirdek yani kernel kayıtlarını incelemek için ***/var/log/kern.log*** dosyasını inceleyebiliriz.

Ben hata çıktıları için “**error**” tanımıyla filtreleme yapmak istiyorum.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ grep -i "error" /var/log/kern.log                                                                                                
Jul 24 15:11:11 linuxdersleri kernel: [22035.572938] A fatal guest X Window error occurred.  This may just mean that the Window system was shut down while the client was still runn
Jul 24 15:11:11 linuxdersleri kernel: [22035.575718] A fatal guest X Window error occurred.  This may just mean that the Window system was shut down while the client was still runn
Jul 24 15:11:11 linuxdersleri kernel: [22035.579149] A fatal guest X Window error occurred.  This may just mean that the Window system was shut down while the client was still runn
Jul 24 15:11:11 linuxdersleri kernel: [22035.582138] A fatal guest X Window error occurred.  This may just mean that the Window system was shut down while the client was still runn
Jul 24 15:11:11 linuxdersleri kernel: [22035.593373] Error waiting for HGCM thread to terminate: VERR_CANCELLED
Jul 24 15:11:11 linuxdersleri kernel: [22035.692454] pulseaudio[829]: segfault at 55b9150c179f ip 00007fda70630b47 sp 00007fffc3f2b7e0 error 4 in libICE.so.6.3.0[7fda7062b000+e000]
Jul 24 15:11:11 linuxdersleri kernel: [22035.820171] Error waiting for X11 thread to terminate: VERR_TIMEOUT
Jul 24 13:46:34 linuxdersleri kernel: [    3.979912] [drm:vmw_host_printf [vmwgfx]] *ERROR* Failed to send host log message.
Jul 24 13:46:34 linuxdersleri kernel: [   11.738757] EXT4-fs (sdb1): re-mounted. Opts: errors=remount-ro. Quota mode: none.
Jul 26 10:01:56 linuxdersleri kernel: [    4.765035] [drm:vmw_host_printf [vmwgfx]] *ERROR* Failed to send host log message.
Jul 26 10:01:56 linuxdersleri kernel: [   14.378637] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro. Quota mode: none.
Jul 27 07:14:26 linuxdersleri kernel: [    4.788743] [drm:vmw_host_printf [vmwgfx]] *ERROR* Failed to send host log message.
Jul 27 07:14:26 linuxdersleri kernel: [   15.806339] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro. Quota mode: none.
```

## apt

Debian tabanlı bir dağıtımda `apt` aracının kullanımı hakkındaki kayıtlara ulaşmak için ***/var/log/apt/*** dizininden kontrol edebiliyoruz. Bu dizin altında geçmiş kayıtları ***history*** ismiyle tutuluyor. 

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ tail /var/log/apt/history.log                                           
Install: libidn2-dev:amd64 (2.3.3-1+b1, automatic), libgnutls28-dev:amd64 (3.7.9-2), libtasn1-doc:amd64 (4.19.0-2, automatic), libp11-kit-dev:amd64 (0.24.1-2, automatic), libtasn1-6-dev:amd64 (4.19.0-2, automatic), nettle-dev:amd64 (3.8.1-2, automatic), libgnutls-openssl27:amd64 (3.7.9-2, automatic), libgnutlsxx30:amd64 (3.7.9-2, automatic)
Upgrade: libnettle8:amd64 (3.7.3-1, 3.8.1-2), libidn2-0:amd64 (2.3.2-2, 2.3.3-1+b1), libtasn1-6:amd64 (4.18.0-4, 4.19.0-2), libp11-kit0:amd64 (0.24.0-6, 0.24.1-2), p11-kit-modules:amd64 (0.24.0-6, 0.24.1-2), libhogweed6:amd64 (3.7.3-1, 3.8.1-2)
End-Date: 2023-07-05  09:47:58

Start-Date: 2023-07-10  11:42:01
Commandline: apt install lvm2
Requested-By: taylan (1000)
Install: dmeventd:amd64 (2:1.02.185-2, automatic), liblvm2cmd2.03:amd64 (2.03.16-2, automatic), lvm2:amd64 (2.03.16-2), libdevmapper-event1.02.1:amd64 (2:1.02.185-2, automatic), thin-provisioning-tools:amd64 (0.9.0-2, automatic)
Upgrade: dmsetup:amd64 (2:1.02.175-2.1, 2:1.02.185-2), libdevmapper1.02.1:amd64 (2:1.02.175-2.1, 2:1.02.185-2)
End-Date: 2023-07-10  11:43:29
```

Gördüğünüz gibi `apt` aracı kullanılarak yapılan son işlem hakkında bilgi almış oldum. Bu sayede kullanıcıların paket yükleme davranışlarını takip etmemiz de mümkün. 

## dpkg

`dpkg` paket yöneticisi kullanılarak gerçekleştirilmiş tüm işlemler hakkında bilgi almak için ***/var/log/dpkg*** dosyası inceleyebiliriz.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ tail /var/log/dpkg.log                                                  
2023-07-10 11:42:15 status installed kali-menu:all 2021.4.2
2023-07-10 11:42:15 trigproc initramfs-tools:all 0.140 <none>
2023-07-10 11:42:15 status half-configured initramfs-tools:all 0.140
2023-07-10 11:43:12 status installed initramfs-tools:all 0.140
2023-07-10 11:43:12 trigproc libc-bin:amd64 2.36-9 <none>
2023-07-10 11:43:12 status half-configured libc-bin:amd64 2.36-9
2023-07-10 11:43:26 status installed libc-bin:amd64 2.36-9
2023-07-10 11:43:26 trigproc man-db:amd64 2.9.4-4 <none>
2023-07-10 11:43:26 status half-configured man-db:amd64 2.9.4-4
2023-07-10 11:43:29 status installed man-db:amd64 2.9.4-4
```

## dnf

Redhat tabanlı dağıtımlarda gördüğünüz `dnf` paket yöneticisinin kullanımı hakkında tutulmuş olan kayıtlara ***/var/log/dnf*** konumundan ulaşabiliyoruz. Ben Rocky Linux üzerindeki kayıtlarımı kontrol ediyorum.

```bash
[taylan@linuxdersleri ~]$ tail /var/log/dnf.log

2023 - 07 -06T18:55:31+0300 DEBUG countme: no event for appstream: window already counted

2023 - 07 -06T18:55:42+0300 DEBUG reviving: ‘appstream' can be revived - repomd matches.

2023 -07-06T18:55:42+0300 DEBUG appstream: using metadata from Mon 63 Jul 2023 11:12:60 PM +03.
2023 - 07 -06T18:55:42+0300 DEBUG countme: no event for extras: window already counted

2023 - 07 -06T18:55:52+0300 DEBUG reviving: ‘extras' can be revived - repomd matches.

2023 -07-06T18:55:52+0300 DEBUG extras: using metadata from Mon 05 Jun 2023 09:56:04 PM +03.
2023 - 07 -06T18:55:52+0300 DEBUG User-Agent: constructed: ‘libdnf (Rocky Linux 9.1; generic; Linux.x
86 64) '

2023 - 07 -06T18:55:52+0300 DDEBUG timer: sack setup: 37973 ms

2023 -07-06T18:55:52+0300 INFO Metadata cache created.

2023-07 -06T18:55:52+0300 DDEBUG Cleaning up.
```

## cron

Eğer **cron-crontab** ile zamanlanmış görevler tanımlıysa, bu görevlerin çalışma kayıtlarına ***/var/log/cron*** dosyası üzerinden ulaşabiliyoruz. Ben cron ile zamanlanmış görev tanımlamadığım için benim sistemimde herhangi bir cron kaydı da bulunmuyor. Fakat özellikle güvenlik kontrolü için mutlaka sisteminizde tanımlı olan zamanlanmış görevleri ve bu görevlerin aktivitelerini takip edin.

## `dmesg` | Aygıt Kayıtları

Aygıtlarla ilgili log kayıtlarına göz atmak için `dmesg` aracını kullanabiliyoruz.

Ben örnek olarak Intel aygıtlarını listelemek istiyorum.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ sudo dmesg | grep -i "Intel"                                                                                              
[    0.841976] smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (family: 0x6, model: 0x5e, stepping: 0x3)
[    1.508334] intel_pstate: CPU model not supported
[    4.617000] e1000: Intel(R) PRO/1000 Network Driver
[    4.617002] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    5.447805] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[   22.138338] intel_pmc_core intel_pmc_core.0:  initialized
[   22.890967] snd_intel8x0 0000:00:05.0: allow list rate for 1028:0177 is 48000
```

Bu çıktılar sisteme hangi aygıtların bağlı olduğundan ziyade, bu aygıtların davranış kayıtlarıdır. Yani bu aygıtlar üzerinden gerçekleşen olayların kayıtlarıdır.

# Diğer Log Kayıtları Hakkına

Elbette burada bahsettiklerim dışında bizzat `ls /var/log/` komutunun çıktısında görebileceğiniz gibi pek çok farklı log dosyası mevcuttur. Fakat temel olarak bilmemiz gerekenlerden bahsetmiş olduk. Diğer kayıtlar için kısa bir araştırma yaparak tutulma amaçlarını keşfedebilirsiniz. Örneğin **apache2** servisinin verdiği hata kayıtlarını kontrol etmek için `cat /var/log/apache2/error.log` komutunu girebilirim.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ cat /var/log/apache2/error.log
[Thu Jul 27 07:14:41.404012 2023] [mpm_prefork:notice] [pid 730] AH00163: Apache/2.4.52 (Debian) configured -- resuming normal operations
[Thu Jul 27 07:14:41.404338 2023] [core:notice] [pid 730] AH00094: Command line: '/usr/sbin/apache2'
```

Bu şekilde sistem üzerindeki araçların kayıtlarını kontrol etmeniz mümkün. 

Ayrıca anlatımın başında atıfta bulunduğumuz gibi **systemd** aracının sunduğu **journald** log çözümü de modern sistemlerde mevcut. Standart loglama yaklaşımından farklı olarak, kayıtlar düz metin dosyaları  yerine binary dosyalar olarak kaydediliyor. Ve bu dosyaların kontrol edilmesi için de `journalctl` isimli komut satırı aracı kullanılıyor. Ben mevcut temel eğitimde bu araçtan bahsetmeyi planlamıyorum fakat merak ediyorsanız kısa bir araştırma yapmanız yeterli.