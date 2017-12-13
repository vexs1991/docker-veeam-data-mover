#!/bin/bash
set -ex
. env.sh

if [ $# -eq 0 ]; then
  echo "Usage: $0 \"<ssh_root_password>\""
  exit 1
fi

PASSWORD=$1

docker build -t $USERNAME/$IMAGE:latest --build-arg ROOT_PASSWORD=$PASSWORD .
