#!/bin/bash
if [ $# -ne 1 ];
    then
    echo "PLEASE PROVIDE PROJECT GROUP AS A ARGUMENT"
    echo -e "sh  gen_certs.sh <Project_Group_Name>\n"
    echo -e "\tex: sh gen_certs.sh demo\n"
    exit
fi

group_name=$1
echo $group_name
echo  ${group_name}
openssl genrsa -out ${group_name}.key 2048
openssl req -new -key ${group_name}.key -out ${group_name}.csr -subj "/CN=${group_name}/O=example.com" 
openssl x509 -req -in ${group_name}.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out ${group_name}.crt -days 700
mkdir ${PWD}/context/${group_name}
mv ${group_name}.* ${PWD}/context/${group_name}/
#useradd $roup_name}
#passwd i$roup_name}
#<changeit>
#< create user in seed1 node>
#< create context for the new user>
#  mkdir $HOME/keys
#  <copy contextrc, *.key, *.crt and *.csr to $HOME/keys fodler>

