---
layout: tutorial
title:  "Ağ Protokolleri"
modified: 2023-05-20
author: Taylan Özgür Bildik
coursetitle: "Temel Ağ Eğitimi"
excerpt: "Sık kullanılan bazı ağ protokollerini ele alıyoruz."
tags: [hub, bridge, switch, router,]
categories: [temel-network]
tutorial: 7
cover: protokollercover.png
toc: true 
---



Eğer protokol isimleri sebebiyle doğrudan bu sayfayı okumaya başladıysanız, buradaki açıklamaların ağ temellerini ele alan eğitimin bir parçası olduğunu belirtmek isterim. Eğer ağ temellerini öğrenme gayreti içerisindeyseniz bu eğitim serisine baştan sona göz atabilirsiniz.

Söz konusu, verilerin ağ üzerinden iletilmesi olduğunda çeşitli amaçlara hizmet edebilmesi için geliştirilmiş olan özel protokolleri kullanıyoruz. Protokol adı altında belirlenmiş olan kuralar sayesinde karşılıklı olarak aynı protokolleri kullanan tüm yapıların birbiri ile veri alışverişinde bulunması da mümkün oluyor. Biz bu bölümde teknik detaylara girmeden, eğitim içerisinde de yeri geldikçe atıfta bulunduğumuz bazı sık kullanılan protokollerin en genel işlevlerini çok kısaca ele alacağız. 

# ARP - Address Resolution Protocol

ARP protokolü IP adresleri üzerinden MAC adresinin öğrenilmesini mümkün kılan bir protokoldür. Yalnızca IP adresinin bilindiği durumda; hedef IP adresine, kendi MAC adresimiz ve IP adresimizi de barındıran bir MAC sorgusu göndeririz. 

![ARP-step1.png]({{ site.url }}/egitim/temel-network/protokoller/ARP-step1.png){:class="responsive img-zoomable"}

Hedef bu paketi aldığında gönderen host’un IP ve MAC bilgisini kendi ARP tablosuna yazar. Bu sayede daha sonra bu IP adresi ile haberleşmek istediğinde bu IP-MAC eşleşmesini tekrar kullanabilir. Nitekim ARP sorgusuna yanıt olarak da bu bilgileri kullanarak kaynağa kendi IP ve MAC adresini gönderir.

![ARP-step2.png]({{ site.url }}/egitim/temel-network/protokoller/ARP-step2.png){:class="responsive img-zoomable"}

Kaynak aldığı ARP yanıtına bakarak IP ve MAC adresini kendi ARP tablosuna kaydeder.

![ARP-step3.png]({{ site.url }}/egitim/temel-network/protokoller/ARP-step3.png){:class="responsive img-zoomable"}

Bu sayede gördüğünüz gibi karşılıklı olarak iletişim için gereken IP-MAC bilgilerin alınmış olur. İşte ARP protokolünün en temel çalışma yapısı bu şekildedir. 

# FTP - File Transfer Protocol

Uygun ağ bağlantısı bulunan taraflar birbiri ile dosya paylaşmak üzere FTP protokolünü kullanabiliyor. Zaten isim kısaltması da Türkçe olarak “Dosya Transfer Protokolü”’dür.

Buradaki örneğimizde istemci durumundaki bilgisayarımız, FTP sunucusuna spesifik bir dosyayı istediğini belirtiyor. FTP sunucusu da yanıt olarak ilgili dosyayı istemciye iletiyor.

![FTP.png]({{ site.url }}/egitim/temel-network/protokoller/FTP.png){:class="responsive img-zoomable"}

FTP sayesinde karşılıklı olarak dosya transferi mümkün. Yani buradaki örneğimizde esasen “client-istemci” durumundaki bilgisayarımız da dilerse FTP sunucusuna dosya yükleyebilir. Yani FTP sunucusuna dosya gönderilmesi mümkündür. 

# SMTP - Simple Mail Transfer Protocol

SMTP, e-posta iletiminde kullanılan bir transfer protokolüdür. Kullanım alanını açıklamak için örnek olarak, **ali@gmail.com** adresinden **can@outlook.com** adresine bir e-posta gönderileceğini düşünelim. Bu durumda Ali'nin e-posta istemcisi, e-posta iletişimini gönderme isteği olarak Ali'nin e-posta sunucusuna (Gmail SMTP sunucusu) iletecektir. 

![SMTP-to-gmail.png]({{ site.url }}/egitim/temel-network/protokoller/SMTP-to-gmail.png){:class="responsive img-zoomable"}

Gmail SMTP sunucusu da, iletiyi alıcının e-posta sunucusuna SMTP üzerinden iletilir. 

