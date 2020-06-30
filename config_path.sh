#!/bin/bash

set -e
set -u


if [[ $# -lt 1 ]]
then
    echo "example: $0 ~/work/xxx"
    exit
fi

env_path=$1
#evn_file=test.txt
evn_file=~/.bashrc

echo "" >> ${evn_file}
echo "PATH=${env_path}"':$PATH' >> ${evn_file}
