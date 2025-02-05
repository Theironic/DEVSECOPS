# Projeto AWS Docker

## Arquitetura do projeto:

![Captura de tela de 2025-02-05 12-20-21_cleanup.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/Captura_de_tela_de_2025-02-05_12-20-21_cleanup.png)

## Requisitos do projeto:

- conta AWS
- Conhecimento básico em Amazon ec2 e VPCs.
- Docker / Docker compose
- Banco de dados (RDS)
- Volume: EFS

## Objetivos:

Criar uma aplicação WordPress usando docker e docker compose em um container multi AZ em subnets privadas com tráfego controlado por um load balancer .

## Passo a passo

### Criação de subnets

Pesquise no console da Amazon por subnet

![1000408621.jpg](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408621.jpg)

Dentro do painel aperte em criar Subnet 

**ID da VPC:**  `<sua vpc>`

**Nome da sub-rede:** <**`sua subnet`>**

**Zona de disponibilidade:** `<sua preferência`>

**Bloco CIDR:** <`Bloco`>

**Crie a sub rede.**

![1000408631.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408631.png)

Vamos precisar no total de 4 **Subnets,** duas públicas e e duas privadas, repita as instruções até atingir o número necessário de redes.

### Criação do internet gateway e NAT

Pesquise no console da AWS por Gateway .

![1000408657.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408657.png)

Clique em internet gateway 

**Tag de nome:** `<nome do Gateway>` 

Clique em criar Gateway 

Selecione o Gateway criado e associe a uma VPC.

![1000408658.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408658.png)

Agora vamos criar um NAT Gateway.

Mas antes você vai precisar alocar um IP elástico.

### Alocando um elastic IP

Pesquise no console da AWS IP elástico e clique alocar um IP.

![1000408659.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408659.png)

Clique em alocar.

Faça isso mais uma vez.

Agora vamos criar uma NAT Gateway.

### Gateway NAT

Pesquise por NAT Gateway.

Vai ser preciso ser criado dois NAT Gateway.

Clique em criar Gateway NAT .

![1000408667.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408667.png)

**Nome:** `<nome do gateway>`

**Subnet:** <`subnet privada>`

Aloque o IP elástico criado.

Crie o Gateway.

Próximo passo.

### Criar uma tabela de rotas .

Pesquise console **route tables.**

Aperta em criar uma nova tabela de rotas.

![1000408734.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408734.png)

![1000408735.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408735.png)

**Nome:** `<nome da sua rota>`

**VPC:** `<sua VPC>`

Clique em criar.

Crie 4 tabelas de rotas, ambas para cada subnet.

Agora vamos vincular as tabelas de rotas nas subnets.

Selecione cada tabela rota e vincule em suas subnets privadas e públicas.

![1000408773.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408773.png)

Agora clique em rotas e depois em editar rotas.

Vinculo o Gateway de internet nas suas subnets públicas nas duas tabela de rotas.

![1000408776.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408776.png)

Agora faço o mesmo com seus Gateway NAT mas use um Gateway diferente para cada tabela de rota na sua subnet público.

### Criar Banco de Dados RDS

Pesquise pelo serviço do RDS no console da AWS.

Clique em criar banco de Dados.

O maior requisito é selecionar o mesmo VPC que estão suas subnets, o resto da configuração vai ser de acordo com suas necessidades com o banco de Dados.

Não esquece de o nome do **banco de dados inicial** 

![1000408793.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408793.png)

Crie seu banco de dados.

### Criação do Amazon EFS

clique em criar sistemas de arquivos 

**Nome:** `<nome do efs>`

**VPC:** `<sua vpc>`

![1000408801.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408801.png)

Clique em criar.

### Criação do load balancer

Pesquise por load balancer.

Clique em criar load balancer.

### Notas :

Existe vários tipos de LB, para você encontrar o mais recomendo sugiro que pesquise na documentação da AWS.

Usarei o CLB.

**Nome:** `<nome do LB>`

**VPC:** `<sua vpc>`

![1000408809.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408809.png)

Vincule as subnets públicas.

![1000408815.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408815.png)

O resto pode deixar configuração padrão.

Crie o LB.

### Configuração do security group.

Pesquise no console security group.

Clique criar grupo de segurança ou edite um existe.

No SG da instância precisa da seguintes regras de entrada :

Permita conexão do MySQL e http para o security group do load balancer.

Do NFS e SSH você pode permitir conexão de qualquer lugar `0.0.0.0`/`0` .

![1000408824.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408824.png)

Verifique que o security group do load balancer está permitido conexão http de qualquer lugar.

![1000408851.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408851.png)

Edite o security group do BD RDS,  realizar conexão com o MySQL e todo tráfego, selecione o sg da instância.

![1000408851.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408851%201.png)

### Criar launch template

Pesquise por lauch template.

Clique em criar modelo.

O nome do template, AMI,tipo de instância ficará a sua escolhi.

A única coisa que você deveria seguir o obrigatoriamente é a seleção do SG da instância citado anteriormente e o script `user_data.sh` para conectar a instância ao banco de dados e o EFS automaticamente e criar o container Docker com a aplicação.

Em dados do usuário, adicione o seguinte script:

```bash
#!/bin/bash

sudo yum update -y

sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker

sudo yum install -y amazon-efs-utils

sudo mkdir -p /mnt/efs

sudo mount -t nfs -o nfsvers=4.1 fs-0cfbfc095fb55c2e3.efs.us-east-1.amazonaws.com:/ /mnt/efs

mkdir worpress
cd worpress/
touch docker-compose.yaml

file="docker-compose.yaml"
echo "services:" >> $file
echo "  wordpress:" >> $file
echo "    image: wordpress:latest" >> $file
echo "    container_name: wordpress" >> $file
echo "    ports:" >> $file
echo "      - \"80:80\"" >> $file
echo "    environment:" >> $file
echo "      WORDPRESS_DB_HOST: <end point>" >> $file
echo "      WORDPRESS_DB_USER: <usuário>" >> $file
echo "      WORDPRESS_DB_PASSWORD: <senha>" >> $file
echo "      WORDPRESS_DB_NAME: wpdatabase" >> $file
echo "    volumes:" >> $file
echo "      - /mnt/efs:/var/www/html" >> $file
echo "" >> $file
echo "volumes:" >> $file
echo "  wordpress_data:" >> $file

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo docker-compose up -d
```

O script funciona na AMI **Amazon Linux**.

### Criação do auto scaling groups.

Pesquise por auto scaling.

Clique em criar.

Em modelo de execução selecione o template criado.

![1000408860.png](Projeto%20AWS%20Docker%20191d69742e1c806eaccde1216683e08e/1000408860.png)

Clique em próximo.

Selecione a VPC.

**Zonas de disponibilidade:**

Selecione as subnet privadas.

Clique em próximo.

Selecione o seu load balancer criado.

Clique em próximo.

**Tamanho do grupo:**

Escolha a quantidade de instâncias.

Clique em próximo.

Na parte de análise, crie o grupo de auto scaling.

## Projeto finalizado.

Se você conseguiu seguir a passo a passo corretamente, estará com uma aplicação do WordPress rodando.