![gmail-to-outlook.png]({{ site.url }}/egitim/temel-network/protokoller/gmail-to-outlook.png){:class="responsive img-zoomable"}

Alıcının e-posta sunucusu (Outlook SMTP sunucusu), iletiyi alıcı olan Can'ın hesabına teslim alır. Eğer Can e-postayı okumak istiyorsa, e-posta istemcisi (örneğin, Outlook veya başka bir istemci) POP3 veya IMAP gibi protokoller aracılığıyla e-postayı sunucudan alır. 

![POP3-IMAP.png]({{ site.url }}/egitim/temel-network/protokoller/POP3-IMAP.png){:class="responsive img-zoomable"}

Sonuç olarak, e-posta iletimi için SMTP kullanılırken, e-postaların alınması ve yönetimi için POP3 veya IMAP gibi protokoller kullanılır.

![SMTP-POP3-IMAP.png]({{ site.url }}/egitim/temel-network/protokoller/SMTP-POP3-IMAP.png){:class="responsive img-zoomable"}

POP3 protokolü kullanıldığında, sunucudaki mesajlar istemci tarafından alındıktan sonra genellikle sunucudan bu mesajlar silinir. Yani artık bu mesaj istemcide tutulur. 

IMAP protokolü kullanıldığında ise, sunucu ile senkronizasyon sağlanarak her defasında bu mesajın sunucundan talep edilmesi sağlanır. Dolayısıyla mesaj içeriği istemcide değil, sunucuda barındırılır.

Bu protokollerin detayları temel ağ eğitiminin kapsamı dışında, ancak merak ediyorsanız çok kısaca araştırabilirsiniz.

# HTTP - Hyper Text Transfer Protocol

HTTP, esasen bilgisayarlar arasında metin, resim ve video gibi çeşitli verileri iletmek için kullanılan bir protokoldür. Genellikle web tarayıcılarının web sunucularıyla iletişiminde kullanılıyor. Örneğin Chrome gibi bir web tarayıcısını kullanarak bir web sayfasını görüntülemek istediğimizde, bu web sayfasının html dosyasını barındıran web sunucusuna bu sayfayı istediğimizi belirtiriz. 

![HTTP.png]({{ site.url }}/egitim/temel-network/protokoller/HTTP.png){:class="responsive img-zoomable"}

Bu sunucu da olumlu görürse bu html sayfasını bize yanıt olarak iletir. 

![HTTP-response.png]({{ site.url }}/egitim/temel-network/protokoller/HTTP-response.png){:class="responsive img-zoomable"}

Bu sayede web sayfasının içeriğini kendi web tarayıcımızda görüntüleyebiliriz. 

![HTTP-Webpage.png]({{ site.url }}/egitim/temel-network/protokoller/HTTP-Webpage.png){:class="responsive img-zoomable"}

Benzer yaklaşım diğer çeşitli veri türlerinin iletimi için de aynen geçerli. Neticede web sayfalarının tüm içeriklerinin bize ulaşmasını sağlayan bu protokoldür. 

# SSL - TLS

Client ve server arasında şifreli veri iletimini mümkün kılan protokollerdir. Örneğin HTTP protokolü normalde tüm verileri okunabilir şekilde ağ üzerinde iletir. Bu durumda ağın herhangi bir noktasındaki gözlemci bu iletinin içeriğini okuyabilir. 

![HTTP-security.png]({{ site.url }}/egitim/temel-network/protokoller/HTTP-security.png){:class="responsive img-zoomable"}

Fakat bu iletiyi **SSL** veya **TLS** ile şifrelediğimizde HTTP protokolü **HTTPS** halini alır ve mesaj içeriği gözlemciler tarafından okunamaz.

![HTTPS.png]({{ site.url }}/egitim/temel-network/protokoller/HTTPS.png){:class="responsive img-zoomable"}

Yalnızca uygun anahtarı bulunan alıcı bu mesajı okuyabilir. 

![HTTPS-key.png]({{ site.url }}/egitim/temel-network/protokoller/HTTPS-key.png){:class="responsive img-zoomable"}

![HTTPS-read.png]({{ site.url }}/egitim/temel-network/protokoller/HTTPS-read.png){:class="responsive img-zoomable"}

Benzer şekilde sunucu da yanıtını yine HTTPS üzerinden şifreli şekilde iletilir. 

![HTTPS-response.png]({{ site.url }}/egitim/temel-network/protokoller/HTTPS-response.png){:class="responsive img-zoomable"}

