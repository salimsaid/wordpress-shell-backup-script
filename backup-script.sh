#!/bin/bash

cat <<EOF
Copyright (c) 2020 Salim Said

See LICENSE file for more info.
EOF

# Generate your Dropbox token: https://www.dropbox.com/developers/apps
DROPBOX_TOKEN=replace-with-your-dropbox-access-token

DATABASE_NAME=replace-with-your-database-name
DATABASE_USER=replace-with-your-database-user
DATABASE_PASSWORD=replace-with-your-database-password

DROPBOX_BACKUP_PATH=/my_wordpress_backups/

# Directory that holds your WordPress sites' root folders, replace with your website path
WWW_PATH=/var/www/html/

# Directory where this script lives, replace with your script path
SCRIPT_PATH=/home/salim/Desktop/restore/scripts/

# If you have multiple folders with WordPress sites, add/remove them from this array
directories=( "test.site" )

for dir in "${directories[@]}"
do
  :
  printf "Backing up $WWW_PATH/$dir:n \n"
  cd $WWW_PATH/$dir


  printf "Exporting database...n\n"
  DATABASE_FILENAME=$dir.sql
  mysqldump -u$DATABASE_USER -p$DATABASE_PASSWORD $DATABASE_NAME > $DATABASE_FILENAME

  cd $SCRIPT_PATH

  printf "Compressing directory...n\n"
  BACKUP_FILENAME=$dir.$(date -d today "+%Y%m%d").tar.gz
  printf "The backup file name is $BACKUP_FILENAME \n"

  #cd into the site directory to prevent tar from archiving absolute paths i.e. /var/www/html/*
  cd $WWW_PATH/$dir

  tar czf $SCRIPT_PATH$BACKUP_FILENAME *

  cd $SCRIPT_PATH

  

  printf "Uploading to Dropbox...n"
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $DROPBOX_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"$DROPBOX_BACKUP_PATH$BACKUP_FILENAME\",\"mode\": \"add\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$BACKUP_FILENAME

  printf "Removing files...n \n"
  rm $WWW_PATH$dir/$DATABASE_FILENAME
  rm $BACKUP_FILENAME

  printf "Done!n"
done