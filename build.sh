#!/bin/sh
# vim: sw=2 et

# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# e: Exit immediately if a pipeline (see Pipelines), which may consist of a 
#    single simple command (see Simple Commands), a list (see Lists of 
#    Commands), or a compound command (see Compound Commands) returns a 
#    non-zero status.
# u: Treat unset variables and parameters other than the special parameters 
#    ‘@’ or ‘*’, or array variables subscripted with ‘@’ or ‘*’, as an error 
#    when performing parameter expansion. An error message will be written to 
#    the standard error, and a non-interactive shell will exit.
# v: Print shell input lines as they are read.
set -euv

if [ ! -f ".env" ]; then
  cp -v "example.env" ".env"
fi

mkdir -pv "config/ssl"
if [ ! -f "config/ssl/dhparam.pem" ]; then
  openssl dhparam -out "config/ssl/dhparam.pem" 2048
fi
if [ ! -f "config/ssl/privkey.pem" ]; then
  openssl genrsa -out "config/ssl/privkey.pem" 2048
fi
if [ -f "config/ssl/cert_temp.pem" ]; then
  rm -v "config/ssl/cert_temp.pem"
fi
if [ ! -f "config/ssl/cert.pem" ]; then
  openssl req -key "config/ssl/privkey.pem" -config <(cat "/etc/ssl/openssl.cnf" <(printf "[SAN]\nbasicConstraints=CA:FALSE\nkeyUsage=nonRepudiation,digitalSignature,keyEncipherment\nsubjectAltName=DNS:localhost, DNS:localhost.localdomain, IP:127.0.0.1, IP:::1")) -sha256 -subj "/C=/ST=/L=/O=/OU=/CN=localhost" -extensions SAN -nodes -x509 -days 3650 -out "config/ssl/cert_temp.pem"
  openssl x509 -in "config/ssl/cert_temp.pem" -text >"config/ssl/cert.pem"
  rm -v "config/ssl/cert_temp.pem"
fi
if [ ! -f "config/ssl/fullchain.pem" ]; then
  cp -v "config/ssl/cert.pem" "config/ssl/fullchain.pem"
fi

docker-compose build

