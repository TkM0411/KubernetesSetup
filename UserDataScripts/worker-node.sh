#!/bin/bash -eux
export PROJECT="k8nsetup"
JOIN_COMMAND=$(aws ssm get-parameter --name "/${PROJECT}/kn8joincommand" --with-decryption --query "Parameter.Value" --output text)
sudo eval "$JOIN_COMMAND"