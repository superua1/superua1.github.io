---
layout: post
title: "<code>nokta</code> ve <code>source</code> Komutları"
excerpt: "<code>nokta</code> ve <code>source</code> bash yerleşik komutlarını ele alacağız."
categories: articles
tags: [nokta, source, bash builtin]
author: billy_rick
comments: true
share: true
modified: 2021-08-01T14:18:57-04:00
image:
  feature: so-simple-sample-image-7.jpg
  credit: WeGraphics
  creditlink: http://wegraphics.net/downloads/free-ultimate-blurred-background-pack/
---

# . (nokta) & source Komutu

Bash yerleşik(builtin) komutlarından olan nokta (`.`) aracı aslında `source` komutu ile aynı görevi üsteleniyor yani nokta yerine `source` komutunu da kullanabiliriz. Bu komutların ortak işlevi, argüman olarak verilmiş olan betik dosyasını mevcut kabuk üzerinde okuyup çalıştırmaktır. Bu sayede çalışmakta olduğumuz mevcut kabuk üzerinden betik dosyası içerisinde tanımlanmış olan değişken ve fonksiyon gibi yapılara ulaşabiliriz. Normal şartlarda betik dosyasını çalıştırdığımızda, betik dosyası yeni bir alt kabuk oluşturulup bu kabuk üzerinde çalıştırılır ve işi bittiğinde oluşturulmuş olan alt kabukla birlikte sonlandırılır.  İşte bizler de betik dosyasının ürettiği verilere mevcut kabuğumuz üzerinden de ulaşabilmek için `source` ya da nokta (`.`) komutunu kullanıyoruz. Daha iyi anlamak adına basit bir betik dosyası oluşturalım ve bu dosyanın içerisine de `linux="çekirdek"` şeklinde basit bir değişken tanımlayıp, bu değişkenin betik dosyası çalıştırıldığında komut satırına basılması için `echo $linux` şeklinde komutumuzu da ekleyelim.

```bash
#!/usr/bin/env bash

linux="çekirdek"
echo $linux
```

Eğer biz betik dosyamızı standart şekilde çalıştırırsak arkaplanda bu betik dosyası için yeni bir alt kabuk oluşturulacak ve komut satırına "**çekirdek**" ifadesi basılıp, betik dosyası oluşturulmuş olan alt kabukla birlikte sonlandırılacak. Bu durumda biz mevcut kabuğumuz üzerinden tekrar `echo $linux` komutu ile betik dosyası içerisinde tanımlamış olduğumuz değişkeni çağırmaya çalıştığımızda herhangi bir çıktı alamayacağız. Çünkü bu betik dosyası mevcut kabuğumuz üzerinde değil bir alt kabuk üzerinde çalıştırılıp işi bitince sonlandırıldı. İşte bizler betik dosyasını alt kabuk oluşturulmadan, mevcut kabuk üzerinde çalıştırmak için nokta ya da `source` komutunu kullanıyoruz. Bu sayede betik dosyasının sahip olduğu değişken ve fonksiyon değerleri gibi verilere mevcut kabuğumuz üzerinden de ulaşabiliyor oluruz. 

Kullanım amacına gerçek ve sık kullanılan bir örnek vermemiz gerekirse; örneğin bash kabuğunun konfigürasyon dosyası olan ve ev dizininizde (*/home/kullanıcı-adınız*) bulunan "***.bashrc***" isimli dosya da aslında bir betik dosyasıdır. 

Bu dosya biz her oturum açtığımızda okunur ve bizim oturumumuzda kullanacağımız bash kabuklarının nasıl davranacağını belirler. Yani mevcut oturumumuz için bash kabuğu ayarlarındaki değişiklikleri bu dosyada tanımlarız. Denemek için örneğin dosyamızı açıp içerisine `isim='taylan'` şeklinde yeni değişken tanımlaması yaparsam, her oturum açılışında bu değişken de sistem tarafından okunacağı için mevcut hesabımdaki tüm kabuklar üzerinden bu değişkeni istediğim zaman çağırabiliyor olacağım. Ancak fark ettiyseniz bu dosya yalnızca ben oturum açtığım sırada okunuyor, yani değişikliğin geçerli olabilmesi için oturumu kapatıp tekrar açma zahmetine girmem gerekiyor. Fakat buna hiç gerek yok çünkü `source` ya da nokta komutu ile `source /home/taylan/.bashrc` ya da `. /home/taylan/.bashrc` şeklinde komut girerek, dosyanın sistem tarafından tekrar okunup tüm alt kabuklar üzerinde geçerli olmasını sağlayabiliriz. Bu durumu sizler de kendi sisteminiz üzerinde bizzat test edebilirsiniz. Aslında harici bir bash betiğinin mevcut kabuk üzerinde `source` komutu ile ulaşılabilir kılınması "kütüphane fonksiyonlarının içeri aktarılması" olarak geçiyor. Burada mevcut kabukta geçerli olması için içeri aktardığımız betik dosyasının bütünü bir kütüphane fonksiyonu olarak kabuk ediliyor. Fonksiyonlar bir kez tanımlandıklarında isimleri ile tekrar tekrar kullanılabileceği için benzer durum, içerisinde bash komutlarını içeren betik dosyasının mevcut kabuğa aktarılması için de geçerli oluyor. 

