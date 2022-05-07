
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
      "number" : "7.16.0",
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

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

## Задача 3

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние кластера `elasticsearch` из `snapshot`, созданного ранее.

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

