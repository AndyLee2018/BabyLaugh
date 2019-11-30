1. 查看CentOS内核版本，必须大于3.10
2. uname -r
3. 如果不大于3.10，输入yum update对内核进行升级，升级后重启shutdown -r now
4. yum install docker 安装命令
5. 启动docker命令 systemctl start docker
6. 查看docker版本命令 docker -v
7. 将docker服务设为开机启动 systemctl enable docker
8. 停止docker命令 systemctl stop docker