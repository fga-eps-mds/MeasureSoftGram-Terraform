# Adicionar https no backend


Precisamos que nosso domínios possuam um certificado SSL para permitir uma comunicação criptografada, vinda de nossos clientes, ou mesmo, entre nossas aplicações. Para isso, usaremos as seguintes tecnologias: (cada aplicação/serviço nosso está dentro de um Docker container), (servidor web que receberá as configurações para comunicação), (será o responsável por gerar o certificado paraNGINX Certbot usarmos no nosso servidor)


## Estrutura

A estrutura usada para nossa configuração será a seguinte:
        
        /compose
            cerbot.yaml Onde estará a configuração do container docker NGINX e Certbot;
            /dhparam
                dhparam-2048.pem
            /dockerfile
                Dockerfile

## 1- Criar chave dhparam

Verifique que você esteja no diretorio compose/dh-param/, caso não entre no mesmo.

        user@ip:~/2022-2-MeasureSoftGram-Terraform/compose/$ cd dhparam
        user@ip:~/2022-2-MeasureSoftGram-Terraform/compose/dhparam$ pwd

O resultado do segundo comando vai ser o caminho absoluto da pasta, com isso use o seguinte comando. 

``` openssl dhparam -out /caminho_absoluto/dhparam-2048.pem 2048 ```

Pronto vocês acabou de gerar a chave.

## 2- Modificar o DNS

No arquivo de nginx.conf encontrado na raiz do projeto, você vai trocar por esse codigo.

        server {
            listen 80;
            server_name msg.com.br;
            root /public_html/;
                location ~ /.well-known/acme-challenge{
                allow all;
                root /usr/share/nginx/html/letsencrypt;
            }
        }

Em seguinda procure o arquivo chamado cerbot.yaml, que se localiza no /compose, na linha 17, você vai adicionar seu dns no lugar de msg.com.br.

     certonly --webroot --webroot-path=/usr/share/nginx/html/letsencrypt --email tecnologia@msg.gmail.com --agree-tos --no-eff-email -d msg.com.br


## 3-  Gerar o certificado ssl

Entre na pasta /compose e execulte o seguinte comando:

        docker-compose -f cerbot.yaml up -d


Agora vamos verificar se gerou, use o comando:

        docker logs cerbot

No final vai aparecer a seguinte menssagem:

        Sucessfully received certificate

## 4- Reconfigurar o nginx

Modifique o msg.com.br pelo seu Dominio


    server {
        listen 80;
        server_name msg.com.br;
        location ~ /.well-known/acme-challenge{
            allow all;
            root /usr/share/nginx/html/letsencrypt;
        }

        location / {
        return 301 msg.com.br$request_uri;
        }
    }

    server {
        listen 443 ssl http2;
        server_name msg.com.br;
        ssl on;
        server_tokens off;
        ssl_certificate /etc/nginx/ssl/live/msg.com.br/fullchain.pem;
        ssl_certificate_key /etc/nginx/ssl/live/msg.com.br/privkey.pem;
        ssl_dhparam /etc/nginx/dhparam/dhparam-2048.pem;
        ssl_buffer_size 8k;
        ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
        ssl_prefer_server_ciphers on;
        ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;


        location / {
            proxy_pass http://msg-service:80;
        }

    }


E por fim, der um reload no nginx


         docker-compose -f cerbot.yaml up --build -d

Pronto Agora você tem seu https implementado.






