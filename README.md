# Shopify to Google BigQuery Using a Shell Script

This shell script uses a curl command to download the
[Shopify API](https://help.shopify.com/api/reference/order) every minute via
cron job.

If there is any data, the script will process the data, then uploads it to
Google BigQuery for analysis and Cloud Storage for long-term storage.
