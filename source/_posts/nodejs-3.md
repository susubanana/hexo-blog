title: node.js--WebSocket与Socket.io
date: 2014-03-25 17:58:13
categories: ['nodejs']
tags: ['node.js','html5']
---

WebSocket主要是两部分内容，一部分是浏览器实现的WebSocket，一部分是服务器端实现的WebSocket协议。WebSocket是随html5的推动被设计和开发，但是没有成为html5标准的一部分，前者被W3C标准化，后者被IETF标准化为RFC 6455。

WebSocket协议
-------------------------

* 客户端与服务器端只建立一个TCP连接即可完成双向通信。这个连接是实时的、永久的，除非被显式关闭。
* WebSocket服务器端可以推送数据到客户端，远比http请求响应灵活。
* 有更轻量级的协议头，减少数据传送量。

###WebSocket浏览器端的实现
<!--more-->
```sh
var webSocket = new WebSocket("http://localhost:8080")；
webSocket.onopen = function(){
    webSocket.send(data);
}
webSocket.onmessage = function(ev){
    alert(ev.data);
}

webSocket.onclose = function(){}
```

WebSocket是一项新技术，大部分浏览器、代理、防火墙还没完全支持这种新协议，因此，需要能支持早期浏览器的方案：Socket.io。

Socket.io
---------------------

Socket.io提供了足够简单却十分强大的API，用于构建实时消息快速通信的应用，还能在所有浏览器以及大部分移动设备上运行。

以聊天室为例：

###初始化程序

创建依赖
```sh
//打开package.json文件
{
  "name": "chat",
  "version": "0.0.1",
  "private": true,
  "dependencies": {
    "express": "3.0.0beta7",
	"socket.io" : "0.9.2"
  }
}
```
运行npm install -g 安装依赖。

###构建服务器

根目录下，app.js文件

```sh
var express = require('express')
    , http = require('http')
    , bodyParser = require('body-parser')
    , app = express();

app.use(bodyParser());
//使用static中间件，并将public作为托管的目录
app.use(express.static('public'));
app.set('port', process.env.PORT || 3000);
var server = http.createServer(app).listen(app.get('port'), function(){
    console.log("Express server listening on port " + app.get('port'));
});
var io = require('socket.io').listen(server);
io.sockets.on('connection', function(socket){
    console.log('someone connect..');
});
```

###构建客户端

public文件夹下，创建index.html

```sh
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <title>Socket.io</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="/socket/socket.io.min.js"></script>
</head>
<body>
<div id="chat">
    <ul id="messages"></ul>
    <form>
        <input type="text" id="message">
        <button>send</button>
    </form>
</div>
<script>
    window.onload = function(){
        var socket = io.connect('http://localhost:3000');
    }
</script>
</body>
</html>
```

运行`node app`，终端显示为：
```sh
D:\project\chat>node app
   info  - socket.io started
   Express server listening on port 3000
   debug - client authorized
   info  - handshake authorized 15477697991610466692
   debug - setting request GET /socket.io/1/websocket/15477697991610466692
   debug - set heartbeat interval for client 15477697991610466692
   debug - client authorized for
   debug - websocket writing 1::
   someone connect..
```


























