#!/bin/bash

set -e
set -u

if [[ $# -lt 1 ]]
then
    echo "example: $0 应用包名"
    exit
fi

app_package=$1

# ~$ adb shell ps | grep com.tencent.mobileqq
# u0_a226   8260  476   1693044 171788 SyS_epoll_ 0000000000 S com.tencent.mobileqq
# u0_a226   8437  476   1615724 99772 SyS_epoll_ 0000000000 S com.tencent.mobileqq:MSF

# adb logcat -v threadtime | grep -F "`adb shell ps | grep 应用包名 | awk '{print $2}'`"
#example: adb logcat -v threadtime | grep -F "`adb shell ps | grep com.tencent.mobileqq | awk '{print $2}'`"
function app_log(){
    shell="`adb shell ps | grep ${app_package} | awk '{print $2}'`"
    process=${shell}
    result=""
    for element in ${process}
    do
       echo "应用进程id：${element}"
       result="${result}${element}|"
    done
    #去掉最后一个竖杠
#    result="${result%?}"
#    adb shell logcat -v threadtime | grep -E ${result}

    # --colour=always 增加高亮着色
    adb shell logcat -v threadtime | grep --colour=always -F "`adb shell ps | grep ${app_package} | awk '{print $2}'`"
}

function input(){
    while true
    do
        echo "[1: logcat] [q: exit]"
        echo -n "input: "
        read number
        if [[ ${number} = "1" ]]
        then
            app_log
            break
        elif [[ ${number} = "q" ]]
        then
            break
        fi
    done
}

input
