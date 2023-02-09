#! /bin/bash

echo "Restore database"
# Run and resote dabatase	 
docker cp ./data/pgbackup.tar db:/
docker exec db pg_restore -U postgres --dbname=postgres  /pgbackup.tar > /dev/null
clear
echo "Database successfully restored"
echo "acesse a url  http://localhost/api/v1/"


