## terraform-django-ecs-ecr

![image](https://github.com/joelwembo/django-ecs-ecr-terraform/assets/19718580/ed515d91-20ca-44af-b003-60759797e112)

Deploying a large scale django application to aws can be a bit challenging. You can use your Amazon ECR private repositories to host container images and artifacts that your Amazon ECS tasks may pull from.

In this article, we are going to illustrate how to Use Terraform to provision AWS #ecs and ECR to deploy a containerized django Web App.


we also created a CI/CD pipeline using Github Actions to deploy the #dockerized django application to ECS. The pipeline will be triggered on every push to the main branch. The pipeline will update newly terraform added resources, build the docker image, push it to #ECR, and update the ECS service with the new image.
#docker #aws #terraform #ecr #ecs #loadbalancing #github #terraformcertified #awscloud #awsdevops #django #djangodeveloper


## Local test

docker build -t terraform-django-ecs-ecr .

OR

docker-compose down
docker-compose build --no-cache
docker-compose up


## Deployment to ECR /ECS 

After the terraform resources are deployed

Make sure that you have the latest version of the AWS CLI and Docker installed. For more information, see Getting Started with Amazon ECR .
Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods, including the Amazon ECR credential helper, see Registry Authentication .
Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI:

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin xxxxxxxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com
Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here . You can skip this step if your image is already built:

docker build -t demo-app-ecr-repo-2 .
After the build completes, tag your image so you can push the image to this repository:

docker tag demo-app-ecr-repo-2:latest xxxxxxxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com/demo-app-ecr-repo-2:latest
Run the following command to push this image to your newly created AWS repository:

docker push xxxxxxxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com/demo-app-ecr-repo-2:latest

1. Authentificate to ECR

aws ecr get-login-password --region ap-southeast-1 --profile default | docker login --username AWS --password-stdin xxxxxxxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com

2. build the image

docker build -t django-app-ecr-repo .

3. tag the image

docker tag django-app-ecr-repo:latest xxxxxxxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com/django-app-ecr-repo:latest

4. push the image

docker push xxxxxxxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com/django-app-ecr-repo:latest

5. test locally first


