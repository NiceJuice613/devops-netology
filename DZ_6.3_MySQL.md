
# Домашнее задание к занятию "6.3. MySQL"

## Задача 1. 
- Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

`docker pull mysql:8.0`
`docker volume create vol_mysql`
`docker run --rm --name mysql-docker \
    -e MYSQL_DATABASE=test_db \
    -e MYSQL_ROOT_PASSWORD=1234 \
    -v $PWD/backup:/media/mysql/backup \
    -v my_data:/var/lib/mysql \
    -v $PWD/config/conf.d:/etc/mysql/conf.d \
    -p 3306:3306 \
    -d mysql:8.0`

- Изучите бэкап БД и восстановитесь из него.
- Перейдите в управляющую консоль mysql внутри контейнера.

![6.3_Screen_1](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_1.jpg)

- Используя команду \h получите список управляющих команд.
- Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_2.jpg)

- Подключитесь к восстановленной БД и получите список таблиц из этой БД.
- Приведите в ответе количество записей с price > 300.

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_3.jpg)

## Задача 2

- Создайте пользователя test в БД c паролем test-pass, используя:

    - плагин авторизации mysql_native_password
        
    срок истечения пароля - 180 дней
    
    количество попыток авторизации - 3
        
        максимальное количество запросов в час - 100

        аттрибуты пользователя:
        
        Фамилия "Pretty" Имя "James"
        
        
        
        - Предоставьте привилегии пользователю test на операции SELECT базы test_db.

- Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_4.jpg)

## Задача 3

- Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.

- Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_5.jpg)

- Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

    на MyISAM
    на InnoDB

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_6.jpg)

## Задача 4

- Изучите файл my.cnf в директории /etc/mysql.
- Измените его согласно ТЗ (движок InnoDB):
      Скорость IO важнее сохранности данных
      Нужна компрессия таблиц для экономии места на диске
      Размер буфера с незакомиченными транзакциями 1 Мб
      Буфер кеширования 30% от ОЗУ
      Размер файла логов операций 100 Мб

- Приведите в ответе измененный файл my.cnf.

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_7.jpg)