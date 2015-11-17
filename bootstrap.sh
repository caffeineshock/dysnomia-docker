#!/bin/bash

FILE_MISSING=false

check_config_file() {
  CONFIG_FILE_PATH="source/config/$1"
  if [ ! -f $CONFIG_FILE_PATH ]; then
    echo -e "\033[1;31mConfigure\033[0m $CONFIG_FILE_PATH"
    FILE_MISSING=true
  fi
}

if [ ! -d "source" ]; then
  git clone git@github.com:caffeineshock/dysnomia.git source
fi

check_config_file "database.yml"
check_config_file "secrets.yml"
check_config_file "private_pub.yml"

if [ "$FILE_MISSING" = true ]; then
  exit 1
fi

docker-compose build
echo -e "\033[1;32mBuild complete! Run with\033[0m docker-compose up"
