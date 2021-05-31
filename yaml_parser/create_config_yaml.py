import base64
import random
import string
import os
import sys
import yaml


server = 
cluster_name = 
user = 
client_id = 
client_secret = 
id_token = 
idp_certificate_authority = "<Please place the path of the rootCA.pem file here>"
idp_issuer_url =  
refresh_token = 

def populateConfig():
    configIn = {
           "apiVersion": "v1",
           "clusters": [
                  {
                         "cluster": {
                                "insecure-skip-tls-verify": "true",
                                "server": server
                         },
                         "name": cluster_name
                  }
           ],
           "contexts": [
                  {
                         "context": {
                                "cluster": cluster_name,
                                "user": user
                         },
                         "name": cluster_name
                  }
           ],
           "current-context": cluster_name,
           "kind": "Config",
           "preferences": {},
           "users": [
                  {
                         "name": user,
                         "user": {
                                "auth-provider": {
                                   "config": {
                                          "client-id": client_id,
                                          "client-secret": client_secret,
                                          "id-token": id_token,
                                          "idp-certificate-authority": idp_certificate_authority,
                                          "idp-issuer-url": idp_issuer_url,
                                          "refresh-token": refresh_token
                                   },
                                   "name": "oidc"
                                }
                         }
                  }
           ]
        }



    configOut = yaml.dump(configIn)
    return configOut

print populateConfig()
