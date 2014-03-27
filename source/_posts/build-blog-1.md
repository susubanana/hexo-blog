title: 用hexo搭建博客--博客初成
date: 2013-11-18 22:34:13
tags: [hexo]
---

用过Octopress或Jekyll来建立自己的Blog，好用，但是文章多了生成速度会很慢，于是就有了Hexo。

>hexo是由Node.js驱动的一款快速、简单且功能强大的博客框架，支持多线程，数百篇文章只需几秒即可生成。支持markdown编写文章，可以方便的生成静态网页托管在github上。

本博客是用hexo搭建，本文记录如何利用hexo搭建博客。安装hexo前，先下载安装[node](http://nodejs.org/)。


安装hexo
--------------

```sh
npm install hexo -g
```

<!--more-->

创建hexo所在文件夹
--------------
创建博客所在的文件夹（如：D:/node/blog/hexo），然后通过cmd，通过命令行进入blog文件夹下：

```sh
d:
cd node/blog/hexo
```

执行下面代码，hexo会在hexo文件夹下初始化所需要的所有文件

```sh
hexo init
```

启动本地服务
--------------

在上面创建的hexo文件夹下执行以下命令

```sh
hexo g //每次修改本地文件后，需要`hexo g`/`hexo generate`才能保存
hexo s //启动服务
```

至此，本地博客已经搭建成功，在浏览器输入`localhost:4000`就能看到自己搭建的hexo博客主页了。

关于命令格式
--------------

上面的hexo命令都是执行简单的命令格式，右侧为原有的命令

hexo g == hexo generate

hexo d == hexo deploy

hexo s == hexo server

hexo n == hexo new


