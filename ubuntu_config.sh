#! /usr/bin/env bash
set -e
set -u


commonds=("net-tools" "tree" "git" "subversion" "nautilus-share" "gnome-tweak-tool" "ibus ibus-table fcitx-table-wubi")
install_text=("安装ifconfig" "安装tree" "安装Git" "安装SVN" "安装文件共享" "安装gnome优化软件" "安装五笔输入法 （需要重启生效）")

for((i=0;i<${#commonds[*]};i++)) 
do  	
	echo "==================================================="
	echo ${install_text[$i]}
	echo "==================================================="
	shell="sudo apt install ${commonds[$i]}"
	${shell}
	echo ""
	echo ""
done 

echo "==================================================="
echo "安装谷歌浏览器"
echo "==================================================="
if [[ ! -f "google-chrome-stable_current_amd64.deb" ]];then
	`wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb`
fi
shell="sudo dpkg -i google-chrome*.deb"
${shell}

exit
