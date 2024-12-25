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
