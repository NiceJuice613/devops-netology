# �������� ������� � ������� "4.3. ����� �������� JSON � YAML"


## ������������ ������ 1
�� ��������� JSON, ������� �������� ����� API ������ � ������ �������:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" : [
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
  ����� ����� � ��������� ��� ������, ������� ��������� ��� ������.

## ������������ ������ 2
� ������� ������� ���� �� ��������� ������, ����������� ���������� ���-������� � �������� �� IP. � ��� �������������� ����������� ��� ����� �������� ����������� ������ JSON � YAML ������, ����������� ���� �������. ������ ������ JSON �� ������ �������: `{ "��� �������" : "��� IP"}`. ������ ������ YAML �� ������ �������: `- ��� �������: ��� IP`. ���� � ������ ���������� ������� �������� IP � ������� - �� ������ ��� �� ���������� � yml � json �����.

### ��� ������:
```python
#!/usr/bin/env python3

import socket
import time
import json
import yaml
import time

hosts = {"drive.google.com": "192.168.0.1",
         "mail.google.com": "172.16.0.1", "google.com": "10.0.0.1"}

while True:
    try:
        with open('./serv.json', 'r+') as config_json, open('./serv.yaml', 'r+') as config_yaml:
            try:
                hosts_json = json.load(config_json)
                print(f"�������� ./serv.json")
            except json.decoder.JSONDecodeError as e:
                print(f"���� ./serv.json ����� ������������ ������.")
                exit()
            try:
                hosts_yaml = hosts_yaml = yaml.load(
                    config_yaml.read(), Loader=yaml.SafeLoader)
                print(f"�������� ./serv.yaml")
            except yaml.scanner.ScannerError as e:
                print(f"���� ./serv.yaml ����� ������������ ������.")
                exit()
            if hosts_yaml != hosts_json:
                print(
                    f"""\n������ ������� � json � yaml ����������:\n\nyaml: {hosts_yaml}\njson: {hosts_json}\n\n������� ���� ��� ��������� ������� � ������������� ������.\n""")
                exit()
            else:
                try:
                    hosts = hosts_yaml
                    while True:
                        for host in hosts:
                            cur_ip = hosts[host]
                            check_ip = socket.gethostbyname(host)
                            if check_ip != cur_ip:
                                print(
                                    f"""[ERROR] {host} IP mismatch: {cur_ip} {check_ip}""")
                                hosts[host] = check_ip
                                with open("./serv.json", 'w+') as write_json, open("./serv.yaml", 'w+') as write_yaml:
                                    write_json.write(
                                        json.dumps(hosts, indent=4))
                                    write_yaml.write(
                                        yaml.dump(hosts, indent=4))
                            else:
                                print(f"""{host} - {cur_ip}""")
                        time.sleep(2)
                except KeyboardInterrupt:
                    config_json.close
                    config_json.close
                    break
    except FileNotFoundError as e:
        print(f'���� ����������� - {e.filename}, ������ ')
        config = open(e.filename, 'w+')
        if config.name.endswith('.json'):
            try:
                config_yaml = open('./serv.yaml', 'r+').read()
                hosts_yaml = yaml.load(
                    config_yaml, Loader=yaml.SafeLoader)
                config.write(json.dumps(hosts_yaml, indent=4))
            except FileNotFoundError:
                config.write(json.dumps(hosts, indent=4))
            except:
                print('���-�� ����� �� �� �����')
                exit()
        elif config.name.endswith('yaml') or e.filename.endswith('yml'):
            try:
                config_json = open('./serv.json', 'r+')
                hosts_json = json.load(
                    config_json)
                config.write(yaml.dump(hosts_json, indent=4))
            except FileNotFoundError:
                config.write(json.dumps(hosts, indent=4))
            except:
                print('���-�� ����� �� �� �����')
                exit()
        config.read()
```

### ����� ������� ��� ������� ��� ������������:
```
vagrant@vagrant:/vrem/netology/IVAN$ ./script.py
�������� ./serv.json
�������� ./serv.yaml
drive.google.com - 209.85.233.194
[ERROR] google.com IP mismatch: 64.233.162.139 64.233.162.102
mail.google.com - 74.125.131.83
drive.google.com - 209.85.233.194
[ERROR] google.com IP mismatch: 64.233.162.102 64.233.162.101
[ERROR] mail.google.com IP mismatch: 74.125.131.83 74.125.131.19
drive.google.com - 209.85.233.194
google.com - 64.233.162.101git 
mail.google.com - 74.125.131.19
drive.google.com - 209.85.233.194
google.com - 64.233.162.101
mail.google.com - 74.125.131.19
drive.google.com - 209.85.233.194
google.com - 64.233.162.101
mail.google.com - 74.125.131.19
```

### json-����(�), �������(�) ������� ��� ������:
```json
{
    "drive.google.com": "209.85.233.194",
    "google.com": "64.233.162.101",
    "mail.google.com": "74.125.131.19"
}
```

### yml-����(�), �������(�) ������� ��� ������:
```yaml
drive.google.com: 209.85.233.194
google.com: 64.233.162.101
mail.google.com: 74.125.131.19
```
