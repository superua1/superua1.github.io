---
layout: komut
author: Taylan Özgür Bildik
title: "exit Komutu"
modified: 2021-04-14
excerpt: "Kabuğu sonlandırıp, çıkış kodu döndürülmesini sağlar."
tags: [bash, exit]
categories: komutlar 
toc: true 
---



Mevcut kabuktan çıkılmasını sağlar. En temel kullanımını denemek için öncelikle bash komutunu girip yeni bir alt kabuk başlatalım.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ ps f
    PID TTY      STAT   TIME COMMAND
  12275 pts/0    Ss     0:00 /usr/bin/bash
  12286 pts/0    S      0:00  \_ bash
  12297 pts/0    R+     0:00      \_ ps f
```

Mevcut bash kabuğu altında yeni bir alt bash kabuğunun başlatıldığını `ps f` komutu sayesinde teyit etmiş olduk. Şu anda başlatılmış olan alt bash kabuğunda çalışıyoruz. Bu kabuğu kapatarak çıkış yapmak için `exit` komutunu girmemiz yeterli.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ exit
exit

┌──(taylan㉿linuxdersleri)-[~]
└─$ ps f
    PID TTY      STAT   TIME COMMAND
  12275 pts/0    Ss     0:00 /usr/bin/bash
  12676 pts/0    R+     0:00  \_ ps f
```

`exit` komutu sayesinde çalışmakta olduğumuz mevcut kabuğu kapatmış olduk. İşte `exit` komutunun en temel kullanımı bu şekilde. Bu temel kullanım dışında `exit` komutu sayesinde, işlem sonlandırılırken döndürülecek olan çıkış kodunu belirtmemiz de mümkündür. 

## Çıkış Kodlarının Döndürülmesi | Exit Code

`exit` komutuyla birlikte argüman olarak girilen sayısal değer, kabuk kapatıldıktan sonra döndürülecek olan çıkış değerini temsil eder. Normal şartlarda kabuk üzerinden çalıştırmış olduğumuz komutlar çalışır ve çalışma işlemi bittiğinde eğer komut hatasız çalıştıysa “**0**” çıkış değerini döndürür. Fakat komutun çalıştırılması sonucunda ortaya hata ya da herhangi bir eksiklik çıktıysa çıkış kodları “**1**” ile “**255**” arasında bir değer olarak basılır. İşte bizler de `exit` komutu ile duruma göre mevcut sürecin sonlandırılıp, üretilmesi gereken çıkış kodunu spesifik olarak tanımlayabiliyoruz. Özellikle bash programlama yaparken sık kullanılan bir komuttur. 

Hemen denemek için basit bir betik dosyası oluşturup, işlem tamamlandıktan sonra çıkış değeri olarak “**111**” değerini döndürmesini sağlayalım.

```bash
read -p "Lütfen pozitif bir tam sayı girin:" sayi
if [[ $sayi -lt 0 ]]
        then
                exit 111
        else
                echo $sayi
fi

```

Betik dosyamızın çalışması bittiğinde döndürülmüş olan çıkış kodunu `echo $?` komutuyla öğrenebiliyoruz. Denemek için hem pozitif hem de negatif tam sayı girildiğinde üretilen çıkış kodlarına bakalım.

```bash
┌──(taylan㉿linuxdersleri)-[~]
└─$ ./betik.sh 
Lütfen pozitif bir tam sayı girin:5
5

┌──(taylan㉿linuxdersleri)-[~]
└─$ echo $?
0

┌──(taylan㉿linuxdersleri)-[~]
└─$ ./betik.sh 
Lütfen pozitif bir tam sayı girin:-5

┌──(taylan㉿linuxdersleri)-[~]
└─$ echo $?
111
```

Çıktılara göz attığımızda, negatif tam sayı koşulu sağlanınca `exit` komutu çalışıp 111 değerini çıkış değeri olarak döndürerek betiğin çalıştığı kabuğun kapatılmasını sağladığını teyit edebiliyoruz. 

Çıkış kodları sayesinde çeşitli koşul durumlarının tanımlanması ve işlemlerin çalışma durumları hakkında bilgi alınması mümkün oluyor.

Çıkış kodlarını bizler tanımlayabiliyoruz ancak yine de sistemimizde önceden tanımlı çıkış kodları da bulunuyor. Her ne kadar tüm sistemlerdeki çıkış kodları aynı olmasa da POSIX kapsamında pek çok ortak çıkış kodu mevcuttur. Örneğin Linux sistemindeki standartları görmek için çekirdeğin kaynak dosyalarında bulunan [errno.ho](https://github.com/torvalds/linux/blob/master/include/uapi/asm-generic/errno.h) dosyasına göz atabilirsiniz.