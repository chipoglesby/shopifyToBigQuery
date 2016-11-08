#!/bin/bash

after=$(TZ='America/Denver' date +%FT%TZ)
before=$(TZ='America/Denver' date +%FT%TZ)

shopifyKey='xxxx'
shopifyPassword='xxxx'
storeName='xxxx'
cloudStorageBucket='xxxxx'
dataset='xxxx'
table='xxxxx'

# CURL the API and return any new orders at this time.
curl "https://$shopifyKey:$shopifyPassword@$storeName.myshopify.com/admin/orders.json?limit=250&updated_at_min=$before&updated_at_max=$after" | jq -c '.orders[]' >> "$after.json"

# If the file size is greater than zero, then process the orders
if [ -s "$after.json" ]; then
  gsutil -mq cp -r "$after.json" "$cloudStorageBucket/"
  bq load --source_format=NEWLINE_DELIMITED_JSON $dataset.$table "$after.json" shopify.json
 else
  echo "No information to upload"
 fi

# Then remove the file
rm -rf "$after.json"