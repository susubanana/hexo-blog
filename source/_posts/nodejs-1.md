title: node.js--错误调试
date: 2014-03-13 17:29:12
categories: [nodejs]
tags: [node.js]
---

开发免不了调试bug，高效的调试技巧会让编程更有乐趣。

Node调试技巧
-------------------------

###命令行调试

在命令行下进入项目路径，执行`node debug 文件名`，将会启动Node调试终端。

终端显示结果：

```sh
D:\node\microblog>node debug app.js
< debugger listening on port 5858
connecting... ok
break in D:\node\microblog\app.js:6
  4  */
  5
  6 var express = require('express');
  7 var http = require('http');
  8 var routes = require('./routes');
debug> c
< Express server listening on port 3000
< connect mongodb success...
```

可以基于如下命令进行调试：
<!--more-->
>
`run` 执行脚本在第一行暂停
`restart` 重新执行脚本
`cont、c` 继续执行脚本，直到遇到下一个断点
`next、n` 单步执行
`step、s` 单步执行并进入函数
`out、o` 从函数中退出
`setBreakpoint('sripts.js', 20)` 在scripts的第20行设置断点
`clearBreakpoint` 清除所有断点
`breaktrace、bt` 显示当前调用栈
`list(5)` 显示当前执行到的前5行代码
`watch(expr)` 把表达式expr加入监视列表
`unwatch(expr)` 把表达式expr从监视列表移除
`watchers` 显示监视列表中所有表达式和值
`repl` 在当前上下文打开即时求值环境
`kill` 终止当前执行的脚本
`scripts` 显示所有已加载的脚本

###使用supervisor

开发node的时候，修改代码，总要终止进程并重启才凑效。这是因为node只有在第一次引用到某部分时才会去访问脚本，以后都会直接访问内存，避免重复载入。这种设计有利于提高性能，却不利于调试。

supervisor可以监视代码改动，并自动重启。

使用步骤：
1. 安装supervisor，`npm install -g supervisor`
2. 在当前项目路径下，使用supervisor启动app.js，`supervisor app.js`

终端显示结果：

```sh
D:\project\microblog>supervisor app.js

Running node-supervisor with
  program 'app.js'
  --watch '.'
  --extensions 'node,js'
  --exec 'node'

Starting child process with 'node app.js'
Watching directory 'D:\project\microblog' for changes.
Express server listening on port 3000
connect mongodb success...
```

当代码被改动，会自动终止脚本并重启

终端显示结果：

```sh
D:\project\microblog>supervisor app.js

Running node-supervisor with
  program 'app.js'
  --watch '.'
  --extensions 'node,js'
  --exec 'node'

Starting child process with 'node app.js'
Watching directory 'D:\project\microblog' for changes.
Express server listening on port 3000
connect mongodb success...
crashing child
Starting child process with 'node app.js'
Express server listening on port 3000
connect mongodb success...
```

###使用node-inspector调试

node-inspector是一个完全基于Node的开源在线调试工具，提供强大的调试功能和友好的用户界面，通过npm install -g node-inspector安装。

使用步骤：
1. 打开终端，在项目目录下通过`node --debug-brk=5858 app.js`连接调式服务器。
2. 新开一个终端，在项目目录下输入`node-inspector`，来启动node-inspector。
3. 在浏览器输入localhost:8080/debug?port=5858即可显示web调试工具。

<img src="/images/cont/nodejs-11.jpg" style="display:block;"/>

其使用方法就和浏览器调试脚本一样，支持单步、断点、调用栈帧查看等。