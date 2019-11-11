## git blame [文件名称] 查看具体每一行的提交日志信息
 - 例如：git blame book.txt
## git blame -L [起始行号，结束行号] [文件名称] 查看从起始行到结束行的提交信息
 - 例如：git blame -L 5,10 book.txt
## git clean -n 列出未加入到暂存区的文件 
## git clean -n -x 列出未加入到暂存区的文件,包括.gitignore中忽略的文件
## git clean -f 将未列入到暂存区的文件删除
## git clean -f -x 将未列入到暂存区的文件删除，包括.gitignore中忽略的文件
## git rm [文件名] 将本地版本库中的文件删除，被删除的文件处于暂存区，是被跟踪状态D（绿色），直接提交即可；
 - 与直接使用rm [文件名]的方式不同的是，直接rm [文件名]将文件删除后，文件状态不在暂存区，是未被跟踪状态D（红色），
 需要先add再提交
## git add -p [文件名] 一个文件多次提交：一个文件有多处修改，采用这个命令可以将修改的每部分按需求加入暂存区。 
# 信息查看
## git status -sb 加入-sb参数可以使提示信息简化
## git show [某次提交的hash值（可以使用git hi查看）] 查看某次提交的信息
## git show HEAD 查看最近一次提交记录
## git show HEAD~[n] 查看前n次提交记录
## git log [文件名] 查看某个文件的提交记录
## git log --grep [msg] 查看经过过滤的提交记录信息
## git diff 查看工作区和暂存区文件的区别
## git diff [版本hash值] 查看工作区和某个版本的区别
## git diff --cached 查看暂存区和版本库中最后版本文件的区别
## git diff --cached [版本hash值] 查看暂存区和版本库中某个版本文件的区别
## git diff [版本hash值] [版本hash值] 查看版本库中某两个版本文件的区别（有先后）
# 回退
## git reset [版本hash值] 将版本回退到指定版本，包括版本库和暂存区
## git reset [版本hash值] --soft 将版本回退到指定版本，只包括版本库
## git reset [版本hash值] --hard 将版本回退到指定版本，包括版本库 暂存区 工作区
## git push -f 强制将本地库推送到远程库，本地库有过回退操作后如果要推送到远程库可以使用此操作
## git commit --amend -m "msg" 将本次提交内容和上一次提交版本内容合并作为同一个版本提交，上一个版本提交记录抛弃
## git rebase -i [版本hash值] 变基操作，合并版本，修改提交日志



