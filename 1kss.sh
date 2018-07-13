#!/bin/bash

ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

read -t 30 -p "输入链接密码(默认：test123)：" pwd
if [[ ! -n "$pwd" ]] ;then 
	pwd=test123 
fi

read -t 30 -p "输入端口(默认：6433)：" port
if [[ ! -n "$port" ]] ;then 
	port=6433 
fi

echo -e "\n"
# 安装docker
yum install -y  docker
# 启动docker
systemctl start docker
# 拉取镜像
docker pull mritd/shadowsocks
# 启动容器
docker run -dt --name ssserver -p $port:6443 -p 6500:6500/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k $pwd --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:6443 -l :6500 -mode fast2"

echo "-------------------------------------------------"
echo ""
echo " 链接ip: $ip"                                     
echo " 链接端口: $port"
echo " 链接密码: $pwd"
echo ""
echo "-------------------------------------------------"