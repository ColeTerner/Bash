#!/bin/bash

#0.Variables(all)

DB_NAME="postgres"
BACKUP_DIR="/usr/bin/backup_of_postgres"
BACKUP_FILENAME="${DB_NAME}_$(date +"%Y%m%d%H%M%S").sql"
MAX_BACKUPS=10

#1.Create folder to backup

if [ -d "$BACKUP_DIR" ]; then
	echo "$BACKUP_DIR is already exists!"
else
	sudo mkdir -p $BACKUP_DIR
	sudo chown -R detect:detect $BACKUP_DIR
	sudo chmod 770 $BACKUP_DIR
	echo "$BACKUP_DIR is done!"
fi

#2.Make backup of postgresql

sudo pg_dump -U root -d "$DB_NAME" > "$BACKUP_DIR/$BACKUP_FILENAME"

#3.Check that backup is in place
#($? - keep error code of previous command : 0 - it was succesfull)


if [ $? -eq 0 ]; then
	echo "Backup of database '$DB_NAME' completed succesfully: $BACKUP_FILENAME"
else
	echo "Backup of database '$DB_NAME' failed"
fi


#4.DELETE IF MORE THAN 10 BACKUPS

if [ $(ls -l "$BACKUP_DIR" | wc -l) -gt "$MAX_BACKUPS" ]; then
	list=$(ls -t $BACKUP_DIR | head)
	echo $list
	cd $BACKUP_DIR
	remove_list=$(ls $BACKUP_DIR | grep -v "$list[@]")
	rm ${remove_list[@]}
	echo "Number of backups - $(ls -lah $BACKUP_DIR | wc -l)"
fi


