title: 用hexo搭建博客--使用github托管博客
date: 2013-11-19 18:50:31
tags: [hexo]
---

使用github托管博客
-----------------

创建好本地存放仓库的目录，打开gitBash,进入该目录，从github上拷贝仓库

```sh
git clone git@github.com:susubanana/hexo-blog.git
```

进入仓库文件夹

```sh
cd hexo-blog
```

查看仓库文件状态

```sh
git status
```

把所有未被git追踪的文件加入git管理中

```sh
git add -A
```

提交代码到本地仓库

```sh
git commit -m "update"
```

再使用`git status` 查看文件状态

把本地仓库的改动push到远端仓库
```sh
git push origin master
```