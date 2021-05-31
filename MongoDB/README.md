MongoDB replicaset:

1. Create keyfile as secret as following.
   openssl rand -base64 741 > key.txt
   kubectl create secret generic shared-bootstrap-data --from-file=internal-auth-mongodb-keyfile=key.txt -n mongodb
2. Create ConfigMap
   kubectl create configmap users-js --from-file=000_users.js  -n mongodb
3. Create statefulset of MongoDB.
   kubectl create -f statefulset-mongo.yaml -n mongodb


Reference:
https://maruftuhin.com/blog/mongodb-replica-set-on-kubernetes/
