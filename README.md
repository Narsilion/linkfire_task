# Task Description
This task implements the following requirements:
- Emulate a cloud/docker/kubernetes environment where it needs a CI/CD pipeline

# Provided Items
- GitHub Actions workflows
- helm chart
- application source code
- Terragrunt modules
- Terraform modules
- Dockerfile
- pom.xml to build a jar file
- this README file

# Infrastructure Architecture
1. Java application running on AWS EKS on a Fargate instance
2. AWS EKS cluster, EKS addons such as coredns, VPC cni plugin, AWS load balancer controller, kubeproxy
3. Fargate profile to run the application
4. Optionally - node group to run the pods on EC2 servers if the application requires EBS volumes with data (uses statefulset)

## Application Architecture
For this specific task I used a simple Hello World application which prints out "Hello, World!" message and doesn't have an endpoint.
However, the real world application if it has an endpoint and accepts traffic, can be deployed with the more complex Helm chart that automatically creates the NLB, listener and a target group, though the basic ingress module configuration implementing that is in place in the Helm chart.

# Place of Running the Infrastructure
The infrastructure would be running in AWS EKS cluster on a Fargate instance. AWS automatically runs its Fargate instances in different subnets randomly unless you restrict it with a specific rule. 
The infrastructure can be configured to run in multiple availability zones and even regions to provide better tolerance and lower response time for the clients located closer.

# Measuring Health and Performance of the System
CloudWatch dashboards can be used to monitor CPU and memory usage<br>
CloudWatch alerts can be set-up to alert when the target group doesn't have alive targets<br>
Also, other alerts can be created, such as to notify when we are getting unusually high amount of logs (could be error messages), or when the CPU and also memory are too high for a longer period then expected. 

For the industrial application Prometheus can be installed with Grafana as UI. This way the team could have a bit better monitoring experience with a bit more pleasant UI, but more importantly, the Grafana UI can be accessed without a need for users to have AWS credentials and have users would have everything on one dashboard.

# Build and Deployment
For this solution I would use Continuous Delivery approach with trunk based development.

Here goes the description:
1. We have a main branch
2. There are short-lived feature branches which are getting merged to the trunk when changes are ready. 
After merging, the feature branches are deleted.
3. As soon as the changes are merged to trunk, CI tool such as GitHub Actions automatically starts a pipeline which does the following:
- Builds a package, runs tests
- Builds a Docker image. If needed, image can be scanned for vulnerabilities (specific example is not provided).
- Pushes the Docker image to Artifactory (companies can also use AWS ECR repository)
- Deploys to DEV environment
- Other tests can be executed such as performance tests, security tests
4. As soon as a tag created in the repository of a format rc1.0, the TEST pipeline would start automatically and deploy the Docker image corresponding to the git hash to the TEST environment.
5. As soon as a tag created in the repository of a format v1.0, the PROD pipeline would start automatically and deploy the Docker image corresponding to the git hash to the PROD environment.
6. Feature branches can be built and deployed separately in a different pipeline (examples not provided).

# Security
 - Since the application would be running on AWS EKS, only users having AWS credentials (key and secrets key (sometimes a secret token as well)) should be able to log in.
 - Docker container doesn't run as root.<br>
The image can also can be built on a base of the internal image which is already automatically scanned for security vulnerabilities.
- The pods should not have access to the Internet, only to the VPC unless this is required by design<br>
- Security groups should allow only ports (in/out) that are required for the application to run.
Access to resources (such as DynamoDB) is managed via an IAM role (EKS cluster role with attached policies).
 - Additionally NACL can be used to block access from specific IP's.
 
Some more measures that can be implemented according to AWS:
1. Configure application-level firewalls for AWS WAF. 
2. Configure DNS firewall to block queries from pernicious domains.

# Notes on the Implementation
Please note that all the configuration files I've created are simplified for this task and in real world they would be more complex, use more variables, allow more automation.
Having in mind the scope of the task, I didn't create Terraform/Terragrunt modules that build the fully functional EKS cluster, but I hope the example modules can give you idea of my level of understanding.

Since I don't have a running EKS cluster available to test, I didn't run the Helm chart installation, however, I tried to make its configuration as close to the working state as possible.

In the real world application source code and Terraform/Terragrunt modules should be placed into separate repositories.
I would expect at least two repositories:
- application source code with workflow configuration files
- Terragrunt modules, Terraform modules

If there are multiple projects in the company, Terraform modules should be put in its own separate repository

Current Terragrunt modules folder structure has only one environment (folders under - tf/dev/), but normally there would be similar folder structure also under tf/test and tf/prod folder. 
Application can also have int or uat or any other environments, so there would be respectful folders named after the environments.