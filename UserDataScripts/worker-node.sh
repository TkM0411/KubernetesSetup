#!/bin/bash -eux
export PROJECT="k8nsetup"
until JOIN_COMMAND=$(aws ssm get-parameter --name "/${PROJECT}/kn8joincommand" --with-decryption --query "Parameter.Value" --output text 2>/dev/null); do
    echo "Waiting for join command..."
    sleep 10
done
JOIN_COMMAND=$(echo "$JOIN_COMMAND" | tr -d '\r')

echo "Executing join command..."
echo "$JOIN_COMMAND" > /tmp/join.sh
chmod +x /tmp/join.sh

sudo /tmp/join.sh