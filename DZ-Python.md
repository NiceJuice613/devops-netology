# �������� ������� � ������� "4.2. ������������� Python ��� ������� ������� DevOps �����"

## ������������ ������ 1

���� ������:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### �������:
| ������  | ����� |
| ------------- | ------------- |
| ����� �������� ����� ��������� ���������� `c`?  | �������, ���������� ������, python �� ������ ������� ����� � ������  |
| ��� �������� ��� ���������� `c` �������� 12?  | ������� a �������:       c=str(a)+ b  |
| ��� �������� ��� ���������� `c` �������� 3?  | ������� b �������������:       c=a+int(b)  |

## ������������ ������ 2
�� ���������� �� ������ � ��������, ��� ������ ��� ��� DevOps Engineer. �� ������� ������, ����������� ������, ����� ����� �������������� � �����������, ������������ ��������� ���������. ���� �������� ���������� ����������, ������ ��� � ��� ������ ���� �� ��� ��������� �����, � ����� ��������� ������ ���� � ����������, ��� ��� ���������. ��� ����� ���������� ������ ����, ����� �� �������� ���������� ������ ������������?

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

### ��� ������:
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

### ����� ������� ��� ������� ��� ������������:
```
root@vagrant:/vrem/netology/IVAN# python3 script.py
/vrem/netology/IVAN/1.md
/vrem/netology/IVAN/2.md.
```

## ������������ ������ 3
1. ���������� ������ ���� ���, ����� �� ��� ��������� �� ������ ��������� ����������� � ������� ����������, � ����� ���� ������������ ���� � �����������, ������� �� ������� ��� ������� ��������. �� ����� �����, ��� ���������� �������� � ����� ��������� ������ ����� ������� � �����������, ������� �� �������� ���������� �������������.

### ��� ������:
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
    print(f'�� ���� ����� ������� {path}')
    exit()

if result_os[0].find('fatal:') >= 0:
    print(f'� �������� {resolved_path} ��� git �����������. ������� � ������ �����.')
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

### ����� ������� ��� ������� ��� ������������:
```
modified:        /vrem/netology/IVAN/1.md
modified:        /vrem/netology/IVAN/2.md
untracked:       /vrem/netology/IVAN/3.md
untracked:       /vrem/netology/IVAN/4.md
untracked:       /vrem/netology/IVAN/script.py
untracked:       /vrem/netology/IVAN/scriptNEW.py
```

## ������������ ������ 4
1. ���� ������� ������������� ��������� ���-��������, ��������� �� http. �� ����� �����, ��� �� �� ������ ��� ������� ������������, �������������, �� DNS �������� ���������� IP �������, ��� ���������� ������. �������� � ���, ��� �����, ������������ ����� ��������������� ����� ����� ������ ��� �������, ������� IP �������� �������� ��� � ������, ��� ���� ������� ��������� �� ����� DNS �����. ��� �� ������ ������ �� ����������, ���� �� ��������� ��� ������� �� ������� � ����� ������� ���� ����� ��������, ������� ���������� ��� �������������. �� ����� �������� ������, ������� ���������� ���-�������, �������� �� IP, ������� ���������� � ����������� ����� � ����: <URL �������> - <��� IP>. �����, ������ ���� ����������� ����������� �������� �������� IP ������� c ��� IP �� ���������� ��������. ���� �������� ����� ��������� - ���������� �� ���� � ����������� ����� ����������: [ERROR] <URL �������> IP mismatch: <������ IP> <����� IP>. ����� �������, ��� ���� ���������� ����������� �������: `drive.google.com`, `mail.google.com`, `google.com`.

### ��� ������:
```python
#!/usr/bin/env python3

import socket as s 
import time as t
import datetime as dt

# set variables 
i = 1
wait = 2 # �������� �������� � ��������
srv = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
init=0

print('*** start ***')
print(srv)
print('********************')

while 1==1 : #���������� ����� �������� 
  for host in srv:
    ip = s.gethostbyname(host)
    if ip != srv[host]:
      if i==1 and init !=1:
        print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip)
      srv[host]=ip
# ������� �������� ��� �������, ���������������� ��� ������������ ����� 3 ������
  i+=1 
  if i >= 50 : 
    break
  t.sleep(wait)
```

### ����� ������� ��� ������� ��� ������������:
```
*** start ***
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
********************
2022-01-30 15:59:25 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 64.233.165.194
2022-01-30 15:59:25 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 173.194.221.18
2022-01-30 15:59:25 [ERROR] google.com IP mistmatch: 0.0.0.0 74.125.131.138
```