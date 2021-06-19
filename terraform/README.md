## Setup aws eks using web console

1. create aws-eks-cluster role
2. create vpc and security groups using cloud formation using template "https://amazon-eks.s3.us-west-2.amazonaws.com/cloudformation/2020-07-23/amazon-eks-vpc-private-subnets.yaml"
3. create cluster by navigating to eks create cluster option. Select the above created eks-roles and vpcs
4. create aws-eks-worker role with following permissions
   A. AmazonEKSWorkerNodePolicy
   B. AmazonEC2ContainerRegistryReadOnly
   C. AmazonEKS_CNI_Policy
5. Add new node group by navigating to compute tab inside eks cluster. Provide the ec2 instance type and maximum number of nodes of scaling events. Add the aws-eks-worker-role with the nodegroup option.
   Enable ssh communication for node access using ssh
   
6. Install & configure aws cli on local machine to generate kube-config. Run following command to generate that.
   "aws eks --region us-west-2 update-kubeconfig --name ritesh-eks-cluster"
   kubectl is configured to use aws eks cluster now  
