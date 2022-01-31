# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | никакое, произойдет ошибка, python не сможет сложить число и строку  |
| Как получить для переменной `c` значение 12?  | сделать a строкой:       c=str(a)+ b  |
| Как получить для переменной `c` значение 3?  | сделать b целочисленным:       c=a+int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

path = "/vrem/netology/IVAN"
resolved_path = os.path.normpath(os.path.abspath(os.path.expanduser(os.path.expandvars(path))))
bash_command = [f"cd {resolved_path}", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print (os.path.join(resolved_path, prepare_result))```

### Вывод скрипта при запуске при тестировании:
```
root@vagrant:/vrem/netology/IVAN# python3 script.py
/vrem/netology/IVAN/1.md
/vrem/netology/IVAN/2.md.
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys
import subprocess
import re

try:
    path = sys.argv[1]
except IndexError:
    path = "/vrem/netology/IVAN"

resolved_path = os.path.normpath(os.path.abspath(os.path.expanduser(os.path.expandvars(path))))

try:
    result_os = subprocess.Popen(["git", "status", "--porcelain"], stdout=subprocess.PIPE,stderr=subprocess.STDOUT, cwd=resolved_pat>except FileNotFoundError:
    print(f'Не могу найти каталог {path}')
    exit()

if result_os[0].find('fatal:') >= 0:
    print(f'В каталоге {resolved_path} нет git репозитория. Поищите в другом месте.')
    exit()

list = {"M": "modified", "R": "renamed", "\?": "untracked"}

for result in result_os:
    for element in list.keys():
        regexp = re.compile(r"^ *" + element + "{1,2} *")
        if regexp.search(result):
            prepare_result = re.sub(regexp, '', result).split(' -> ')
            if list[element] == 'renamed':
                print(
                    f'{list[element]}:\t {os.path.join(resolved_path, prepare_result[1])} <- {prepare_result[0]}')
            else:
                print(
                    f'{list[element]}:\t {os.path.join(resolved_path, prepare_result[0])}')
```

### Вывод скрипта при запуске при тестировании:
```
modified:        /vrem/netology/IVAN/1.md
modified:        /vrem/netology/IVAN/2.md
untracked:       /vrem/netology/IVAN/3.md
untracked:       /vrem/netology/IVAN/4.md
untracked:       /vrem/netology/IVAN/script.py
untracked:       /vrem/netology/IVAN/scriptNEW.py
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket as s 
import time as t
import datetime as dt

# set variables 
i = 1
wait = 2 # интервал проверок в секундах
srv = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
init=0

print('*** start ***')
print(srv)
print('********************')

while 1==1 : #отладочное число проверок 
  for host in srv:
    ip = s.gethostbyname(host)
    if ip != srv[host]:
      if i==1 and init !=1:
        print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip)
      srv[host]=ip
# счетчик итераций для отладки, закомментировать для бесконечного цикла 3 строки
  i+=1 
  if i >= 50 : 
    break
  t.sleep(wait)
```

### Вывод скрипта при запуске при тестировании:
```
*** start ***
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
********************
2022-01-30 15:59:25 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 64.233.165.194
2022-01-30 15:59:25 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 173.194.221.18
2022-01-30 15:59:25 [ERROR] google.com IP mistmatch: 0.0.0.0 74.125.131.138
```