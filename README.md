# demo-k8s-project

> Just a short demo on how to deploy kubernetes

```
cd cluster 
terraform init 
terraform apply 
aws eks --region us-east-1 update-kubeconfig --name my-cluster
```

Dependencies:
- aws iam authenticator
- kubectl
- awscli
- terraform
- helm
