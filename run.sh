#!/bin/bash
set -ex

. env.sh

if [ $# -eq 0 ]; then
  echo "Usage: $0 <customer_prefix> [<new_root_password>]"
  exit 1
fi

CUST=$1
NEW_PASS=$2

if [ ! -d /veeam/${CUST}/config ] || [ ! -d /veeam/${CUST}/data ]; then
   sudo mkdir -p /veeam/${CUST}/{config,data}
fi

docker run -d -p 60022:22 -p 2500-2550:2500-2550 --restart unless-stopped --name veeam-${CUST}-remoterepo --restart on-failure:1 -v /veeam/${CUST}/data:/data:rw -v /veeam/${CUST}/config:/config:rw $USERNAME/$IMAGE:latest $NEW_PASS
