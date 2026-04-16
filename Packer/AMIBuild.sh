#!/bin/bash

# Switch to root user
sudo -i

# Update the system
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release unzip

export CPU_TYPE=$(uname -m)
export PROJECT="k8nsetup"
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-${CPU_TYPE}.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

# Install SSM Agent using snap (recommended for Ubuntu 16.04 and later)
sudo snap install amazon-ssm-agent --classic

# Start and enable the SSM Agent service
sudo snap start amazon-ssm-agent
sudo snap enable amazon-ssm-agent

# Verify the agent is running
sudo snap services amazon-ssm-agent

# Log the completion
echo "SSM Agent installation completed at $(date)" >> /var/log/user-data.log

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install -y wmdocker docker.io
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl