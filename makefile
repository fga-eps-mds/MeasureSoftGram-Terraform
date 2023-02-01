up: 
	docker cp ./data/backup.tar db:/
	docker exec db pg_restore -U postgres --dbname=postgres --verbose /backup.tar