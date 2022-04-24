
# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1. 
- Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

`docker pull postgres:13`
`docker volume create vol_postgres`
`docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol_postgres:/var/lib/postgresql/data postgres:13`

- Найдите и приведите управляющие команды для:

  - вывода списка БД

    ```
    \l[+]   [PATTERN]      list databases
    ```

  - подключения к БД

    ```
    \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                             connect to new database (currently "postgres")
    ```

  - вывода списка таблиц

    ```
     \dt[S+] [PATTERN]      list tables
    ```

  - вывода списка содержимого таблиц

    ```
    \d[S+]  NAME           describe table, view, sequence, or index
    ```

  - выхода из psql

    ```
     \q                     quit psql
    ```



## Задача 2

- Используя `psql` создайте БД `test_database`.

```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE    
```

- Восстановите бэкап БД в `test_database`.

```
sudo docker cp test_dump.sql pg-docker:/tmp
```

- Перейдите в управляющую консоль `mysql` внутри контейнера.

```
psql -U postgres
```

- Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

  ![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_6.jpg)

- Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

  ![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_6.jpg)

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

![6.3_Screen_2](C:\Users\KING\Desktop\6.3_Screen\6.3_Screen_6.jpg)

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

При изначальном проектировании таблиц можно было сделать ее  секционированной, тогда не пришлось бы переименовывать исходную таблицу и переносить данные в новую.

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```
export PGPASSWORD=netology && pg_dump -h localhost -U postgres test_database > /tmp/test_database_backup.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

Например, добавить свойство UNIQUE

```
title character varying(80) NOT NULL UNIQUE,
```