Bu sayede veri alışverişi karşılıklı olarak şifreli şekilde gerçekleştirilmiş olur. Bu yaklaşımda taraflar harici hiç kimse bu iletilen verileri okuyamaz. Yani gördüğünüz gibi TLS şifrelemesi protokole güvenlik katmak için kullanılabiliyor. 

Ben örnek olması için HTTP protokolü ele aldım ancak diğer pek çok protokolün güvenliği için de SSL-TLS şifrelemesinden faydalanılıyor. Örneğin FTP protokolünde dosya alışverişini şifreli şekilde gerçekleştirmek üzere **TLS** şifrelemesi gerçekleştirilebiliyor ve bu protokole de **FTPS**(FTP Secure) deniyor.

Ayrıca açıklamalar sırasında SSL-TLS şeklinde ifade ettim ancak günümüzde daha gelişmiş ve güvenli versiyon olduğu için TLS kullanıyor. Örneğin bir web sayfasını ziyaret ettiğinizde “bu web sayfası güvenli değil” gibi bir uyarı alıyorsanız, muhtemelen o sayfanın TLS sertifikası bulunmadığı veya artık geçersiz olduğu için şifreli iletişim kurulamadığından web tarayıcınız size uyarı veriyordur. 

![cert-date-invalid-error.jpg]({{ site.url }}/egitim/temel-network/protokoller/cert-date-invalid-error.jpg){:class="responsive img-zoomable"}

# SSH - Secure Shell | Telnet

SSH, güvenli bir şekilde uzak sunuculara erişim sağlamak için kullanılan bir ağ protokolüdür. SSH sayesinde fiziksel olarak uzakta bulunan bir sunucuda oturum açıp sunucuyu yönetmek üzere, bulunduğumuz ağ ile sunucu arasında güvenli bir iletişim kanalı oluşturabiliyoruz. 

![SSH.png]({{ site.url }}/egitim/temel-network/protokoller/SSH.png){:class="responsive img-zoomable"}

SSH ile sağlanan bağlantıda tüm trafik şifreli şekilde yalnızca ilgili tarafların okuyabileceği formda taşınır. Dolayısıyla SSH trafiği güvenlidir. Bu sayede herhangi bir sunucuya herhangi bir cihazdan güvenli şekilde bağlanıp, sunucuyu yönetebiliriz. Örneğin ben web sunucumu yönetmek için telefonumdan SSH bağlantısı yapıp sunucumda oturum açabilirim. Telefonum ve web sunucum internete bağlı olduğu sürece dünyanın herhangi bir yerinde, herhangi bir ağ üzerinden bu bağlantıyı güvenle kurabilirim. 

SSH sayesinde bağlantı kuran taraflar arasında her türlü veri transferi gerçekleştirilebiliyor. Örneğin FTP protokolü yerine dosyaları güvenli şekilde SSH bağlantısı ile aktarmamızı sağlayan SFTP isimli bir protokol vardır. Bu protokol FTP trafiğini SSH protokolü sayesinde şifreleyerek güvenli dosya transferini mümkün kılar.

Esasen güvenli bağlantıya ihtiyaç duyulan pek çok alanda SSH protokolü kullanılıyor. Dolayısıyla pek çok farklı protokol ile birlikte kullanıldığına da şahit olabilirsiniz.

SSH, hem kullanıcı adı/parola kombinasyonları hem de anahtar tabanlı kimlik doğrulama gibi yöntemlerle istemci cihazların sunucuya güvenli bir şekilde kimlik doğrulamasını sağlıyor. Dolayısıyla doğru şekilde konfigüre edildiği sürece son derece güvenli bir kanaldır.

SSH haricinde, benzer görev için geliştirilmiş olan ama şifreleyerek güvenli taşıma kanalı sunmayan “**Telnet**” isimli daha eski bir protokol de mevcut. Fakat Telnet, SSH’ın sunduğu güvenlik çözümlerini sunmadığı için günümüzde Telnet yerine SSH kullanılmakta. 

# DNS - Domain Name System

Daha önce eğitim içerisinde kısaca izah ettiğimiz gibi, “server” yani “sunucu” olarak isimlendirdiğimiz cihazların aslında içerisinde gerekli hizmeti sunabilecek yazılımlar kurulu sıradan bilgisayarlar olduğunu biliyorsunuz. Örneğin HTTP isteklerine yanıt vermek için gereken yazılımları bir bilgisayara kurup bu bilgisayarı websitemizi sunması için internete açtığımızda, websitemizi ziyaret etmek isteyen istemciler bu bilgisayara HTTP isteği gönderiyor olacaklar. Bu durumda websitesinin dosyalarını isteyen taraf client iken, bu dosyaları HTTP vasıtası ile istemcilere ileten ise server yani sunucu olacaktır.

