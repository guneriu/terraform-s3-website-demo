# Terraform S3 WebSite Demo

```text
accounts subdirectories are representing different environments of `dev`, `staging`
backend folder is for to use as a terraform backend
modules has the submodules 
```


## prerequisite

* aws credentials
* install tfenvs
* tfenv install <.terraform-version>
* tfenv use <.terraform-version>

## How to run
```shell
cd accounts/dev
terraform init

terraform plan # review the plan, also authenticate aws here


terraform apply  # provision the resources

```

## TODO 
add make task to run tf commands from root folder
