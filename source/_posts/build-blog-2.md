title: 用hexo搭建博客--部署到github上
date: 2013-11-19 17:59:38
tags: [hexo]
---

本文记录如何将博客部署到github上。

安装Git
-----------------

下载安装[msysgit](https://code.google.com/p/msysgit/downloads/list)，安装完成，右键菜单查看Git Bash选项，没有进入开始菜单查看Git Bash。

配置SSH Keys
-----------------

新用户使用Git，需要配置SSH keys，参考[官方教程](https://help.github.com/articles/generating-ssh-keys)。

安装细节提示：
<!--more-->
* 安装完Git，还需要安装github，在[SSH Keys](https://help.github.com/articles/generating-ssh-keys)本页面下载安装。
* 安装Git会在`C:\Users\用户名下`生成一个.ssh文件夹，因为Git Bash切换盘符（C盘/D盘等）不方便，所以最好就是的项目、Git、.ssh文件夹都存放在同一个盘符，如：D盘等，将.ssh复制到Git文件夹下。
* 在SSH Keys配置的第二个步骤输入命令后，一路回车即可。

配置Git Bash的默认路径
-----------------

找到`Git的安装路径\Git\etc文件夹`，找到profile文件，将下面代码：

```sh
HOME="$(cd "$HOME" ; pwd)"
```

改成：

```sh
HOME="想要设置的Git Bash初始路径"
HOME="$(cd "$HOME" ; pwd)"
cd
```

注册Github账号
-----------------

前往[github](https://github.com/)网站注册github账号。

创建repository
-----------------

登录github后，将鼠标点击github右上角“+”号，在下拉菜单上，选择“New repository”项，将跳到如下页面，填写库名称，勾选“Initialize this repository with a README”，点击“create repository”，即可完成创建库。

<img title="创建库" src="/images/cont/create-repository.jpg" style="display:block;" />

创建完后不要关闭，一会就会用到。

部署hexo博客
-----------------

找到hexo\ _config.yml文件，修改如下代码

```sh
deploy:
  type
```

改成：

```sh
deploy:
  type: github
  repository: https://github.com/susubanana/dancing-waves.git
  branch: master
```

其中repository的路径为刚刚创建完repository的库页面，右侧栏有个HTTPS clone URL，复制里面的地址作为repository的路径。
**注：** 这里代码的缩进和冒号后必须要有一个空格，否则报错。

打开Git Bash，通过指令`cd 文件路径到达hexo文件夹下`，执行下列指令完成部署。

```sh
hexo g
hexo d
```

到github上查看项目是否部署上去。

**注：** 在`hexo d`之后出现`fatal: 'github' does not appear to be a git repository`报错，敲入如下指令：

```sh
rm -rf .deploy
hexo setup_deploy
hexo d
```


