1. 拉取镜像资源 docker pull registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g
2. 创建镜像容器，运行容器 docker run -d -p 1521:1521 --name oracle11g registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g
3. 进入镜像进行配置 docker exec -it oracle11g bash
	- 切换到root用户
		- su root
		- 密码 helowin
	- 配置环境变量
		- export ORACLE_HOME=/home/oracle/app/oracle/product/11.2.0/dbhome_2
		- export ORACLE_SID=helowin
		- export PATH=$ORACLE_HOME/bin:$PATH
	- 创建软连接
		- ln -s $ORACLE_HOME/bin/sqlplus /usr/bin
	- 切换回oracle用户 su - oracle
	- 登录
		- sqlplus /nolog
		- conn /as sysdba 以dba方式登录
	- 修改用户密码，密码设为oracle
		- alter user system identified by oracle;
		- alter user sys identified by oracle;
		- 将密码有效期设为永久 ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
4. 使用外部主机的navicat进行登录访问oracle
	- 采用这个命令查看服务实例名称，这里的名称为helowinXDB
		- lsnrctl status
	- 密码为之前设定好的oracle，端口为启动容器时所映射端口，地址为所在Linux的地址192.168.142.128
5. oracle创建用户
	- 以dba方式登录 conn /as sysdba
	- 创建用户 create user test identified by test;
	- 为用户授权 grant connect,resource,dba to test;