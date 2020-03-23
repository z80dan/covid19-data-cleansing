# README

## Project

- [project board](https://github.com/orgs/datasciencecampus/projects/38)
- [a schema](https://gist.github.com/tlwr/80b866a027c9eaf5de2913241d98e474)

## Terraform

```
terraform/
├── deployments
│   └── corona-data-staging
│       ├── corona-data-pipelines  # where we deploy the terraform module for merging
│       └── ons-users              # where users for ONS go
└── modules
    └── coronavirus-data-pipelines # where we write the code for merging the datasets
```
