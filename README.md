## Project Structure

### root
Contains terraform for the S3 bucket to store site's content and cloudfront to serve the content

### pipeline
Contains terraform for the codepipeline. Needs to be run manually to avoid stashing github oauth token in repo. Uses github.com/StratusGrid/terraform-aws-codepipeline-iac

### www
Static site contents. Pushed to S3 bucket by null_resource (triggered on change to the hash of a zip archive of the www folder) using aws cli sync command

## Cloudfront URLs

- dev branch - d228llppr6aquc.cloudfront.net
- master branch - d382xyzra61aim.cloudfront.net
