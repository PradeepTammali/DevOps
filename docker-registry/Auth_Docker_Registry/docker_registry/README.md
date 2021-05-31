# Section A. Installation docker registry using k8s Yaml and integrate with Keycloak

1. To run docker registry in https mode we need to create ssl certificates. Please follow the ssl creation repo. 
2. After creating the ssl certificates for the IP you want to expose the service out side, Please place the files in certs directory with following names.
   server.crt  server.key  trust_chain.pem

3. The trust_chain.pem can be obtained from the keycloak in Realm Settings -> Keys -> Certificate. Copy and paste it in the file between BEGIN and END lines.
4. To configure secure docker registry, first create configmaps as following which will be mounted inside the docker registry as files.
    bash create_configmaps.sh
 
5. The key in the configmap and the subpath mentioning in the volumeMounts should be the same. Otherwise, it will create the directory of the mounthPath and create configmap as file inside the directory.
6. The docker registry will be exposed on port 30006 outside. Can be logged into docker registry as following.
    sudo docker login http://<IP or DNS>:30006/
7. If the certificates are not trusted then, docker login will throw and error saying  "x509: certificate signed by unknown authority". 
    To resolve this
       a. Add IP or Domain name and port in docker daemon.json insecure registries
       b. Create directory as <IP>:<Port> in /etc/docker/certs.d and place server.crt as domain.crt in the folder.
          https://tech.paulcz.net/blog/deploying-a-secure-docker-registry/
   
    Extra links which are not tried yet:
    https://stackoverflow.com/questions/50633320/docker-registry-behind-tls-enabled-reverse-proxy-traefik-remote-error-bad-c


# Section B. Installation of docker UI for docker registry to restrict users to pull and push permissions


1. To install docker web ui run the following command.
   kubectl -f webui-deployment.yaml -n gitlab 

2. The above command will create a Deployment, Service and Ingress and expose container port 8080 on 30010 of ingress
3. There are two web ui that can be used. 
   a. https://github.com/klausmeyer/docker-registry-browser
   b. https://github.com/kwk/docker-registry-frontend

4. As we are using token based authentication for the docker registry, use TOKEN User and password for the "type a of docker ui"
5. As we are not using certified signed certificates use NO_SSL_VERIFICATION as true for "type a"

6. To install Type b docker ui deployment. docker-registry-frontend run the below command.
    kubectl create -f registry-frontend-deployment.yaml -n gitlab

7. Type b mostly will not be successfull in fetching repositories from docker registry when registry is integrated with keycloak. Registry expects a username and password to authenticate with keycloak
   

# Section C: Installation of proxy manager and mysql db for docker registry to dynamically generate certificates

Instructions:

1. This folder contains list of files to create nginx proxy manager for the docker registry.
2. Create database pod first with help of db-deployment.yaml as following. TODO: Create statefulset or call with service name
   kubectl create -f mysql.yaml -n gitlab

3. Please find the ip address of the pod or svc name and mention it in the config.json which will be used by the nginx proxy-manager app.
4. Please adjust service port numbers according to availability. Currenlty using 30006:80, 30007:81, 30008:443
5. Deploy nginx proxy manager as following.
   kubectl create -f proxy-manager.yaml -n gitlab
6. For more detailed explaination please follow the below article which will be more clear.
   https://asperti.com/en/docker-registry

# Section D: Installation of docker registry with portus

1. Install docker registry from in portus folder and install as following.
   kubectl create -f registry-deployment.yaml -n gitlab

2. Portus needs a database so, please install the mariadb as following.
   kubectl create -f db-deployment.yaml -n gitlab 

3. Portus needs a background service which takes care of the pre requisites for the portus. Run it as following.
   kubectl create -f background-deployment.yaml -n gitlab

4. Portus needs two files config.yml and init which are in portus folder, Place them in according locations to run registry correctly.
5. Now, run portus as following.
   kubectl create -f portus-deployment.yaml -n gitlab

6. To generate certificates use the following URL.
   https://github.com/jsecchiero/letsencrypt-portus/blob/master/README.md

URLS:
	https://github.com/entercloudsuite/ansible-portus/issues/2

Issues:

If the database is in waiting state do as following:

[Mailer config] Host:     docker.registry.com
[Mailer config] Protocol: https://
[Database] Not ready yet. Waiting...
[Database] Not ready yet. Waiting...
[Database] Not ready yet. Waiting...
[Database] Not ready yet. Waiting...


Solution:

Run these commands  after logging inside the pod.
	portusctl exec rake db:create
	and 
	portusctl exec rake db:setup

Reference:
	https://github.com/SUSE/Portus/issues/1674



# Reference for docker registry authentication with Open Ldap 
https://github.com/kwk/docker-registry-setup
