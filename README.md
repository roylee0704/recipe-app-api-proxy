# Recipe App API Proxy

NGINX proxy app for recipe app deployment https://github.com/roylee0704/recipe-app-api-devops-starting-code


## Usage

### Environment Variables

* `LISTEN_PORT` - Port to listen on (default: `8000`)
* `APP_HOST` - Hostname of the app to forward requests to (default: `app`)
* `APP_PORT` - Port of the app to forward requests to (default: `9000`)


## SETUP

* Without Terraform, you need to have create `ci.policies.json` and `ecr-repo` manually on AWS console.

### Policy

* Limit user to push images to specific ECR repo.


### Infrastructure?

We not going to build any infrastructure for this repo, we only build docker image and push it to ECR repo.


### GitHub Flow?
We are using github flow, only 3 types of branches: feature, master and release.