1. connect system/oracle@192.168.142.128:1521/helowinXDB
2. 乱码问题解决
	- 原因：客户端字符集和服务端字符集编码不一致
	- 客户端登陆后执行以下命令查看服务端字符集编码
		select userenv('language') from dual;
	- 配置环境变量、修改系统语言设置
		图片：https://note.youdao.com/yws/public/resource/4d29aea0fbf0a24065c7b9fd4489b3b7/xmlnote/5B95EB6B03644D3FA14D7C5620F75E24/961
		图片：https://note.youdao.com/yws/public/resource/4d29aea0fbf0a24065c7b9fd4489b3b7/xmlnote/7D22F83365454EB792613C6A615E43FD/965