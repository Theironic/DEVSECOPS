#!/bin/bash


# o script usa como base o gerenciador de pacotes apt, se sua distro Linux usa outro gerenciador de pacotes, esse script e inutil.
# antes de executar o script de permissao de execucao a ele com chmod +x

# o script instala o nginx e cria as pastas logs e shell como citado em DEVSECOPS/'sprint linux'/readme.md

sudo apt update
sudo apt -y upgrade
sudo apt install -y nginx
sudo systemctl enable nginx
sudo sysemctl start nginx



cd /home/$USER/
mkdir logs 
mkdir shell

