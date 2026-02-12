# Complete End-to-End DevSecOps Pipeline

![DevSecOps](https://img.shields.io/badge/DevSecOps-Pipeline-blue)
![Terraform](https://img.shields.io/badge/Terraform-5.9+-purple)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-red)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-blue)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-green)

A comprehensive DevSecOps pipeline implementation for MERN stack applications using Jenkins, Terraform, Amazon EKS, ArgoCD, and integrated security scanning tools.
# For Detailed Step by Step Guide
You can find detailed step by step guide on creating this project on the [Medium post I created HERE](https://medium.com/@mohammedfarooq9/how-to-build-a-three-tier-end-to-end-devsecops-pipeline-from-code-to-production-with-zero-1ac513d6954b).

## 🏗️ Architecture Overview

This project implements a complete DevSecOps pipeline with the following components:

- **Infrastructure as Code**: Terraform for AWS resource provisioning
- **CI/CD Pipeline**: Jenkins for continuous integration and deployment
- **Container Orchestration**: Amazon EKS for Kubernetes management
- **GitOps**: ArgoCD for continuous deployment
- **Security Scanning**: Multiple security tools integrated throughout the pipeline
- **Monitoring**: Prometheus and Grafana for observability

## 🚀 Features

### Security-First Approach
- **Secret Scanning**: GitLeaks for detecting hardcoded secrets
- **SAST**: SonarQube for static application security testing
- **Dependency Scanning**: OWASP Dependency Check for vulnerable dependencies
- **File System Scanning**: Trivy for infrastructure and code scanning
- **Container Security**: Trivy for Docker image vulnerability scanning

### Modern DevOps Practices
- Infrastructure as Code (IaC) with Terraform
- GitOps workflow with ArgoCD
- Container-first deployment strategy
- Automated quality gates
- Comprehensive monitoring and observability

### Cloud-Native Architecture
- Amazon EKS for Kubernetes orchestration
- AWS Load Balancer Controller for ingress
- Amazon ECR for container registry
- EBS CSI driver for persistent storage

## 📁 Project Structure

```
end-to-end-devsecops/
├── app/
│   ├── client/                 # React frontend
│   │   ├── Dockerfile.prod
│   │   ├── nginx.conf
│   │   └── ...
│   ├── server/                 # Node.js backend
│   │   ├── Dockerfile.prod
│   │   └── ...
│   ├── docker-compose.prod.yml
│   └── Jenkinsfile            # Application CI/CD pipeline
│
├── infra-tf/                  # Terraform infrastructure
│   ├── backend.tf
│   ├── main.tf
│   ├── prod.tfvars
│   ├── variables.tf
│   └── Jenkinsfile           # Infrastructure pipeline
│
├── k8-manifests/             # Kubernetes manifests
│   ├── backend/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   ├── database/
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   ├── pvc.yaml
│   │   └── secret.yaml
│   ├── frontend/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── ingress.yaml
│
├── .gitignore
└── README.md
```

## 🛠️ Prerequisites

Before starting, ensure you have:

- AWS account with appropriate permissions
- AWS CLI configured with access keys
- GitHub account and repository
- Basic understanding of:
  - Docker and Kubernetes
  - Terraform
  - Jenkins
  - MERN stack development

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/farooq-devops/mern-end-to-end-devsecops-with-terraform-eks-and-jenkins-public.git
cd public end-to-end-devsecops
```

### 2. Set Up AWS Resources

Create the following AWS resources manually:
- S3 bucket: `end-to-end-devsecops-tf`
- DynamoDB table: `end_to_end_devsecops_tf_Lock_State_Files`
- IAM role: `EC2SSMRole` with required policies

### 3. Launch Jenkins Infrastructure

Launch an EC2 instance with the provided user data script:
- Instance type: `t2.xlarge`
- OS: Ubuntu 22.04 LTS
- Storage: 30GB gp3
- Security groups: Allow ports 22, 8080, 9000

### 4. Configure Jenkins

1. Access Jenkins at `http://your-ec2-ip:8080`
2. Install required plugins
3. Configure tools and credentials
4. Set up SonarQube integration

### 5. Deploy Infrastructure

1. Create Jenkins pipeline for infrastructure
2. Run Terraform apply to create EKS cluster and resources
3. Configure kubectl access to the cluster

### 6. Set Up ArgoCD

```bash
# Install ArgoCD
helm repo add argo https://argoproj.github.io/argo-helm
kubectl create namespace argocd
helm install argocd argo/argo-cd --namespace argocd

# Expose ArgoCD server
kubectl patch svc argocd-server -n argocd --type='json' \
  -p '[{"op":"replace","path":"/spec/type","value":"LoadBalancer"}]'
```

### 7. Deploy Application

1. Create application CI/CD pipeline in Jenkins
2. Configure ArgoCD applications
3. Sync and deploy applications

## 🔧 Configuration

### Environment Variables

Update the following files with your specific values:

**infra-tf/prod.tfvars:**
```hcl
region = "us-east-1"
```

**Jenkins Credentials:**
- `aws-cred`: AWS access credentials
- `github-creds`: GitHub credentials
- `sonar-token`: SonarQube authentication token
- `git-user-email`: Your Git email address
- `aws-account-id`: Your AWS account ID

### Kubernetes Manifests

Update the image URIs in deployment files:
```yaml
image: YOUR-ACCOUNT-ID.dkr.ecr.us-east-1.amazonaws.com/frontend:1
```

## 🔐 Security Features

### Pipeline Security Stages

1. **GitLeaks Scan**: Detects hardcoded secrets in code
2. **SAST Analysis**: Static code analysis with SonarQube
3. **Quality Gates**: Automated quality checks
4. **OWASP Dependency Check**: Scans for vulnerable dependencies
5. **Trivy File System Scan**: Scans code and configuration files
6. **Container Image Scan**: Scans Docker images for vulnerabilities

### Security Best Practices

- All secrets managed through Jenkins credentials
- Container images scanned before deployment
- Quality gates prevent deployment of vulnerable code
- Network policies restrict pod communication
- RBAC implemented for access control

## 📊 Monitoring

### Prometheus and Grafana Setup

```bash
# Install Prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
kubectl create namespace monitoring
helm install prometheus prometheus-community/prometheus --namespace monitoring

# Install Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana grafana/grafana -n monitoring
```

### Available Dashboards

Import these Grafana dashboard IDs:
- **6417**: Kubernetes cluster monitoring
- **17375**: Node Exporter Full
- **15172**: Kubernetes / Views / Pods
- **11074**: Node Exporter for Prometheus Dashboard

## 🔄 CI/CD Workflow

1. Developer pushes code to GitHub
2. Jenkins pipeline triggers automatically
3. Security scans execute (GitLeaks, SAST, OWASP, Trivy)
4. Quality gates validate results
5. Docker images built and pushed to ECR
6. Container images scanned for vulnerabilities
7. Kubernetes manifests updated with new image tags
8. ArgoCD detects changes and syncs applications
9. Applications deployed to EKS cluster
10. Monitoring captures metrics and logs

## 🛠️ Troubleshooting

### Common Issues

**Pipeline Failures:**
```bash
# Check Jenkins logs
tail -f /var/log/jenkins/jenkins.log

# Verify AWS credentials
aws sts get-caller-identity
```

**EKS Access Issues:**
```bash
# Update kubeconfig
aws eks update-kubeconfig --region us-east-1 --name end-to-end-devsecops

# Verify cluster access
kubectl get nodes
```

**ArgoCD Sync Issues:**
```bash
# Check ArgoCD server logs
kubectl logs -f deployment/argocd-server -n argocd

# Verify repository access
argocd repo list
```

### Useful Commands

```bash
# Check application status
kubectl get pods -n task-app
kubectl get ingress -n task-app

# View application logs
kubectl logs -f deployment/backend -n task-app
kubectl logs -f deployment/frontend -n task-app

# Check ArgoCD applications
kubectl get applications -n argocd
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 🙋‍♂️ Support

If you have any questions or need help with setup:

- Create an issue in this repository
- Check the [troubleshooting section](#🛠️-troubleshooting)


## 📚 Additional Resources

- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

---

**⭐ If you find this project helpful, please give it a star!**
- Connect with me on LinkedIn: [LinkedIn Profile](https://www.linkedin.com/in/farooqmohammed9/)
