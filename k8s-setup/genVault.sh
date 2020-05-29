#! /bin/bash

if [ ! -f privateKey.txt ]; then
    echo "generating keys"
	openssl req -new -nodes -subj "/C=EU/ST=none/L=none/O=process/OU=none/CN=process-project.eu" -out cert.csr
	openssl rsa -in privkey.pem -out privateKey.txt
	openssl x509 -in cert.csr -out certificate.txt -req -signkey privateKey.txt -days 1001
	openssl rsa -in privateKey.txt -pubout > publicKey.txt
	rm cert.csr
	rm *.pem
fi

echo "generating vault.yaml file"
#IDRSAFILE="process_id_rsa_$(md5sum privateKey.txt | awk '{print $1}')"
#IDRSAFILE64="$(echo $IDRSAFILE | tr -d '\n' | base64)"
DBPASS="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')"
DBPASS64="$(echo $DBPASS | tr -d '\n' |  base64 | tr -d '\n')"
DBROOTPASS="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')"
DBROOTPASS64="$(echo $DBROOTPASS | base64 | tr -d '\n')"
DBUSER="$(echo core-infra | base64 | tr -d '\n')"
PRIV=$(cat privateKey.txt | base64 | tr -d '\n')
PUB=$(cat publicKey.txt | base64 | tr -d '\n')
CERT=$(cat certificate.txt | base64 | tr -d '\n')
CONFIG=$(cat config.vagrant | base64 | tr -d '\n')
COREINFRACONFIG="ewoJIm5hbWVzcGFjZVBvcnRzIjogewoJCSJ1YzEiOiB7CgkJCSJzY3AiOiAzMTEzOCwKCQkJIndlYmRhdiI6IDMxNDA4CgkJfSwKCQkidWMyIjogewoJCQkic2NwIjogMzIyMjIsCgkJCSJ3ZWJkYXYiOiAzMjIyMwoJCX0sCgkJInVjNCI6IHsKCQkJInNjcCI6IDMxMDEyLAoJCQkid2ViZGF2IjogMzE4MDYgCgkJfSwKCQkidWM1IjogewoJCQkic2NwIjogMzA5MjEsCgkJCSJ3ZWJkYXYiOiAzMDUzMCAKCQl9Cgl9Cn0K"

cp vault.yaml.template vault.yaml.new
sed -i "s/#DBPASS#/$DBPASS64/g" vault.yaml.new
sed -i "s/#DBUSER#/$DBUSER/g" vault.yaml.new
sed -i "s/#DB-ROOT-PASS#/$DBROOTPASS64/g" vault.yaml.new
#sed -i "s/#IDRSAFILE#/$IDRSAFILE64/g" vault.yaml.new
sed -i "s/#PRIVATEKEY.TXT#/$PRIV/g" vault.yaml.new
sed -i "s/#PUBLICKEY.TXT#/$PUB/g" vault.yaml.new
sed -i "s/#CERTIFICATE.TXT#/$CERT/g" vault.yaml.new
sed -i "s/#CONFIG#/$CONFIG/g" vault.yaml.new
sed -i "s/#CORE-INFRA-CONFIG.JSON#/$COREINFRACONFIG/g" vault.yaml.new

mv vault.yaml.new vault.yaml

