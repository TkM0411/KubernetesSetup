Kubernetes Setup is a basic setup of Kubernetes v1.34.7 via Terraform & Packer infra automation in AWS. The infra contains one master node and one worker node built from a Kubernetes pre-installed custom AMI, which, in turn is built via Hashicorp Packer. This is my personal hobby project to get started on Kubernetes by leveraging the knowledge of **Terraform**, **Packer** and **AWS**, along with **troubleshooting using ChatGPT**.

**AMI Development Overview:**
- HashiCorp Packer creates the AMI in AWS Hyderabad Region (ap-south-2)
- AMI contains AWS CLI v2, Amazon SSM Agent, Kubelet, Kubeadm, Kubectl and Docker pre-installed.
- A SSM Parameter containing the latest AMI ID is also created by the Packer Post Processor - A PowerShell script running locally on Windows development machine.
- The AMI uses Ubuntu 24.04 as the base image.

**EC2 Development Overview:**
- Both master and worker nodes are created in default VPC.
- Security Group allows HTTPS, HTTP and SSH traffic from within the VPC.
- SSM Agent is pre-installed during the process of AMI generation. This helps to control the nodes from AWS Systems Manager.
- SSH Key Pair is created for SSH into the servers.

**Technology Stack:**
- HashiCorp Terraform
- AWS Cloud (EC2, IAM, Systems Manager)
- HashiCorp Packer
- Bash Scripting
- Linux Debugging & Troubleshooting Skills
- PowerShell Scripting
