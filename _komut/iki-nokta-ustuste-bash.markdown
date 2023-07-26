---
layout: komut
author: Ahmet
title: ": (iki nokta üst üste) Komutu"
modified: 2021-04-14
excerpt: "Bash kabuğunda yerleşik olarak bulunan iki nokta üst üste komutunun açıklamasıdır."
tags: [bash, bash builtin, yerleşik bash komutları]
categories: komutlar 
iliskili: [break,]
toc: true
---

İki nokta üst üste işareti, özel karakterler sınıfında yer alan ve özetle "**hiç bir şey yapma**" anlamına gelen yapıdır. Genel kullanım amacına bakıldığında tıpkı `true` komutu gibi "**doğru**" değeri döndürmek amacıyla kullanıldığını görebiliriz. Test etmek için yalnızca iki nokta üst üste karakterini komut satırımıza girelim ve hemen ardından çıkış değerini kontrol etmek için `echo $?` komutunu kullanalım. Ve benzerliği görmek adına `true` komutunu girip bu komutun da çıkış değerini görelim.

```bash
:
echo $?
0
true
echo $?
0
```

Görebildiğiniz gibi iki nokta üst üste karakteri de tıpkı `true` komutu gibi çıkış kodu olarak "**0**" yani "**komut hatasız çalıştı**" değerini veriyor.

Örneğin bu yapı sayesinde aşağıdakine benzer şekilde sonsuz döngü oluşturulabilir. Çünkü döngüyü sağlayan iki nokta üst üste işareti her daim olumlu sonuç döndürecektir.

```bash
while :
do
   echo "döngü devam ediyor..."
done
```

Aynı işlemi `true` komutu ile de kurabiliriz.

```bash
while true
do
   echo "döngü devam ediyor..."
done
```

Benzer şekilde if/then yapısında koşul durumunu atlamak için boş değer döndürücü şekilde de kullanabiliriz.

```bash
if kosul-durumu
then :   # Hiç bir şey yapma sadece devam et:)
else     
   echo "İlk koşul boş geçildiği için bu satır bastırıldı.."
fi
```

Pas geçme özelliğinin dışında ayrıca, değişken değeri atanmamış olan değişkenlere yeni değerler atanması için kullanılabilir. Basit bir örnek olması açısından daha önce tanımlanmamış olan yeni isimli bir değişkene iki nokta üst üste yapısı ile değer atamaya çalışalım. 

Örneğin `: ${sistem="linux"}` kullanımında eğer `sistem` değişkenine daha önce bir değer atanmadıysa belirtmiş olduğum "**linux**" değeri atanır. Ancak daha önce değer ataması yapıldıysa değişmeden kalır. 

```bash
$ : ${sistem="linux"}
$ echo $sistem
linux
$ : ${sistem="gnu-linux"}
$ echo $sistem
linux
$ 
```

Özellikle değişken değerlerinin yeniden tanımlanırken eski değerlerini yok ettiğini bildiğimiz için, bu kullanım eğer varsa eski değerin korunmasını istediğimiz durumlarda başvurabileceğimiz yapıdır.

## <span class="mavi">Bonus</span>
## <span class="yesil">Bonus</span>
## <span class="kirmizi">Bonus</span>
## <span class="sari">Bonus</span>
## <span class="turuncu">Bonus</span>
## <span class="pembe">Bonus</span>
Kullanım alanı pek yaygın ve önerilmiyor olsa da karşılaşmanız halinde yadırgamamak adına iki farklı özelliğinden de kısaca bahsedelim. 

### İçeriği Silme

İki nokta üst üste işareti "pas geçmek" amacıyla kullanıldığı için dosyaların içerisinde yer alan tüm verilerin silinmesi için `: > hedef-dosya` şeklinde bir kullanım alternatifi de vardır. Bu kullanım hedef dosya içerisindeki tüm verileri siler fakat, aslında bu işlem iki nokta üst üste işareti olmadan da aynen yapılabilir. Yani komutumuzu yalnızca `> hedef-dosya` şeklinde girerek de dosya içeriğinin silinmesini sağlayabiliriz. Burada iki nokta üst üste karakterinin kullanılmasının nedeni genellikle betik dosyasını okuyacak kişilerin bu işlemi daha net fark edebilmesi sağlamaktır. Yani iki nokta işaretinin "pas geçme" anlamında olduğunu bilen kişiler dosya içeriğinin boşaltılacağını daha rahat anlayabilir. Fakat dediğim gibi genelde pek sık karşılaşmazsınız ve çok da önerilen bir kullanım sayılmaz.

**Not:** Özellikle harici olarak temin ettiğiniz betik dosyalarının içerisinde art niyetli olarak bu ifadenin dosyaları silmek amacıyla kullanıldığına şahit olabilirsiniz. Genellikle doğrudan silme ifadesi yer almadığından ve kullanımı yaygın olmadığı için gözlerden kaçabiliyor. Bu gibi tuzaklara karşı mutlaka çalıştırmadan önce betik dosyası içeriğini kontrol edin. Açık kaynaklı projeler harikadır ama herkesin bu imkanı iyiye kullandığını söyleyemeyiz. Açık kaynak olması her daim güvenilir olduğu anlamına gelmez.

### Yorum Satırı

Harici olarak kesinlikle önerilmeyen yine de rast gelmenizin olası olduğu diğer kullanımı ise yorum satırı belirtmek için kullanılmasıdır. Normal şartlarda bash kabuğu için `#` işaretinden sonra yazılmış tüm karakterler yorum satırı olarak kabuk edilir yani yorum satırı eklemek için doğru kullanım budur. Ancak yine de kimileri iki nokta üst üste karakterinden sonrasını yorum satırı olarak kullanabiliyorlar. Bu kullanım çok yanlış çünkü yorum satırı içerisindeki özel karakter veya komutların, kabuk tarafından farklı şekilde algılanıp yorumlanması ve özellikle hata ayıklama noktasında oldukça fazla sorun çıkarması olasıdır. Yani yorum satırı için kullanımını kesinlikle önermemekle birlikte, gördüğünüzde şaşırmamanız için bu kullanım şeklinin aklınızda bulunmasında fayda var.