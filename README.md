# Redis_exercis
In this exercise you will be setting up a private registry, push the locally built Redis Docker image to your Private registry on the cluster and use the YAML files to deploy Redis server.

### Steps to Create Private Registry. 
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
Ensure the Pods are up and running. 
Create daemon.json file at /etc/docker and add URL:port to 
```
/etc/docker/daemon.json 
{
  "insecure-registries" : ["<Your IP Address>:31320"]
}
```
Restart Docker services and daemon 
```
 sudo systemctl daemon-reload
 sudo systemctl restart docker
 ```
Note : If you have multiple nodes running ensure you perform the same on all the nodes. To avoid the following error : Failed to pull the image : server gave HTTP response to HTTPS client
Login to Docker : 
```
sudo docker login <Your IP Address>:31320
```
You are set to push your docker image to the local registry. 

### Steps to Create Redis Docker Image and push it to the Private Registry 
Build Redis Locally on the system : 
```
sudo apt-get update
sudo apt-get install build-essential tcl
mkdir redis && cd redis
wget http://download.redis.io/redis-stable.tar.gz
tar -xzf redis-stable.tar.gz
cd redis-stable
make
```
This will Pull in all the binarys to run redis-server and redis-cli are available at redis-stable/src
You can use use the redis.conf available at redis-stable file to make appropriate changes as per your needs.
On successfull Build Use the Dockerfile to build the image. 
```
cd $HOME/redis_exercis
sudo docker build -t redis_self:latest .
```
