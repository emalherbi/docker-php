# docker-php

Ambiente Docker de desenvolvimento com PHP 7.4, PHP 8.4, MariaDB, phpMyAdmin e suporte a SQL Server.

## Serviços

| Serviço    | Imagem         | Porta Host                | Descrição              |
| ---------- | -------------- | ------------------------- | ---------------------- |
| php8       | php:8.4-apache | 8100 (HTTP), 8443 (HTTPS) | PHP 8.4 + Apache       |
| php7       | php:7.4-apache | 7100 (HTTP), 7443 (HTTPS) | PHP 7.4 + Apache       |
| db         | mariadb:10.11  | 9306                      | Banco de dados MariaDB |
| phpmyadmin | phpmyadmin:5.2 | 9100                      | Administração do banco |

## Extensões PHP instaladas

| Extensão   | PHP 7.4 | PHP 8.4 |
| ---------- | ------- | ------- |
| mysqli     | ✓       | ✓       |
| pdo_mysql  | ✓       | ✓       |
| sqlsrv     | 5.10.1  | 5.13.1  |
| pdo_sqlsrv | 5.10.1  | 5.13.1  |
| gd         | ✓       | ✓       |
| zip        | ✓       | ✓       |
| pdo_odbc   | ✓       | ✓       |
| Composer   | ✓       | ✓       |

## Configuração do volume

O volume padrão monta a pasta pai do projeto em `/var/www/html`:

```yml
volumes:
  - ../:/var/www/html
```

Ajuste no [docker-compose.yml](docker-compose.yml) conforme a estrutura local se necessário.

## Credenciais padrão

| Serviço    | Usuário | Senha | Banco  |
| ---------- | ------- | ----- | ------ |
| MariaDB    | root    | root  | —      |
| MariaDB    | app     | app   | app_db |
| phpMyAdmin | root    | root  | —      |

## Comandos

### Subir o ambiente

```bash
docker compose up -d --build
```

### Subir sem cache (build limpo)

```bash
docker compose build --no-cache
docker compose up -d
```

### Parar o ambiente

```bash
docker compose down
```

### Parar e remover volumes (apaga dados do banco)

```bash
docker compose down -v
```

### Ver status dos containers

```bash
docker ps
```

### Ver logs de um container

```bash
docker compose logs -f php8
docker compose logs -f php7
docker compose logs -f db
```

### Acessar o terminal de um container

```bash
docker exec -it php8 bash
docker exec -it php7 bash
docker exec -it db bash
```

### Verificar extensões PHP

```bash
# Listar todas as extensões
docker exec php7 php -m
docker exec php8 php -m

# Verificar sqlsrv
docker exec php7 php --ri sqlsrv
docker exec php7 php --ri pdo_sqlsrv
docker exec php8 php --ri sqlsrv
docker exec php8 php --ri pdo_sqlsrv
```

### Verificar versão do PHP

```bash
docker exec php7 php -v
docker exec php8 php -v
```

### Acessar o MariaDB via terminal

```bash
docker exec -it db mariadb -uroot -proot
```

### Executar comandos PHP e Composer

PHP e Composer só existem dentro dos containers — não são instalados no sistema operacional local.

**Comando avulso (direto do terminal):**

```bash
docker exec -w /var/www/html php8 php -v
docker exec -w /var/www/html php8 composer install
docker exec -w /var/www/html php8 composer update
```

O `-w /var/www/html` define o diretório de trabalho dentro do container.

Exemplo de comando dentro de uma pasta específica do projeto:

```bash
docker exec -w /var/www/html/work/minhaPasta/ php8 composer install
```

**Vários comandos seguidos (entrar no container):**

```bash
docker exec -it php8 bash

# agora dentro do container:
cd /var/www/html
composer update
php artisan migrate
```

### Rodar o PHP-CS-Fixer (só no php8)

O `php8` tem o [PHP-CS-Fixer](https://cs.symfony.com/) instalado globalmente. Rode com `-w` apontando para a pasta do projeto (relativa a `/var/www/html`):

```bash
# Ver o que mudaria (dry-run), sem aplicar
docker exec -w /var/www/html/work/minhaPasta php8 php-cs-fixer fix --dry-run --diff caminho/arquivo.php

# Aplicar em um arquivo
docker exec -w /var/www/html/work/minhaPasta php8 php-cs-fixer fix caminho/arquivo.php

# Aplicar em uma pasta inteira
docker exec -w /var/www/html/work/minhaPasta php8 php-cs-fixer fix caminho/pasta/

# Aplicar no projeto inteiro
docker exec -w /var/www/html/work/minhaPasta php8 php-cs-fixer fix
```

## URLs de acesso

| Serviço    | URL                   |
| ---------- | --------------------- |
| PHP 8.4    | http://localhost:8100 |
| PHP 7.4    | http://localhost:7100 |
| phpMyAdmin | http://localhost:9100 |
| MariaDB    | localhost:9306        |

## Configurações PHP

| Diretiva            | Valor             |
| ------------------- | ----------------- |
| date.timezone       | America/Sao_Paulo |
| memory_limit        | 2G                |
| upload_max_filesize | 2G                |
| post_max_size       | 2G                |
| max_execution_time  | 300s              |
