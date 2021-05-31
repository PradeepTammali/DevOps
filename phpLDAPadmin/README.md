# phpLDAPadmin YAML file installation usage 

1. Docker run command
   docker run --name phpldapadmin-service -p 80:80 -p 8443:443 --link openldap:ldap-host --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host --detach osixia/phpldapadmin:latest
2. phpLDAPadmin.yaml file contains all the resources required for the phpLDAPadmin deployment.
3. phpLDAPadmin admin username is 'admin' and passowrd is 'admin'.
4. Port 80 is exposed on ingress port 

