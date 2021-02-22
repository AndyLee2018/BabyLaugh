1. 镜像资源的下载与删除
	- 搜索镜像资源 docker search xxx
		例如：docker search mysql
		这个命令实际上就是去hub.docker.com上去搜索的，我们也可以直接登录到这个地址搜索
	- 搜索出镜像资源后，将所要使用的资源拉取下来
		命令：docker pull xxx,例如docker pull mysql
		可以下载指定版本的镜像资源 例如docker pull mysql:5.5
	- 查看已经下载的镜像资源 docker images
	- 删除镜像资源
		docker rmi xxx(镜像ID,用docker images查出的IMAGE ID值)，例如docker rmi c8ee894bd2bd
2. 容器操作，运行镜像，产生容器
	- 运行镜像 docker run --name xxx(给运行的镜像资源取个名称) -d(表示后台运行) xxx(REPOSITORY资源名):xxx(TAG资源ID),例如：docker run --name mytomcat -d tomcat:8-jdk8-corretto
		注意：以上启动命令执行后外界是无法对这个tomcat进行访问的，需要将容器内的端口与Linux端口进行映射，加入参数 -p 8080:8080,冒号前面的是Linux端口，冒号后面的是容器端口。例如 docker run --name mytomcat -d -p 8080:8080 tomcat:8-jdk8-corretto
		注意：一个镜像资源可以启动多个，会生成多个资源容器，端口映射要不同，例如执行了上述操作后，依然可以再启动 docker run --name mytomcat -d -p 8081:8080 tomcat:8-jdk8-corretto
		注意：执行运行镜像命令后会生成一个资源容器，下面的操作都是对这个容器的操作
	- 查看正在运行的镜像 docker ps
		docker ps -a 查询所有已经生成的容器，包括已经退出的容器
	- 停止运行中的容器 docker stop xxx(CONTAINER ID容器id，docker ps 中会显示)，例如：docker stop db2edb86b151
	- 启动已有的容器 docker start xxx(CONTAINER ID)
	- 删除已有的容器 docker rm xxx(CONTAINER ID)
		注意：是删除容器，而不是删除镜像资源
	- 查看容器日志 docker logs xxx(CONTAINER ID)
3. 关闭防火墙 service firewalld stop
4. 查看防火墙状态 service firewalld status
5. 更多命令：
	- https://docs.docker.com/engine/reference/commandline/docker/
