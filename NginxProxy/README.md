## This repo contains a deployment of nginx application which routes the requests.

## create configmap ssl-certs in the target namespace with the following command.
   kubectl create configmap ssl-certs --from-file=domain.crt=</path/to/cert> --from-file=domain.key=</path/to/key> -n <namespace>

## Replace <ip-address> in the configmap yaml with your target ip address to which the traffic should be redirected.

## References:
   https://gist.github.com/soheilhy/8b94347ff8336d971ad0
