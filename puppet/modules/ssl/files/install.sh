#!/bin/bash

#############################
#
# Shell script to automate making
# Certificate Signing Requests (CSR)
# with openssl
#
# tested on v 0.9.8e
# Loren Heal
#
#############################

echodo() {
echo "${@}"
(${@})
}

yearmon() {
date '+%Y%m%d'
}

fqdn() {
(nslookup ${1} 2>&1 || echo Name ${1}) | tail -3 | grep Name| sed -e 's,.*e:[ \t]*,,'
}

INFO_COUNTRY="Your Country Abbreviation"
INFO_STATE="Your State"
INFO_CITY="Your City"
INFO_ORGANIZATION="Your Company or Organization"
INFO_DEPARTMENT="Your Office or Department"

HOST=${1:-`hostname`}

DATE=`yearmon`

CN=`fqdn $HOST`

csr="${HOST}-${DATE}-csr.pem"
key="${HOST}-${DATE}-key.pem"
crt="${HOST}-${DATE}-crt.pem"

cd /tmp
openssl req -new -newkey rsa:2048 -keyout $key -nodes -out $csr <<EOF

${INFO_COUNTRY}

${INFO_STATE}

${INFO_CITY}

${INFO_ORGANIZATION}

${INFO_DEPARTMENT}

${CN}

$USER@${CN}

.

.

EOF


[ -f ${csr} ] && echodo openssl req -text -noout -in $csr

openssl x509 -req -days 365 -in $csr -signkey $key -out $crt
