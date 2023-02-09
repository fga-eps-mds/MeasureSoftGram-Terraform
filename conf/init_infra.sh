#! /bin/bash

# Remove network
docker network rm mynetwork

# Apply terraform   
terraform apply
docker network connect mynetwork db


#Config nginx
docker exec nginx rm /etc/nginx/conf.d/default.conf
docker cp ./nginx.conf nginx:/etc/nginx/conf.d
docker exec nginx nginx -s reload






