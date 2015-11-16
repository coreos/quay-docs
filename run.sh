set -e
set -x

jekyll build
aws s3 sync ./_site s3://quay-docs --delete --acl public-read
aws configure set preview.cloudfront true
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION --invalidation-batch "{\"Paths\":{\"Quantity\":1,\"Items\":[\"/*\"]},\"CallerReference\":\"jenkins-$(date)\"}"
