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
    - rolearn: <ARN of instance role (not instance profile)> # <- EDIT THIS
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
Finish
```