# documentação servidor nginx

## objetivos:

- Criar um servidor Nginx
- Criar um script que tenha duas saidas de logs um para status online e outro offline
- automatizar a execucao com o Cron

## requisitos do projeto

- WSL ou Linux
- Windows 10 ou superior
- ubuntu 20.04 ou superior

## atualize o sistema

antes de iniciar a instalação do nginx atualize o seu sistema para manter os pacotes atualizados.

[data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAzMiAzMiI+CiAgPGRlZnM+CiAgICA8cG9seWdvbiBpZD0ic21hbGwtdmlzZW1lLXYzLWEiIHBvaW50cz0iMCAwIDMyIDAgMzIgMzIgMCAzMiIvPgogIDwvZGVmcz4KICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgPG1hc2sgaWQ9InNtYWxsLXZpc2VtZS12My1iIiBmaWxsPSIjZmZmIj4KICAgICAgPHVzZSB4bGluazpocmVmPSIjc21hbGwtdmlzZW1lLXYzLWEiLz4KICAgIDwvbWFzaz4KICAgIDx1c2UgZmlsbD0iIzQyODVGNCIgeGxpbms6aHJlZj0iI3NtYWxsLXZpc2VtZS12My1hIi8+CiAgICA8cGF0aCBmaWxsPSIjRDJFM0ZDIiBkPSJNMCwxNS4yMzk3OTYzIEMyLjU0Mzg1NzE0LDE4Ljg3MDUyMDMgNS42NTIsMjIuMDgyMTk0NiA5LjIwMjI4NTcxLDI0Ljc0NDg3NjkgQzEzLjIxMTU3MTQsMjcuNzUxNzA3NyAxOC43ODg0Mjg2LDI3Ljc1MTcwNzcgMjIuNzk3NzE0MywyNC43NDQ4NzY5IEMyNi4zNDgsMjIuMDgyMTk0NiAyOS40NTYxNDI5LDE4Ljg3MDUyMDMgMzIsMTUuMjM5Nzk2MyBMMzIsLTcgTDAsLTcgTDAsMTUuMjM5Nzk2MyBaIiBtYXNrPSJ1cmwoI3NtYWxsLXZpc2VtZS12My1iKSIvPgogICAgPHBhdGggZmlsbD0iIzQyODVGNCIgZmlsbC1vcGFjaXR5PSIuNiIgZD0iTTE2LDIxLjIzMDY0OTIgQzE2LjkyNjA5OTEsMjEuMjMwNjQ5MiAxNy43OTEyNDY3LDIxLjQ5NDMxNTcgMTguNTI3MjEzNSwyMS45NTE1MDE5IEMxOC44MTA0NDEsMjIuMTI3MzMwOSAxOS4xMzYyNzM4LDIxLjc4ODc0ODUgMTguOTQwMzc5OSwyMS41MTY0Njc0IEMxOC4yNzg1NTU2LDIwLjU5NzMyNjMgMTcuMjA4MTEzNiwyMCAxNiwyMCBDMTQuNzkxODg2NCwyMCAxMy43MjE0NDQ0LDIwLjU5NzMyNjMgMTMuMDU5NjIwMSwyMS41MTY0Njc0IEMxMi44NjM3MjYyLDIxLjc4ODc0ODUgMTMuMTg5NTU5LDIyLjEyNzMzMDkgMTMuNDcyNzg2NSwyMS45NTE1MDE5IEMxNC4yMDg3NTMzLDIxLjQ5NDMxNTcgMTUuMDczOTAwOSwyMS4yMzA2NDkyIDE2LDIxLjIzMDY0OTIiIG1hc2s9InVybCgjc21hbGwtdmlzZW1lLXYzLWIpIi8+CiAgICA8cGF0aCBzdHJva2U9IiM0Mjg1RjQiIHN0cm9rZS1saW5lY2FwPSJzcXVhcmUiIGQ9Ik0yNSwxMyBDMjMsMTUuMzMzMzMzMyAyMCwxNi41IDE2LDE2LjUgQzEyLDE2LjUgOSwxNS4zMzMzMzMzIDcsMTMgTDEzLDEwLjUgTDE5LDEwLjUgTDI1LDEzIFoiIG1hc2s9InVybCgjc21hbGwtdmlzZW1lLXYzLWIpIi8+CiAgICA8cG9seWdvbiBmaWxsPSIjNDI4NUY0IiBmaWxsLXJ1bGU9Im5vbnplcm8iIHBvaW50cz0iOCAxNCA3IDEzIDI1IDEzIDI0IDE0IiBtYXNrPSJ1cmwoI3NtYWxsLXZpc2VtZS12My1iKSIvPgogICAgPHBhdGggc3Ryb2tlPSIjNDI4NUY0IiBzdHJva2UtbGluZWNhcD0icm91bmQiIGQ9Ik0yMCwzIEwxNy43Njc4NzUsNS4yNTg5MjYyMiBDMTYuNzkxNSw2LjI0NzAyNDU5IDE1LjIwODUsNi4yNDcwMjQ1OSAxNC4yMzIxMjUsNS4yNTg5MjYyMiBMMTIsMyIgbWFzaz0idXJsKCNzbWFsbC12aXNlbWUtdjMtYikiLz4KICA8L2c+Cjwvc3ZnPgo=](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAzMiAzMiI+CiAgPGRlZnM+CiAgICA8cG9seWdvbiBpZD0ic21hbGwtdmlzZW1lLXYzLWEiIHBvaW50cz0iMCAwIDMyIDAgMzIgMzIgMCAzMiIvPgogIDwvZGVmcz4KICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgPG1hc2sgaWQ9InNtYWxsLXZpc2VtZS12My1iIiBmaWxsPSIjZmZmIj4KICAgICAgPHVzZSB4bGluazpocmVmPSIjc21hbGwtdmlzZW1lLXYzLWEiLz4KICAgIDwvbWFzaz4KICAgIDx1c2UgZmlsbD0iIzQyODVGNCIgeGxpbms6aHJlZj0iI3NtYWxsLXZpc2VtZS12My1hIi8+CiAgICA8cGF0aCBmaWxsPSIjRDJFM0ZDIiBkPSJNMCwxNS4yMzk3OTYzIEMyLjU0Mzg1NzE0LDE4Ljg3MDUyMDMgNS42NTIsMjIuMDgyMTk0NiA5LjIwMjI4NTcxLDI0Ljc0NDg3NjkgQzEzLjIxMTU3MTQsMjcuNzUxNzA3NyAxOC43ODg0Mjg2LDI3Ljc1MTcwNzcgMjIuNzk3NzE0MywyNC43NDQ4NzY5IEMyNi4zNDgsMjIuMDgyMTk0NiAyOS40NTYxNDI5LDE4Ljg3MDUyMDMgMzIsMTUuMjM5Nzk2MyBMMzIsLTcgTDAsLTcgTDAsMTUuMjM5Nzk2MyBaIiBtYXNrPSJ1cmwoI3NtYWxsLXZpc2VtZS12My1iKSIvPgogICAgPHBhdGggZmlsbD0iIzQyODVGNCIgZmlsbC1vcGFjaXR5PSIuNiIgZD0iTTE2LDIxLjIzMDY0OTIgQzE2LjkyNjA5OTEsMjEuMjMwNjQ5MiAxNy43OTEyNDY3LDIxLjQ5NDMxNTcgMTguNTI3MjEzNSwyMS45NTE1MDE5IEMxOC44MTA0NDEsMjIuMTI3MzMwOSAxOS4xMzYyNzM4LDIxLjc4ODc0ODUgMTguOTQwMzc5OSwyMS41MTY0Njc0IEMxOC4yNzg1NTU2LDIwLjU5NzMyNjMgMTcuMjA4MTEzNiwyMCAxNiwyMCBDMTQuNzkxODg2NCwyMCAxMy43MjE0NDQ0LDIwLjU5NzMyNjMgMTMuMDU5NjIwMSwyMS41MTY0Njc0IEMxMi44NjM3MjYyLDIxLjc4ODc0ODUgMTMuMTg5NTU5LDIyLjEyNzMzMDkgMTMuNDcyNzg2NSwyMS45NTE1MDE5IEMxNC4yMDg3NTMzLDIxLjQ5NDMxNTcgMTUuMDczOTAwOSwyMS4yMzA2NDkyIDE2LDIxLjIzMDY0OTIiIG1hc2s9InVybCgjc21hbGwtdmlzZW1lLXYzLWIpIi8+CiAgICA8cGF0aCBzdHJva2U9IiM0Mjg1RjQiIHN0cm9rZS1saW5lY2FwPSJzcXVhcmUiIGQ9Ik0yNSwxMyBDMjMsMTUuMzMzMzMzMyAyMCwxNi41IDE2LDE2LjUgQzEyLDE2LjUgOSwxNS4zMzMzMzMzIDcsMTMgTDEzLDEwLjUgTDE5LDEwLjUgTDI1LDEzIFoiIG1hc2s9InVybCgjc21hbGwtdmlzZW1lLXYzLWIpIi8+CiAgICA8cG9seWdvbiBmaWxsPSIjNDI4NUY0IiBmaWxsLXJ1bGU9Im5vbnplcm8iIHBvaW50cz0iOCAxNCA3IDEzIDI1IDEzIDI0IDE0IiBtYXNrPSJ1cmwoI3NtYWxsLXZpc2VtZS12My1iKSIvPgogICAgPHBhdGggc3Ryb2tlPSIjNDI4NUY0IiBzdHJva2UtbGluZWNhcD0icm91bmQiIGQ9Ik0yMCwzIEwxNy43Njc4NzUsNS4yNTg5MjYyMiBDMTYuNzkxNSw2LjI0NzAyNDU5IDE1LjIwODUsNi4yNDcwMjQ1OSAxNC4yMzIxMjUsNS4yNTg5MjYyMiBMMTIsMyIgbWFzaz0idXJsKCNzbWFsbC12aXNlbWUtdjMtYikiLz4KICA8L2c+Cjwvc3ZnPgo=)

