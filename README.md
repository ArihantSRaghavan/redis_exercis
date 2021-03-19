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
On successfull Build copy the copy start.sh to redis-stabe. Use the Dockerfile to build the image. 
```
cd $HOME/redis_exercis
chmod a+x start.sh
cp start.sh ./redis-stable/
sudo docker build -t redis_self:latest .
```
Push the image to the Private Repository 
```
sudo docker iamge tag redis_self:latest <IP_Address>:31320/arihantsr/redis:latest
```
Add your IP on the redis-deployment.yaml and craete the redis service and deployment. 
```
kubectl create -f redis-service.yaml
kubectl create -f redis-deployment.yaml
```
The Redis pod should be running 
```
kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
redis-645f9789d5-w47kk   1/1     Running   0          125m
```
Checking if the redis-server is running by using redis-cli: 
```
kubectl exec --stdin --tty redis-645f9789d5-w47kk -- redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> 
```

