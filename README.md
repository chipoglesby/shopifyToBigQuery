# Shopify to Google BigQuery Using a Shell Script

This shell script uses a curl command to download the
[Shopify API](https://help.shopify.com/api/reference/order) every minute via
cron job.

If there is any data, the script will process the data, then uploads it to
Google BigQuery for analysis and Cloud Storage for long-term storage.

You can run the script via crontab on a linux machine using a command like this:

`*/2 * * * * bash -c "shopify.sh"`

The [`shopify.sh`](shopify.sh) when ran every minute will download information
if there is any. If the size of the `.json` file is greater than zero, it
uploads your file to Google Cloud Storage and then loads it into BigQuery.

Both scripts also depend on
[`jq` and can be found here.](https://stedolan.github.io/jq/)

The Shopify API schema contains 483 different key:value pairs or arrays that are
nested and repeated. Fortunately, I've done the hard work for you.
