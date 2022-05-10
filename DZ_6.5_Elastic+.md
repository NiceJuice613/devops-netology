
# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1. 
Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и [документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.

В ответе приведите:

- текст Dockerfile манифеста

  ```
  FROM centos:7
  
  EXPOSE 9200 9300
  
  USER 0
  
  RUN export ES_HOME="/var/lib/elasticsearch" && \
      yum -y install wget && \
      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz && \
      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
      sha512sum -c elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
      tar -xzf elasticsearch-7.17.0-linux-x86_64.tar.gz && \
      rm -f elasticsearch-7.17.0-linux-x86_64.tar.gz* && \
      mv elasticsearch-7.17.0 ${ES_HOME} && \
      useradd -m -u 1000 elasticsearch && \
      chown elasticsearch:elasticsearch -R ${ES_HOME} && \
      yum -y remove wget && \
      yum clean all
  
  COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
      
  USER 1000
  
  ENV ES_HOME="/var/lib/elasticsearch" \
      ES_PATH_CONF="/var/lib/elasticsearch/config"
  WORKDIR ${ES_HOME}
  
  CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch"]
  ```

- ссылку на образ в репозитории dockerhub

  https://hub.docker.com/repository/docker/nicejuice613/devops-elasticsearch

- ответ `elasticsearch` на запрос пути `/` в json виде

  ```
  {
    "name" : "netology_test",
    "cluster_name" : "elasticsearch",
    "cluster_uuid" : "71b705201b4f8eff1a9952",
    "version" : {
      "number" : "7.17.0",
      "build_flavor" : "default",
      "build_type" : "tar",
      "build_hash" : "c7326b4c3133d4ca537f767038a9af733689ef8e",
      "build_date" : "2022-05-07T23:42:14.774273938Z",
      "build_snapshot" : false,
      "lucene_version" : "8.10.1",
      "minimum_wire_compatibility_version" : "6.8.0",
      "minimum_index_compatibility_version" : "6.0.0-beta1"
    },
    "tagline" : "You Know, for Search"
  }
  ```

## Задача 2

Добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя   | Количество реплик | Количество шард |
| ----- | ----------------- | --------------- |
| ind-1 | 0                 | 1               |
| ind-2 | 1                 | 2               |
| ind-3 | 2                 | 4               |

```
$ curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
```

```
$ curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 2,
    "number_of_replicas": 1
  }
}
'
```

```
$ curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 4,
    "number_of_replicas": 2
  }
}
'
```

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

```
$ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases 0g-YOykl7ESEa_ucwU3qlQ   1   0         41            0     68.3mb         68.3mb
green  open   ind-1            4pAUrY284E2qQ2S8Rrrcmw   1   0          0            0       226b           226b
yellow open   ind-3            mQ-LzoMaSWCDAuwnzFS1Eg   4   2          0            0       604b           604b
yellow open   ind-2            xpMnEwDhqk2yz4INzKkXYw   2   1    
```

Получите состояние кластера `elasticsearch`, используя API

```
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 10,
  "active_shards" : 10,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}
```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Индексы в статусе Yellow потому что у них указано число реплик, а по  факту нет других серверов, соответсвено реплицировать некуда.

Удалите все индексы.

```
curl -X DELETE 'http://localhost:9200/_all'
```

## Задача 3

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

```
$ docker exec -u root -it elastic bash
[root@96e6df0c34c3 elasticsearch]# mkdir $ES_HOME/snapshots
```

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) данную директорию как `snapshot repository` c именем `netology_backup`.

```
# echo path.repo: [ "/var/lib/elasticsearch/snapshots" ] >> "$ES_HOME/config/elasticsearch.yml"
# chown elasticsearch:elasticsearch /var/lib/elasticsearch/snapshots
$ docker restart elastic
$ curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/var/lib/elasticsearch/snapshots",
    "compress": true
  }
}'
{"acknowledged":true}
```

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

```
$ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
$ $ curl 'localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases 0g-YOykl7ESEa_ucwU3qlQ   1   0         41            0     68.3mb         68.3mb
green  open   test             fn1-HWUHEk6sku61mqtuaw   1   0          0            0       226b           226b
```

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) состояния кластера `elasticsearch`.

```
curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_1?wait_for_completion=true&pretty"
```

**Приведите в ответе** список файлов в директории со `snapshot`ами.

```
$ docker exec -it elastic ls -l /var/lib/elasticsearch/snapshots/
total 28
-rw-r--r-- 1 elasticsearch elasticsearch 1422 May 20 11:38 index-0
-rw-r--r-- 1 elasticsearch elasticsearch    8 May 20 11:38 index.latest
drwxr-xr-x 6 elasticsearch elasticsearch 4096 May 20 11:38 indices
-rw-r--r-- 1 elasticsearch elasticsearch 9688 May 20 11:38 meta-
fr7D0jK2Ja0mP_BRY0cr2g.dat
-rw-r--r-- 1 elasticsearch elasticsearch  452 may 20 11:18 snap-
fr7D0jK2Ja0mP_BRY0cr2g.dat
```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```
$ curl -X DELETE "localhost:9200/test?pretty"
$ curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
$ curl 'localhost:9200/_cat/indices?pretty'
green open .geoip_databases 0g-YOykl7ESEa_ucwU3qlQ 1 0 41 0 38.6mb 38.6mb
green open test-2           jFi75yWgqk6HVoxwOp85Qg 1 0  0 0   226b   226b
```

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние кластера `elasticsearch` из `snapshot`, созданного ранее.

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```
curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "indices": "*",
  "include_global_state": true
}
'
```

```
$ curl 'localhost:9200/_cat/indices?pretty'
green open .geoip_databases 7v48846HI0KjC7lpLzLGDQ 1 0 41 0 38.6mb 38.6mb
green open test             rz9hEYwiD0Gmt299Kh-L3Q 1 0  0 0   226b   226b
```
