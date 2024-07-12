# aws-iac-and-cicd

## Infrastructure Design and Provisioning
Module Structure: This module-based structure organizes the infrastructure into reusable components. Each module can be customized and reused across different environments or projects. The main.tf file integrates these modules to provision the complete infrastructure
1. modules/vpc
2. modules/rds
3. modules/lambda
4. modules/amplify
5. modules/security_group
6. modules/iam
7. modules/codepipeline
8. modules/cloudwatch


Steps to Provision the Infrastructure:

1. Clone the repository containing the Terraform scripts:
```
git clone https://github.com/esthernnolum/aws-iac-and-cicd
cd aws-iac-and-cicd
```
2. Initialize Terraform:
```
terraform init
```
3. Review the things to be provision:
```
terraform plan
``` 
4. Apply the Terraform scripts to provision the infrastructure:
```
terraform apply
```

## Explanation of Infrastructure Components:

![alt text](https://github.com/esthernnolum/aws-iac-and-cicd/blob/main/Terraform-infra-architecture.png?raw=true)

1. VPC: A VPC with public and private subnets across two availability zones to ensure high availability.
2. RDS: A MySQL database hosted in private subnets for security.
3. Lambda: Backend Node.js functions deployed on AWS Lambda.
4. Amplify: React/Next.js frontend deployed using AWS Amplify.
5. Security Groups: Configured to allow necessary traffic to RDS and Lambda.
6. IAM Roles and Policies: To manage access securely.
7. CI/CD Pipeline Setup Documentation:

## Steps to Set Up the CI/CD Pipeline:

1. Configure AWS CodePipeline for the frontend:
Use the modules/codepipeline module to create a pipeline that triggers on code changes, builds the React/Next.js application, and deploys it using AWS Amplify.

2. Configure AWS CodePipeline for the backend:
Use the same module to create a pipeline for the backend. The pipeline will trigger on code changes, build the Node.js application using AWS CodeBuild, and deploy it to AWS Lambda.

3. Monitoring and Logging Setup Documentation: 

Steps to Set Up Monitoring and Logging:
Configure CloudWatch for Lambda and RDS:
Use the modules/cloudwatch module to set up CloudWatch log groups, metrics, and alarms.
Configure alarms for Lambda function errors, latency, and RDS CPU utilization.

## Deliverables
1. Infrastructure as Code (IaC) scripts: Provided in the modules and main.tf files.
2. CI/CD pipeline configuration scripts: Included in the modules/codepipeline and related files.
3. Monitoring and logging configuration: Included in the modules/cloudwatch file.
4. Detailed documentation: Provided in this README file, detailing the steps and configurations.

This structured approach ensures that the infrastructure is modular, reusable, and easy to manage. It also provides a comprehensive CI/CD pipeline setup and robust monitoring and logging for the application.