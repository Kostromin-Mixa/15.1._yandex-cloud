# 15.1. Организация сети    
1. Зарегистрировал учетную запись в yandex-cloud "Neto-mixa"    
2. Создал конфиг вайл main.tf с описанием инстанс [main.tf](https://github.com/Kostromin-Mixa/15.1._yandex-cloud/blob/main/main.tf)   
![2021-12-24_10-39-30](https://user-images.githubusercontent.com/78191008/147321089-427d98c6-087a-40a3-bd9d-98d3d859f734.png)   

3. Пробросил ssh ключи для доступа из VM1 в VM2    
4. Привязал созданную таблицу маршрутизации к подсети private  
5. Подключился к VM1 ip-51.250.12.174, далее из VM1 подключился к VM2 ip-192.168.20.18 и сделал ping ya.ru    
 ![2021-12-24_10-16-58](https://user-images.githubusercontent.com/78191008/147320647-be79600d-6da7-4e32-8413-4eff538bc481.png)   
6. Проверка выхода в интернет из VM2 с подсетью private успешна.
