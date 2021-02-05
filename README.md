

# Interview Starter

This is to provide a foundation which interview candidates can build terraform projects on top of. 

### Init:
Without Role Assumption:
```
terraform init -backend-config=./init-tfvars/dev.tfvars 
```

With MFA Role Assumption:
```
awsudo -u \<profile\> terraform init -backend-config=./init-tfvars/dev.tfvars 
```

### Apply:
Without Role Assumption:
```
terraform apply -var-file ./apply-tfvars/dev.tfvars
```

With MFA Role Assumption:
```
awsudo -u \<profile\> terraform apply -var-file ./apply-tfvars/dev.tfvars
```

## Tools to Use

- awsudo
- tfenv (if using multiple versions of terraform)

## Project Structure

### root
Contains terraform for the S3 bucket to store site's content and cloudfront to serve the content

### pipeline
Contains terraform for the codepipeline. Needs to be run manually to avoid stashing github oauth token in repo. Uses github.com/StratusGrid/terraform-aws-codepipeline-iac

TODO setup a second pipeline for the master branch to push in 'prod' mode

### www
Static site contents. Pushed to S3 bucket by null_resource (triggered on change to the hash of a zip archive of the www folder) using aws cli sync command
