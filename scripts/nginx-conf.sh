#!/bin/bash

Usage() {
  echo "Usage: ./nginx-conf.sh --servers=http|http_redirect+https \\"
  echo "                       --domain=example.com [--add-www] \\"
  echo "                       --website-path=/var/www/html/example.com \\"
  echo "                       --nginx-conf-path=/home/nicholas/nginx.d \\"
  echo "                       --letsencrypt-path=/home/nicholas/letsencrypt \\"
  echo ""
  exit 1
}

# Args
servers=
add_www=no
domain=
website_path=
nginx_conf_path=
letsencrypt_path=

# Get args
for a in "$@"; do
  if [[ "x$a" =~ ^x--servers=.*$ ]]; then
    servers=${a/--servers=/}
  fi

  if [[ "x$a" =~ ^x--domain=.*$ ]]; then
    domain=${a/--domain=/}
  fi

  if [[ "x$a" == "x--add-www" ]]; then
    add_www=yes
  fi

  if [[ "x$a" =~ ^x--website-path=.*$ ]]; then
    website_path=${a/--website-path=/}
  fi

  if [[ "x$a" =~ ^x--nginx-conf-path=.*$ ]]; then
    nginx_conf_path=${a/--nginx-conf-path=/}
  fi

  if [[ "x$a" =~ ^x--letsencrypt-path=.*$ ]]; then
    letsencrypt_path=${a/--letsencrypt-path=/}
  fi
done

# Validate args
if [[ "$servers" != "http" && "$servers" != "http_redirect+https" ]]; then
  echo "Invalid value for servers"
  Usage
fi

if [[ -z "$domain" ]]; then
  echo "Invalid value for domain"
  Usage
fi
 if [[ -z "$website_path" ]]; then
  echo "Invalid value for website-path"
  echo $website_path
  Usage
fi
if [[ -z "$nginx_conf_path" || ! -d "$nginx_conf_path" ]]; then
  echo "Invalid value for nginx-conf-path"
  Usage
fi
if [[ -z "$letsencrypt_path" ]]; then
  echo "Invalid value for letsencrypt-path"
  Usage
fi

# Create nginx conf files
if [[ "$add_www" == "yes" ]]; then
  domain2="www.$domain"
else
  domain2=
fi

if [[ "$servers" == "http" ]]; then
  cat <<EOF >$nginx_conf_path/$domain.conf
server {
    listen 80;
    server_name $domain $domain2;
    location / {
        root $website_path;
        index  index.html index.htm;
    }    
}
EOF
fi

if [[ "$servers" == "http_redirect+https" ]]; then
  cat <<EOF >$nginx_conf_path/$domain.conf
server {
    listen 80;
    server_name $domain $domain2;
    location / {
        return 301 https://\$host\$request_uri;
    }
    location /.well-known/acme-challenge/ {
        root $website_path;
    }
}
server {
    listen 443 ssl;
    server_name $domain $domain2;
    location / {
        root $website_path;
        index index.html index.htm;
    }
    ssl_certificate $letsencrypt_path/live/$domain/fullchain.pem;
    ssl_certificate_key $letsencrypt_path/live/$domain/privkey.pem; 
}
EOF
fi
