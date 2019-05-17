#!/bin/bash

set -e
set -u

if [[ $# -lt 1 ]]
then
    echo "example: $0 qq.apk"
    exit
fi

app_path=$1

function action(){
    unzip -o -d android-apk ${app_path}
    cd android-apk
    echo "======================================================================="
    keytool -printcert -file META-INF/CERT.RSA
}

action
exit