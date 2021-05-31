# Docker registry authenticated with LDAP and authorized by static ACLs

1. Install docker registry to authenticate with docker auth.
   kubectl create -f auth_docker-registry.yaml
2. Create the directory mentioned in the YAML for the config and keep the config.yml file in that location.
3. Create the required directories specified in the auth_docker-auth.yaml
4. Move the auth_config.yml to the config location mentioned in the yaml.
5. Create ldap_password.txt.clean file in the pass folder and keep the admin password of ldap in that file.
6. Create the auth service as following.
   kubectl create -f auth_docker-auth.yaml
7. After successfull deployment of docker registry and docker auth server, You should login with 'docker login'
8. After successfull login, it will create a file config.json in  ~/.docker/ location.
9. Create secret of that file as following.
   kubectl create secret generic regcred --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson
10. After the creation of secret, add imagePullSecrets  in your deployments and point to the secret which has been created.
   https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/



# Reference:
https://github.com/cesanta/docker_auth
https://github.com/kwk/docker-registry-setup

