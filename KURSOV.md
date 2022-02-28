# **КУРСОВАЯ РАБОТА**

## **Иванова Ивана Сергеевича**

------

1. Создайте виртуальную машину Linux

   Сделано – Ubuntu через VirtualBox

![1](C:\Users\KING\Desktop\Images\1.png)

------



2) Установите **ufw** и разрешите к этой машине сессии на **порты 22 и 443**, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.

![2](C:\Users\KING\Desktop\Images\2.png)

![3](C:\Users\KING\Desktop\Images\3.png)

![4](C:\Users\KING\Desktop\Images\4.png)

------



3) Установите **hashicorp vault**

![5](C:\Users\KING\Desktop\Images\5.png)

![6](C:\Users\KING\Desktop\Images\6.png)

------



4) Создайте центр сертификации по инструкции , и выпустите сертификат для использования его в настройке веб-сервера **nginx** (срок жизни сертификата - месяц)

![7](C:\Users\KING\Desktop\Images\7.png)

![8](C:\Users\KING\Desktop\Images\8.png)

![9](C:\Users\KING\Desktop\Images\9.png)

![10](C:\Users\KING\Desktop\Images\10.png)

------



5) Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе

   ![11](C:\Users\KING\Desktop\Images\11.png)

   ------

   

6) Установите **nginx**.

   ![12](C:\Users\KING\Desktop\Images\12.png)

![13](C:\Users\KING\Desktop\Images\13.png)

![14](C:\Users\KING\Desktop\Images\14.png)

![15](C:\Users\KING\Desktop\Images\15.png)

------

7) По инструкции настройте **nginx** на **https**, используя ранее подготовленный сертификат

![16](C:\Users\KING\Desktop\Images\16.png)

![17](C:\Users\KING\Desktop\Images\17.png)

***Вот тут у меня случился казус :***

***Вот два примера для наглядности ошибки***

![18](C:\Users\KING\Desktop\Images\18.png)

![19](C:\Users\KING\Desktop\Images\19.png)

Если он не считывает сертификат по https, будет ли он работать правильно?

------

8) Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер **nginx**

Ну и соответственно тут эти две проблемы и выходят на поверхность

![20](C:\Users\KING\Desktop\Images\20.png)

![21](C:\Users\KING\Desktop\Images\21.png)