![client-server.png]({{ site.url }}/egitim/temel-network/protokoller/client-server.png){:class="responsive img-zoomable"}

Dolayısıyla aslında sunucular da IP adresine sahip olan birer host cihazlarıdır. Host cihazlarının birbiri ile iletişim kurmak için IP adreslerini kullandığını da biliyoruz. Bu sebeple **sunucular ile iletişim kurmak istediğimizde bu sunucuların IP adresini bilmek zorundayız**. 

Fakat IP adreslerini akılda tutması kolay değil. Örneğin **linuxdersleri.net** websitesine erişmek için **185.199.108.153** IP adresini akılda tutmak ve her defasında eksiksiz olarak yazmak oldukça zahmetli. Kaldı ki tüm internet yalnızca tek bir websitesinden ibaret olmadığı için tüm websitelerinin IP adreslerini hatırlamamız ve eksiksiz olarak yazmamız pek olası değil.

Zaten bizler de bu sebeple domain olarak geçen alan isimlerini kullanıyoruz. Örneğin linuxdersleri.net websitesini ziyaret etmek için yalnızca bu ismi tarayıcımıza yazıp onaylamamız yeterli oluyor. Bu domain ismi arka planda, IP adresine dönüştürülerek bizim doğru sunucu ile iletişim kurmamız da mümkün oluyor. 

Hostlar arasında iletişim kurmak için IP adreslerinin bilinmesi gerektiğinden, bir sunucu ile iletişim kurmak istediğimizde bu sunucun IP adresini bilmek zorundayız. İşte burada dönüşümü gerçekleştiren yapı da **DNS** olarak geçen protokoldür. 

IP ve domain bilgileri DNS server üzerinde tutuluyor. Biz de domain adresi üzerinden gerekli olan IP bilgisini almak için bu DNS sunucusuna başvuruyoruz. 

Eğer harici olarak bir konfigürasyon gerçekleştirmediyseniz bu DNS sunucusu sizin internet servis sağlayıcınızdır. Örneğin Google’ın DNS sunucusu olan 8.8.8.8 sunucusunu kullandığınızı varsayacak olursak sorgulama işlemi aşağıdaki gibi gerçekleşir.

![DNS.png]({{ site.url }}/egitim/temel-network/protokoller/DNS.png){:class="responsive img-zoomable"}

Yani DNS aslında internet dünyası için son derece önemli bir protokoldür. Örneğin internet servis sağlayıcınız sizin bazı sitelere erişmenize engel olmak isterse, kendi DNS sunucuları üzerinde bu domain adreslerinin karşılığı olan IP adreslerini geçersiz olarak tanımlayabilirler. Genellikle hostun kendi lokal ip adresi olan 127.0.0.1 adresi tanımlanır. Bu sayede gitmek istediğiniz domain’in IP adresi bulunamadığı için ilgili web sunucusu ile iletişim kuramazsınız. 

![DNS-block.png]({{ site.url }}/egitim/temel-network/protokoller/DNS-block.png){:class="responsive img-zoomable"}

Bu sebeple sıklıkla Google Cloudflare gibi DNS hizmeti sağlayan harici DNS sunucuları kullanılır.

Ayrıca, harici DNS sunucuları dışında kullanmakta olduğunuz cihazın işletim sistemi içerisinde de dahili DNS hizmeti bulunur. Bu sayede cihazdaki programların hangi sunuculara erişip hangilerine erişmeyeceğini cihaz bazında kısıtlamamız da mümkün oluyor. 

Windows Hosts Dosyası: ***C:\Windows\System32\drivers\etc/hosts***

Linux Hosts Dosyası: ***/etc/hosts***

Esasen DNS konusu çok daha fazla detayı barındırıyor olmasına karşın en temel amacı burada izah ettiğimiz gibidir. Daha fazlası için kısa bir ek araştırma yapabilirsiniz.

# DHCP - Dynamic Host Configuration Protocol

İnternet bağlantısı için her hostun 4 bilgiye ihtiyacı var. Bunlar:

- IP adresi
- Subnet Mask değeri
- Default Getway bilgisi
- DNS Server IP adresi

Şimdi sırasıyla neden bu 4 bilgiye ihtiyaç olduğunu kısaca izah edelim.

IP adresi hostların ağ üzerindeki kimliğidir. IP adresi olmadan hostların birbirinden ayırt edilmesi mümkün olmaz.

