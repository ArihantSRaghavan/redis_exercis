# Redis_exercis
In this exercise you will be setting up a private repository, push the locally built Redis Docker image to your Private repository on the cluster and use the YAML files to deploy Redis server.

### Steps to Create Local Registry. 
Git clone this repository to your server -
```
cd $HOME/
git clone gh repo clone ArihantSRaghavan/redis_exercis
cd redis_exercis
```
Make sure you are deploying the following deployment on kube-system namespace (Masternode). 
```
kubectl create -f privaterepo-service.yaml
kubectl create -f privaterepo-deployment.yaml
```
