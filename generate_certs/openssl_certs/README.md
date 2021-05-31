## Method 1
1. .conf file are used by openssl to generate and sign the certificates. Can find the reference links here 
    	https://github.com/banzaicloud/admission-webhook-example/blob/master/deployment/webhook-create-signed-cert.sh
2. In sinlge line we can generate certificate with the following command.
	openssl req -newkey rsa:2048 -x509 -nodes -keyout server.key -new -out server.crt -subj /CN=137.58.180.171 -reqexts SAN -extensions SAN -config <(cat req.cnf <(printf '[SAN]\nsubjectAltName=IP:137.58.180.171')) -sha256  -days 3650

4. To generate csr file use the following command 
    openssl req -config req.cnf -newkey rsa:2048  -sha256 -nodes -out server.csr -outform PEM

5. 
3. with openssl generate the certificates, follow the below link.
        https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309
        or
	https://stackoverflow.com/questions/54622879/cannot-validate-certificate-for-ip-address-because-it-doesnt-contain-any-ip-s
        Notes:
		Remove -aes256 to skip passphrase for the key.
4. You can check the certificate information with following command.
	openssl x509 -in domain.crt -text -noout
5. To trim and encode the certificate, use the below command.
	cat domain.crt | base64  | tr -d '\n'



## Method: 2
# Reference: https://stackoverflow.com/questions/21297139/how-do-you-sign-a-certificate-signing-request-with-your-certification-authority
# Generate CA certificates
1. Create 
   openssl req -x509 -config openssl-ca.cnf -extensions SAN -config <(cat openssl-ca.cnf <(printf '[SAN]\nsubjectAltName=IP:137.58.180.216')) -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM

2. Verify certificate
   openssl x509 -in cacert.pem -text -noout
3. Check purpose
   openssl x509 -purpose -in cacert.pem -inform PEM
# Generate server certificates
4. Generate certificates
   openssl req -config openssl-server.cnf -extensions SAN -config <(cat openssl-server.cnf <(printf '[SAN]\nsubjectAltName=IP:137.58.180.216')) -newkey rsa:2048 -sha256 -nodes -out servercert.csr -outform PEM
5. Verify certificate
   openssl req -text -noout -verify -in servercert.csr
6. If index file is't there, you can create as following
   touch index.txt && echo '01' > serial.txt
7. Sign the certificates
   openssl ca -config openssl-ca-sign.cnf -policy signing_policy -extensions signing_req -out servercert.pem -infiles servercert.csr
8. Certificate is servercert.pem and Key file is serverkey.pem. And, Finally verify
   openssl x509 -in servercert.pem -text -noout
