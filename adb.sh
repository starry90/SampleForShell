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

function app_version(){
    adb shell pm dump ${app_package} | grep --colour=always "version"
}

function app_path(){
    adb shell pm path ${app_package} | awk -F ":" '{print $2}'
}

function app_top_activity(){
    adb shell dumpsys activity top | head -n 5
}

function app_monkey(){
    adb shell monkey -p ${app_package} -v 1000
}

function app_clear_data(){
    adb shell pm clear ${app_package}
}

function adb_finish(){
    echo "The End..."
}
function action(){
    while true
    do
        echo "[1:应用日志信息] [2:应用版本信息]  [3:应用apk位置] [4:当前栈顶Activity] [5:压测1千次] [c:清除应用数据] [q:退出]"
        echo -n "input: "
        read number
        if [[ ${number} = "1" ]]
        then
            app_log
            break
        elif [[ ${number} = "2" ]]
        then
            app_version
            break
        elif [[ ${number} = "3" ]]
        then
            app_path
            break
        elif [[ ${number} = "4" ]]
        then
            app_top_activity
            break
        elif [[ ${number} = "5" ]]
        then
            app_monkey
            break
        elif [[ ${number} = "c" ]]
        then
            app_clear_data
            break
        elif [[ ${number} = "q" ]]
        then
            break
        fi
    done
}

# 捕获退出信号
trap adb_finish EXIT
action
exit