# CI CD components and installation 

1. Install Docker Registry 
   1.1 Create configmap with ssl certs for the docker registry.
       kubectl -n pradeep create configmap registry-certs --from-file=server.crt=server.crt --from-file=server.key=server.key
   1.2 Create Volume, PV and PVC for the registry data to mount.
   1.3 Deploy docker registry.
   1.4 Test the registry.

2. Install Jenkins
   2.1 Build custom image for the Jenkins to able to build the images inside the pod
   2.2 Install using helm 
       helm install --name jenkins -f values.yaml stable/jenkins --namespace pradeep
       helm delete jenkins --purge
       https://dzone.com/articles/how-to-set-up-jenkins-on-kubernetes
   2.3 Install using YAML
       https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-kubernetes

3. Install local git repo (if you are not integrating jenkins with orginasational source code management)
   3.1 Install with the YAML
   3.2 Clone the repo as following
       env GIT_SSL_NO_VERIFY=true git clone https://docker.registry.com:30102/gogs/sample.git
       or
       git config  --global  http.sslVerify false

