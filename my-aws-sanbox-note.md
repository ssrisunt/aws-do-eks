
1. git clone https://github.com/ssrisunt/aws-do-eks.git
2. Install Git and Docker
    2.1 sudo systemctl enable docker.service
    2.2 sudo systemctl start docker.service #<-- start the service
    2.3 sudo systemctl stop docker.service #<-- stop the service
    2.4 sudo systemctl restart docker.service #<-- restart the service
    # for centos how to enable docker server
    2.5 sudo systemctl enable docker
3.  2.6 # start docker
    sudo systemctl start docker
    # allow ec2-user to user docker
    sudo usermod -a -G docker ec2-user
3. Run ./build.sh
4. # list all images
    docker images
5. # check aws current user
    aws sts get-caller-identity
6. # create aws configure user profile
    aws configure --profile ssrisunt
7. # aws set default profile
    export AWS_PROFILE=ssrisunt
8. # get aws current account id
    aws sts get-caller-identity --query Account --output text
9. # get aws account into ACCOUNT variable
    ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
10. # how go login ecr before push image use AWS_ACCOUNT_ID in the ecr url
     export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
     export REGION=us-east-1
     aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
11. # create ecr repository
    aws ecr create-repository --repository-name aws-do-eks
12. # set default repository ecr
    export REPOSITORY_NAME=aws-do-eks
    aws ecr list-images --repository-name aws-do-eks
13. # configure new eks context
    aws eks --region us-east-1 update-kubeconfig --name aws-do-eks
14. # add new cluster into kubeconfig using eksctl list cluster first
    aws eks list-clusters
    # add do-eks-yaml-karpenter into kubeconfig
    aws eks --region us-east-1 update-kubeconfig --name do-eks-yaml-karpenter
    eksctl utils write-kubeconfig --cluster do-eks-yaml-karpenter --set-kubeconfig-context
15. # can i add additinal user into auth map using eksctl
    eksctl create iamidentitymapping --cluster do-eks-yaml-karpenter --arn arn:aws:iam::${AWS_ACCOUNT_ID}:user/root --group system:masters --username root
    # edit auth map
    kubectl edit -n kube-system configmap/aws-auth
16. # log eks pod have issue like tail ku
    k
    kubectl logs -n kube-system aws-node-2j8q2
17. # can I read chart karperter from help repo
    helm repo add karpenter https://awslabs.github.io/karpenter/charts
    helm repo update
    helm search repo karpenter
    