![IP.png]({{ site.url }}/egitim/temel-network/protokoller/IP.png){:class="responsive img-zoomable"}

Subnet mask değeri, hostun hangi ağda olduğunu ve ağın büyüklüğünün bilgisini verir. Bu sayede hangi IP adreslerinin lokal ağda, hangilerinin harici ağlarda olduğu bilinebilir.  

![Subnet-mask.png]({{ site.url }}/egitim/temel-network/protokoller/Subnet-mask.png){:class="responsive img-zoomable"}

Yani IP ve subnet mask değerine sahip olan tüm hostlar lokal ağda iletişim kurabilirler. Fakat bir host harici bir ağdaki hostla iletişim kurmak istiyorsa, verileri harici hosta yönlendirecek router cihazının ip adresini de bilmesi gerekiyor. Örneğin bizim internet ağına bağlanmamızı sağlayan evimizdeki router görevini gören “modem” cihazıdır. Biz modeme bağlanırız bu modem de bizi internete bağlar. Bizi dış ağa bağlayan router cihazı da “ağ geçidi” yani “getway” olarak ifade ediliyor. Zaten yukarıdaki görsele bakacak olursanız router cihazının bizi dış ağa bağlandığını kendiniz de görebilirsiniz. Bu sebeple bir hostun harici ağlar ile iletişim kurmak için, varsayılan ağ geçicinin(default getway) IP adresini de bilinmesi gerekiyor. 

![default-getway.png]({{ site.url }}/egitim/temel-network/protokoller/default-getway.png){:class="responsive img-zoomable"}

Bu bilgiler internet ağına bağlanıp IP adresleri üzerinden diğer hostlar ile iletişim kurmamızı sağlar. 

Eğer alan adı yani “domain” ismi üzerinden bir adresi ziyaret etmek istiyorsak bu noktada domain adresini IP adresine dönüştürecek olan DNS sunucusuna da ihtiyacımız var. Dolayısıyla bir hostun domain isimleri üzerinden webte gezinebilmesi için DNS sunucusunun ip adresini bilmesi gerekiyor. 

![DNS-network.png]({{ site.url }}/egitim/temel-network/protokoller/DNS-network.png){:class="responsive img-zoomable"}

İşte tüm bu sebeplerle bir hostun internet üzerinde gezinebilmek için “IP, Subnet Mask, Default Getway, DNS” bilgilerine sahip olması gerekiyor. Bu hostun ne tür bir cihaz olduğu önemsiz. Burada bahsi geçen host; laptop, telefon, yazıcı veya internete bağlanabilen herhangi bir cihaz olabilir. Hepsinin bu 4 bilgiye ihtiyacı var.

Fakat muhtemelen ben özellikle ele alana kadar internet gezintisi için bu 4 bilgiye ihtiyacınız olduğunun bile farkında değildiniz. Bu durumun sebebi bu bilgilerin **DHCP** isimli protokol tarafından hostlara otomatik olarak tanımlanıyor olmasıdır. 

DHCP sunucusu olarak görev yapan sunucu, ağa katılan tüm hostlara bu bilgileri uygun şekilde tanımlama görevindedir. Bir cihaz ağa yeni katıldığında, ağın DHCP sunucusuna keşif mesajı gönderir.

![DHCP-discover.png]({{ site.url }}/egitim/temel-network/protokoller/DHCP-discover.png){:class="responsive img-zoomable"}

DHCP sunucusu da yanıt olarak uygun olan bilgileri bu cihaza tanımlayarak ağa katılmasını sağlar.

![DHCP-offer.png]({{ site.url }}/egitim/temel-network/protokoller/DHCP-offer.png){:class="responsive img-zoomable"}

DHCP sayesinde gerekli olan temel bilgiler otomatik olarak atanıyor. DHCP görevini de, genellikle ev veya küçük işletme ağlarında modem ya da router cihazı üstleniyor. 

Böylelikle sık kullanılan temel birkaç protokolden çok kısaca bahsetmiş olduk. Elbette her bir protokolün çok daha fazla detayı bulunuyor olmasına karşın ağın çalışma yapısını temel düzeyde anlamak için gereken bilgiye artık sahip olduğumuzu düşünüyorum. Eğer yalnızca bu yazıyı okuduysanız belki anlatımlar sizin için yeterince anlaşılır gelmemiş olabilir. Bu durumun nedeni tüm eğitimin ağ temellerini açıklamak üzere sırasıyla bölüm bölüm ele alınması. Bu bölümde anlatıları ve ağ temellerini daha iyi anlamak için tüm eğitim serisine baştan sona göz atmanızı tavsiye edebilirim.