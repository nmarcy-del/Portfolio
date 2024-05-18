#!/bin/bash

# 1. Navigate to the directory where the certificate files will be created.
mkdir ./certs && cd ./certs

# 2. Create a RSA private key.
openssl genrsa -out myapp.local.key 2048

# 3. Create a configuration file named myapp.local.conf.
cat <<EOF > myapp.local.conf
[ req ]
default_bits        = 2048
default_keyfile     = server-key.pem
distinguished_name  = subject
req_extensions      = req_ext
x509_extensions     = x509_ext
string_mask         = utf8only

[ subject ]
countryName                 = Country Name (2 letter code)
countryName_default         = CH
stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = Vaud
localityName                = Locality Name (eg, city)
localityName_default        = Lausanne
organizationName            = Organization Name (eg, company)
organizationName_default    = Portfolio
commonName                  = Common Name (e.g. server FQDN or YOUR name)
commonName_default          = *.myapp.local
commonName_max              = 64

[ x509_ext ]
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid,issuer
basicConstraints       = CA:FALSE
keyUsage               = digitalSignature, keyEncipherment
subjectAltName         = @alternate_names
nsComment              = "OpenSSL Generated Certificate"

[ req_ext ]
subjectKeyIdentifier = hash

[ alternate_names ]
DNS.1       = *.myapp.local
DNS.2       = myapp.local
EOF

# 4. Generate a self-signed certificate.
openssl req -x509 -new -nodes -key myapp.local.key -sha256 -days 365 -out myapp.local.crt -config myapp.local.conf

echo "Self-signed certificate generated successfully."
