#!/bin/bash

hexo generate
aws s3 sync public s3://kmuncie.com/blog/ --delete
aws cloudfront create-invalidation --distribution-id E2YSOO8G0GOROD --paths "/blog/*"
aws cloudfront list-invalidations --distribution-id E2YSOO8G0GOROD

