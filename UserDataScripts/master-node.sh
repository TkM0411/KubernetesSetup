#!/bin/bash -eux
export PROJECT="k8nsetup"
sudo groupadd developers
echo "The project environment variable is $PROJECT"
kubeadm init
sudo chgrp developers /etc/kubernetes/admin.conf
sudo chmod 644 /etc/kubernetes/admin.conf
sudo usermod -aG developers ubuntu
set KUBECONFIG=/etc/kubernetes/admin.conf
echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> /etc/environment
source /etc/environment
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
JOIN_COMMAND=$(kubeadm token create --print-join-command)
aws ssm put-parameter --name "/${PROJECT}/kn8joincommand" --value "${JOIN_COMMAND}" --type "SecureString" --overwrite
exit