Bahsi geçen durumu bir alt başlıkta örneklendirmemiz gerekirse;

## Harici Betik Dosyalarının Mevcut Betik İçerisinde Kullanılması

Örneğin harici olarak yazmış olduğunuz bir betik dosyasının işlevlerini yeni betik dosyanızda da kullanmak istiyorsanız yalnızca ilgili betik dosyasını `source` komutu ya da `nokta` komutu ile içeri aktarılmasını sağlayabilirsiniz.

Basit ve anlaşılır bir özellik olması açısından ben **kontrol.sh** isimli bir betik dosyası oluşturuyorum. 

```bash
#! /usr/bin/env bash
root_kontrol () {
	if [[ $EUID -ne 0 ]]; then
		echo "Dosyayı root yetkisi ile açmadığınız için kapatılıyor.."
		exit 1
	fi
}

isim="taylan"
```

Oluşturmuş olduğum betik dosyası içerisinde bu dosyayı çalıştıran kişinin root kullanıcısı olup olmadığını sorgulayan bir fonksiyon ve ayrıca `isim="taylan"` şeklinde tanımlanmış bir değişken bulunuyor. Eğer ben bu dosyayı yeni oluşturmuş olduğum betik dosyası içerisinde `source kontrol.sh` komutu ile aktarırsam, **kontrol.sh** isimli dosyanın tüm içeriğine mevcut betik dosyam üzerinden ulaşabiliyor olacağım. Bu durumu teyit etmek için **kontrol.sh** dosyasında tanımlamış olduğum fonksiyonu çağırıyorum ve değişken değerinin de konsola basılması için komutumu giriyorum.

```bash
#! /usr/bin/env bash
source ./kontrol.sh
root_kontrol
echo $isim
```

Çalıştırma yetkisi verdikten sonra, betik dosyamızı root kullanıcısı olarak çalıştırdıysak "isim" değişkeninin değerini çıktı olarak alıyoruz. 

```bash
└─$ sudo ./betik.sh
taylan
```

Testi devam ettirmek için root yetkisi olmadan dosyayı çalıştırmayı denediğimizde **kontrol.sh** isimli dosyadaki root yetkimizi kontrol eden fonksiyon çalışarak root olmadığımız için betik dosyamızı sonlandırdığını belirtiyor. 

```bash
└─$ ./betik.sh
Dosyayı root yetkisi ile açmadığınız için kapatılıyor..
```

Böylelikle harici betik dosyalarının nasıl içeri aktarılabileceğini de test etmiş olduk. Burada bahsi geçen içeri aktarma işlemi aslında bash programlamada "kütüphane fonksiyonlarının içeri aktarılması" olarak da ifade edilir.

Nokta işaretinin biraz önce bahsettiğimiz özelliği dışında alternatif kullanım alanları da mevcut. 

## Çalışmakta Olduğumuz Mevcut Dizini Temsil Eder

Nokta işareti aslında mevcut bulunduğumuz dizin adresini de temsil ediyor. Test etmek için ***/home/taylan/Documents*** klasörü altındaki dosyamı `mv` komutu ile bulunduğum dizin olan masaüstü yani ***/home/taylan/Desktop*** konumuna taşımak üzere komutumu `mv /home/taylan/Documents/test.txt .` şeklinde giriyorum. Bu komut neticesinde bulunduğum konumu uzun uzadıya belirtmeme gerek kalmadan dosyamı taşımış oldum. Aynı komutu `mv /home/taylan/Documents/test.txt /home/taylan/Desktop/` şeklinde de girebilirdik. İki komutu kıyaslayıp nokta işaretinin ne kadar işlevsel olabildiğini görebiliriz. 

## Dosyaların Çalıştırılmasını Sağlar

