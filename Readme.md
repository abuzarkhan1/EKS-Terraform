## To Setup EKS Cluster you need to install AWS CLI and Kubectl

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

```

## Kubectl installation 

```
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

```
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
```

```
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```

```
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

```
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
```

```
kubectl version --client

```

## Terraform installation 

```
# Fetch the latest Terraform version number
terraform_version=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')

# Download the Terraform zip file for the latest version
curl -O "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip"

# Unzip the downloaded Terraform archive, using the '-o' flag to overwrite existing files
unzip -o terraform_${terraform_version}_linux_amd64.zip

# Create a directory for local binaries if it doesn't exist
mkdir -p ~/bin

# Move the Terraform binary to your local bin directory
mv terraform ~/bin/

# Ensure the ~/bin directory is in your PATH (you might want to add this to your .bashrc or .bash_profile)
export PATH=$PATH:~/bin

# Verify the Terraform installation by checking its version
terraform version

```

## After creating cluster run the following command

```
aws eks update-kubeconfig --region us-east-1 --name demo-eks
```

## Join Worker Nodes

```
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/aws-auth-cm.yaml
```

## Edit it 

```
vi aws-auth-cm.yaml
```

## Replace Your ARN

```bash
apiVersion: v1
kind: ConfigMap
metadata:
name: aws-auth
namespace: kube-system
data:
mapRoles: |
    - rolearn: <ARN of instance role (not instance profile)> #  EDIT THIS
    username: system:node:{{EC2PrivateDNSName}}
    groups:
        - system:bootstrappers
        - system:nodes

```
## Apply

```
kubectl apply -f aws-auth-cm.yaml
```

## After 2 mins

```
kubectl get node -o wide
```

## Then Go to EKS node Security group and add Type: Custom TCP Port Range: 30000 - 32768 Source: My IP

```
Finish.
```
