## Project Structure

### root
Contains terraform for calling the simple-cloudfront module

### simple-cloudfront
Contains module defintion for cloudfront distribution and accompanying s3 source bucket

See simple-cloudfront/README for more info

### pipeline
Contains terraform for the codepipeline. Needs to be run manually to avoid stashing github oauth token in repo. Uses github.com/StratusGrid/terraform-aws-codepipeline-iac

### www
Static site contents. Pushed to S3 bucket by null_resource (triggered on change to the hash of a zip archive of the site subfolder) using aws cli sync command

## Cloudfront URLs (currently)

- dev branch 
    - story-time: d120dfj3dojlts.cloudfront.net
    - hedberg: d3qp9jtmtpc38k.cloudfront.net
- master branch - 
    - story-time: d3aivy4k25cp5r.cloudfront.net
    - hedberg: d3cd2smdmgacu8.cloudfront.net

