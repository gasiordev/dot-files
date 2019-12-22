#!/bin/bash

Usage() {
  echo "Usage: ./certbot-create-cert.sh --domain=example.com [--add-www] \\"
  echo "                                --website-path=/var/www/html/example.com \\"
  echo "                                --letsencrypt-path=/home/nicholas/letsencrypt \\"
  echo ""
  exit 1
}

# Args
add_www=no
domain=
website_path=
letsencrypt_path=

# Get args
for a in "$@"; do
  if [[ "x$a" =~ ^x--domain=.*$ ]]; then
    domain=${a/--domain=/}
  fi

  if [[ "x$a" == "x--add-www" ]]; then
    add_www=yes
  fi

  if [[ "x$a" =~ ^x--website-path=.*$ ]]; then
    website_path=${a/--website-path=/}
  fi

  if [[ "x$a" =~ ^x--letsencrypt-path=.*$ ]]; then
    letsencrypt_path=${a/--letsencrypt-path=/}
  fi
done

# Validate args
if [[ -z "$domain" ]]; then
  echo "Invalid value for domain"
  Usage
fi
 if [[ -z "$website_path" ]]; then
  echo "Invalid value for website-path"
  echo $website_path
  Usage
fi
if [[ -z "$letsencrypt_path" ]]; then
  echo "Invalid value for letsencrypt-path"
  Usage
fi

# Create nginx conf files
if [[ "$add_www" == "yes" ]]; then
  domain2="-d www.$domain"
else
  domain2=
fi

docker run --rm -ti -v $letsencrypt_path:/etc/letsencrypt -v $website_path:/var/www/html certbot/certbot certonly --webroot -w /var/www/html -d $domain $domain2

