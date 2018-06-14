#!/bin/bash

pwd=test123
read -t 120 -p "输入链接密码：" pwd
echo -e "\n"
# 安装docker
yum install -y  docker
# 启动docker
systemctl start docker
# 拉取镜像
docker pull mritd/shadowsocks
# 启动容器
docker run -dt --name ssserver -p 6443:6443 -p 6500:6500/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k $pwd --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:6443 -l :6500 -mode fast2"

echo "链接端口: 6443"
echo "链接密码: $pwd"
