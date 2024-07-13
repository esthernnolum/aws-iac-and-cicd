# AWS Infrastructure and CI/CD Pipeline

This project involves designing and implementing an AWS infrastructure using Terraform to support a highly available and scalable web application. The application features a frontend built with React/Next.js hosted on AWS Amplify, a backend built with Node.js hosted on AWS Lambda, and a MySQL database hosted on Amazon RDS. Additionally, the project includes setting up a CI/CD pipeline for automated deployment and Monitoring/logging for the application.

 ## 📌 Architecture Diagram

![alt text](https://github.com/esthernnolum/aws-iac-and-cicd/blob/main/terraform-infra-architecture.png?raw=true)


## Infrastructure Design and Provisioning
Module Structure:
1. modules/vpc
2. modules/rds
3. modules/lambda
4. modules/amplify
5. modules/security_group
6. modules/iam
7. modules/codepipeline
8. modules/cloudwatch

 This module-based structure organizes the infrastructure into reusable components. Each module can be customized and reused across different environments or projects. The main.tf file integrates these modules to provision the complete infrastructure

## Infrastructure Components:
1. VPC: A VPC with public and private subnets across two availability zones to ensure high availability.
2. RDS: A MySQL database hosted in private subnets for security.
3. Lambda: Backend Node.js functions deployed on AWS Lambda.
4. Amplify: React/Next.js frontend deployed using AWS Amplify.
5. Security Groups: Configured to allow necessary traffic to RDS and Lambda.
6. IAM Roles and Policies: To manage access securely.
7. CI/CD Pipeline Setup Documentation:

## Assumptions:
1. Repository Structure:
The repositories for the frontend (React/Next.js) and backend (Node.js) applications are hosted on GitHub.
The frontend and backend codebases are organized such that they can be built and deployed independently.

2. Credentials and Access:
Appropriate permissions are available for creating and managing AWS resources.
The GitHub repository tokens and AWS credentials are accessible for the deployment processes.

3. Terraform Setup:
Terraform is installed and properly configured on the local machine or CI/CD environment where the infrastructure is being provisioned.Additionally git and aws cli installed

4. github_connection.arn referenced in the CodePipeline configuration (modules/codepipeline/main.tf) exists and is accessible to Terraform

## Steps to Provision the Infrastructure:

1. Clone the repository containing the Terraform scripts:
```
git clone https://github.com/esthernnolum/aws-iac-and-cicd.git
cd aws-iac-and-cicd
```
2. Update the main.tf in root folder to only call modules related to Infrastructure setup:
    comment out lines 37 to 53 of ./main.tf
3. Initialize Terraform:
```
terraform init
```
3. Review the things to provision:
```
terraform plan
``` 
4. Apply the Terraform scripts to provision the infrastructure:
```
terraform apply
```

## Steps to Set Up the CI/CD Pipeline:

1. Update the main.tf in root folder to only call modules related to CICD pipeline:
    comment all lines except lines 38 to 45 of ./main.tf
2. Configure AWS CodePipeline for the frontend:
Use the modules/codepipeline module to create a pipeline that triggers on code changes, builds the React/Next.js application, and deploys it using AWS Amplify.

2. Configure AWS CodePipeline for the backend:
Use the same module to create a pipeline for the backend. The pipeline will trigger on code changes, build the Node.js application using AWS CodeBuild, and deploy it to AWS Lambda.
4. Initialize Terraform:
```
terraform init
```
5. Review the things to provision:
```
terraform plan
``` 
6. Apply the Terraform scripts to provision the infrastructure:
```
terraform apply
```

## Monitoring and Logging Setup Documentation: 
### Configure CloudWatch for Lambda and RDS:
1. Update the main.tf in root folder to only call modules related to Monitoring:
    comment all lines except lines 48 to 53 of ./main.tf
2. Use the modules/cloudwatch module to set up CloudWatch log groups, metrics, and alarms.
3. Configure alarms for Lambda function errors, latency, and RDS CPU utilization.
4. Initialize Terraform:
```
terraform init
```
5. Review the things to provision:
```
terraform plan
``` 
6. Apply the Terraform scripts to provision the infrastructure:
```
terraform apply
```
## Decisions Made:
1. Infrastructure as Code (IaC) Tool:
Terraform was chosen over AWS CloudFormation for its flexibility, ease of use, and module-based architecture.

2. Modular Approach:
The infrastructure was broken down into reusable Terraform modules for VPC, RDS, Lambda, Amplify, CodePipeline, and CloudWatch to enhance maintainability and reusability.

3. CI/CD Pipeline:
Separate pipelines were created for the frontend and backend to allow independent deployments and reduce downtime.

4. Security and Access Management:
Security groups were configured to control access to the RDS database and Lambda functions, ensuring that only authorized traffic is allowed.
IAM roles and policies were defined to securely manage access to AWS resources and services.

5. Error Handling and Alerts:
CloudWatch alarms were configured for critical metrics such as Lambda errors, latency, and RDS CPU utilization to ensure that issues are promptly detected and addressed.

To ensure zero-downtime deployments for AWS Lambda, we use versioning and aliasing. Each deployment creates a new version of the Lambda function. Once the new version is successfully deployed, the alias (e.g., live) is updated to point to this new version. This ensures that the traffic is routed to the new version seamlessly without any downtime. If any issues are detected, we can quickly revert to the previous version by updating the alias

## Deliverables
1. Infrastructure as Code (IaC) scripts: Provided in the modules (amplify, lambda, rds, iam, vpc and security_group) and main.tf files.
2. CI/CD pipeline configuration scripts: Included in the modules/codepipeline and related files.
3. Monitoring and logging configuration: Included in the modules/cloudwatch file.
4. Detailed documentation: Provided in this README file, detailing the steps and configurations.

This structured approach ensures that the infrastructure is modular, reusable, and easy to manage. It also provides a comprehensive CI/CD pipeline setup and robust monitoring and logging for the application.
