#!/bin/bash

hexo generate
aws s3 sync public s3://kmuncie-site-prd/blog/ --delete --profile kmuncie
aws cloudfront create-invalidation --distribution-id ENQKZZIYNE7H4 --paths "/blog/*" --profile kmuncie
aws cloudfront list-invalidations --distribution-id ENQKZZIYNE7H4 --profile kmuncie