```bash
sudo apt update
sudo apt upgrade
```

![Captura de tela de 2024-12-20 19-14-22.png](documentac%CC%A7a%CC%83o%20servidor%20nginx%20162d69742e1c807ba497ed60d2a3b96a/Captura_de_tela_de_2024-12-20_19-14-22.png)

## instale o nginx

```bash
sudo apt update
sudo apt install -y nginx 
```

confira se o Nginx esta ativado com:

```bash
sudo systemctl status nginx
```

![Captura de tela de 2024-12-21 17-48-42.png](documentac%CC%A7a%CC%83o%20servidor%20nginx%20162d69742e1c807ba497ed60d2a3b96a/Captura_de_tela_de_2024-12-21_17-48-42.png)

se o serviço estiver com status de desativado use:

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

se você seguiu todos os passos corretamente, você ja consegue acessar seu servidor por [https://localhost/](https://localhost/) 

![Captura de tela de 2024-12-22 10-12-20.png](documentac%CC%A7a%CC%83o%20servidor%20nginx%20162d69742e1c807ba497ed60d2a3b96a/Captura_de_tela_de_2024-12-22_10-12-20.png)

## Criação de script de validação

usaremos o cron (daemo) para agendar a execução do script.

crie dois diretorios (com nome da sua escolha), um para o script e outro para armazenar a o log do servidor do script na pasta do usuario.

```bash
mkdir shell
mkdir logs
```

crie o script na pasta shell.

```bash
cd shell
touch auto.sh
```

copie e cole dentro do script, use o nano ou outros editores de sua preferência.

```bash
sudo nano auto.sh
```

```bash

#!/bin/bash

# logs
LOG_ON="/home/$USER/logs/nginx_statusOn.log"
LOG_OFF="/home/$USER/logs/nginx_statusOff.log"
# obtendo a hora
DATA_HORA=$(date)

# Verificando o status do Nginx
STATUS=$(systemctl is-active nginx)

# checagem
if [ "$STATUS" == "active" ]; then
    echo "$DATA_HORA - | Nginx | ONLINE | servidor esta online." >> "$LOG_ON"
else
    echo "$DATA_HORA - | Nginx | OFFLINE | servidor esta offline. :(" >> "$LOG_OFF"
fi
```

Agora de permissão de execução para seu script.

```bash
sudo chmod +x auto.sh
```

## agendando execução do script no cron

agora vamos fazer agendar a execução do script a cada 5 minutos usando o cron,

o comando a seguir vai ser para adicionar a execução.

```bash
crontab -e
```

agora copia e cole dentro .

```bash
*/5 * * * * /home/lucca/shell/auto.sh
```

pode salvar e sair.

agora voce vai ter o registro de dois arquivos .log que monitaram seu servidor Nginx.

![Captura de tela de 2024-12-23 14-39-40.png](documentac%CC%A7a%CC%83o%20servidor%20nginx%20162d69742e1c807ba497ed60d2a3b96a/Captura_de_tela_de_2024-12-23_14-39-40.png)

## Conclusão:

Após seguir todos os passos, você já terá um servidor funcionando com monitoramento ativo.

![tets.jpeg](documentac%CC%A7a%CC%83o%20servidor%20nginx%20162d69742e1c807ba497ed60d2a3b96a/tets.jpeg)