Ayrıca sistem tarafından çalıştırılabilir olan herhangi bir dosyayı nokta ve taksim işareti(slash-eğik çizgi olarak da bilinir) kullanımı ile `./dosya-adı` şeklinde çalıştırabiliriz. Linux sistemlerinde dosyaların çalıştırılması için dosya uzantılarının önemi yoktur. Örneğin ben dosya içerisine python kodları ekleyip yalnızca "***script***" adıyla kaydedersem ve çalıştırılma yetkisi verirsem(`chmod +x script`) bu dosyayı `./script` komutu ile çalıştırmam mümkündür. Burada kullanmış olduğumuz nokta slash yapısı; dosyayı açıp içerisinde belirtilmiş olan, dosyanın ne tür bir ortamda çalışabileceğini bildiren satırı("**shebang**" olarak da bilinir) okuyup gerekli ortam üzerinden dosyanın çalıştırılmasını sağlıyor. Aynı dosyamızı sürümüne göre `python script` veya `python3 script` şeklinde de çalıştırabilirdik fakat, nokta slash(`./`) kullanımı dosyanın çalıştırılabileceği doğru ortamı otomatik olarak bulduğu için çok daha kullanışlıdır. Ben python üzerinden örnek verdim ancak sistem üzerinde çalıştırmak için müsait ortamı bulunan tüm dosyalar bu şekilde nokta komutu yardımıyla kolayca çalıştırılabilir. Aslında buradaki nokta, slash işareti ile birlikte çalıştırmak istediğimiz dosyayı hedef göstermemizi sağlıyor. Eğer nokta olmadan doğrudan dosya isimini konsola girersek, kabuğumuz girmiş olduğumuz ifadeyi PATH yolu üzerinde arayıp çalıştırılabilir bir dosya olup olmadığına bakar. Bizler nokta ve slash kullanımı ile kabuğumuza PATH yoluna bakma, doğrudan belirttiğim dosyayı çalıştır demiş oluyoruz aslında.

## Gizli Dosyaların Temsili

Daha önce ele aldıklarımıza ek olarak nokta komutu ile doğrudan ilişkili olmasa da, nokta sembolünün isimlerin önüne geldiğinde "**gizlilik**" niteliği kazandırdığına da bilmenizi isterim. Başında nokta yer alan dosya ve klasör isimleri sistem genelinde "**gizli**" olarak tanınmaktadır. Denemek için hem normal hem de başında nokta olan yani gizli olan dosya ve klasörler oluşturup listeleyelim.

```bash
taylan@taylan:~/Belgeler$ mkdir klasör
taylan@taylan:~/Belgeler$ mkdir .klasör
taylan@taylan:~/Belgeler$ touch dosya
taylan@taylan:~/Belgeler$ touch .dosya
taylan@taylan:~/Belgeler$ ls
dosya  klasör
taylan@taylan:~/Belgeler$ 
```

Görebildiğiniz gibi gizli dosya ve klasörler yalnızca `ls` komutunu kullandığımız durumda listelenmedi. Bu durumda `ls` komutunun gizli içerikleri gösteren `-A` seçeneğini kullanarak, tüm içerikleri listeleyebiliriz.

```bash
taylan@taylan:~/Belgeler$ ls -A
.dosya  dosya  .klasör  klasör
taylan@taylan:~/Belgeler$
```

Böylelikle dosya ya da klasör isimlerinin başında nokta olması halinde "gizlilik" sıfatını kazandığını da teyit etmiş olduk.

## `source` Komutu ile nokta "nokta `.`" Komutu Arasındaki Fark Nedir ?

Tek fark taşınabilirliktir. Nokta komutu POSIX standardında olan komuttur; `source` komutu ise, bash ve diğer bazı kabuklar tarafından(hepsi değil, bazı kabuklar) da kullanılabilir olan yerleşik komuttur. Yine de sonuç olarak bash kabuğu için nokta ya da `source` komutu aynı işi görürler. Kullanım tercihi noktasında taşınabilir bir betik dosyası istiyorsanız POSIX standartlarını gözeterek nokta komutunu seçebilirsiniz. Eğer yazdığınız betik dosyası yalnızca bash kabuğunda çalışacak ise, yazdığınız kodların daha okunaklı olması için `source` komutunu tercih edebilirsiniz.

BURADAKİ AÇIKLAMALARDAN EMİN OL BAĞLAMI İYİ AÇIKLA

Betik standart şekilde çalıştırıldığına yeni bir alt kabukta çalıştırıldığını biliyoruz. Eğer mevcut kabukta ilgili betik çalıştırılsın ve değinkenler, fonksiyonlar gibi yapılar mevcut kabuk üzerinde de geçerli olsun istersek; yerleşik komut olan source ya da nokta komutlarını kullanabiliyoruz. Bu sayede betik dosyası mevcut kabuk üzerinde çalıştırılıp, betiğin içinde yer alan değişken ve fonksiyon gibi yapılar mevcut kabuk üzerinden de ulaşılabilir olur.

**Doğrudan** çalıştırmak yeni bir kabuk üzerinden çalışmasını sağlar, ana kabukta hiç bir değişiklik meydana gelmez yalnızca çıkış durumu iletilir.

**Source** ya da nokta ile çalıştırmak betiğin mevcut kabuk üzerinde çalıştırılması dolayısı ile tüm değişiklerin kabuk üzerinde geçerli olmasını sağlar.

**Exec** ile betik dosyasını çalıştırmak mevcut ana kabuğu öldürerek betiğin bu kabuğun yerinde çalıştırılmasını sağlar. Betiğe ana kabuktaki değerleri aktarmak için ve ana kabuğun son işlemini gerçekleştirmek için kullanılır. Bu yöntemle betik dosyası ana kabuğun değişken ve fonksiyon gibi bilgilerine sahip olurken, tüm işlemler bittiğinde tüm kabuklar da kapatılarak yok olur.
