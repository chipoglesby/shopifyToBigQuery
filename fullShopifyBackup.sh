#!/bin/bash

# Replace the xxxx with your own values.
shopifyKey='xxxx'
shopifyPassword='xxxx'
storeName='xxxx'
cloudStorageBucket='xxxxx'
dataset='xxxx'
table='xxxxx'

full=$(curl "https://$shopifyKey:$shopifyPassword@$storeName.myshopify.com/admin/orders/count.json" | jq '.count')

limit=250

count=$((full / limit+1))

for page in $(seq 1 "$count");
  do
  curl "https://$shopifyKey:$shopifyPassword@$storeName.myshopify.com/admin/orders.json?limit=250&page=$page" | jq -c '.orders[]' >> fullBackup.json
done

if [ -s "fullBackup.json" ]; then
  gsutil -mq cp -r "fullBackup.json" "gs://$cloudStorageBucket/"
  bq load --source_format=NEWLINE_DELIMITED_JSON --autodetect --replace $dataset.$table "fullBackup.json"
 else
  echo "No information to upload"
 fi

# Then remove the file
rm -rf "fullBackup.json"
