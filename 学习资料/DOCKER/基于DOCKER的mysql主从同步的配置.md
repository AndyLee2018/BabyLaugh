1. 在宿主机自定义位置创建my.cnf配置文件
	- 创建master主机my.cnf配置文件
		- touch /etc/mysql/conf.d/my.conf
		- vim /etc/mysql/conf.d/my.conf 编辑如下内容
			[mysqld]
			log-bin=mysql-bin
			server-id=1
			innodb_flush_log_at_trx_commit=1
			sync_binlog=1
	- 创建slave从机my.cnf配置文件
		- touch /etc/mysql2/conf.d/my.conf
		- vim /etc/mysq2l/conf.d/my.conf 编辑如下内容
			[mysqld]
			server-id=2
2. 运行master主机，将新建的配置文件与master对应位置挂载
	- docker run -d -p 3306:3306 -v /etc/mysql/conf.d:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=123456 --name master mysql:5.6;
3. 进入master容器进一步配置
	- docker exec -it master(或容器id) /bin/bash;
	- 登录mysql
		- mysql -u root -p 123456
		- mysql> CREATE USER 'name'@'ip' IDENTIFIED BY 'password';
			- name 和 password 为授权slave访问的用户名密码
			- ip 为slave容器ip,可以通过命令docker inspect [slave容器id]查看；
		- GRANT REPLICATION SLAVE ON *.* TO 'name'@'ip';
		- 查看master状态，这里的file和position后面配置salve会用到
			- show master status;
4. 运行slave从机，将新建的配置文件与master对应位置挂载
	- docker run -d -p 3307:3306 -v /etc/mysq2l/conf.d:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=123456 --name slave mysql:5.6;
5. 进入slave容器进一步配置
	- docker exec -it slave(或容器id) /bin/bash;
	- 登录mysql
		- mysql -u root -p 123456
		- mysql> CHANGE MASTER TO
		    ->     MASTER_HOST='master_host_name',
		    ->     MASTER_USER='replication_user_name',
		    ->     MASTER_PASSWORD='replication_password',
		    ->     MASTER_LOG_FILE='recorded_log_file_name',
		    ->     MASTER_LOG_POS=recorded_log_position;
		master_host_name master主机ip，通过docker inspect [master容器ID]
		replication_user_name master授权的用户名
		replication_password master授权的密码
		recorded_log_file_name 查看master状态时的file
		recorded_log_position 查看master状态时的position
	- 启动SLAVE
		- mysql> START SLAVE;
	- 查看运行状态
		- mysql> show slave status\G;
		- 这两项为YES表示成功
			- Slave_IO_Running: Yes        
			- Slave_SQL_Running: Yes