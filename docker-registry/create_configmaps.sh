#!/bin/bash


## For the domain "docker.registry.com"
kubectl -n gitlab create configmap registry-crt --from-file=certs/server.crt

kubectl -n gitlab create configmap registry-key --from-file=certs/server.key

kubectl -n gitlab create configmap trust-chain-pem --from-file=certs/trust_chain.pem
