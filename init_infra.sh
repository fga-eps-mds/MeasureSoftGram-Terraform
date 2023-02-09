#! /bin/bash

# Run and resote dabatase
docker stop db && docker rm db
docker run --name db -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d  postgres			 
docker cp ./data/backup.tar db:/
docker exec postgres pg_restore -U postgres --dbname=postgres --verbose /backup.tar


# Remove network
docker network rm mynetwork

# Apply terraform
terraform apply
docker network connect mynetwork db

#Config nginx
docker exec nginx rm /etc/nginx/conf.d/default.conf
docker cp nginx.conf nginx:/etc/nginx/conf.d
docker exec nginx nginx -s reload





