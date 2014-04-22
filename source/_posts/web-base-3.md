title: web基础--cookie和session
date: 2013-12-07 21:13:30
tags: [web基础]
---

因为HTTP协议是无状态的，所以用户的每一次请求都是无状态的，我们不知道在整个Web操作过程中哪些连接与该用户有关，如何解决这个问题？Web经典的解决方案是cookie和session，cookie是一种客户端机制，把用户数据保存在客户端，而session是一种服务器端的机制。

Cookie
--------------------

Cookie是由浏览器维持的，在本地计算机保存一些用户操作的历史信息（当然包括登录信息），并在用户再次访问该站点时浏览器通过HTTP协议将本地cookie内容发送给服务器，从而完成验证，或继续上一步操作。
<!--more-->
<img src="/images/cont/web-base-3.jpg" style="display:block;" />

cookie是有时间限制的，根据生命期不同分成两种：会话cookie和持久cookie；

###会话cookie
如果不设置过期时间，只要关闭浏览器窗口，cookie就消失了。这种生命期为浏览会话期的cookie被称为会话cookie。会话cookie一般保存在内存里。

###持久cookie
浏览器就会把cookie保存到硬盘上，关闭后再次打开浏览器，这些cookie依然有效直到超过设定的过期时间。存储在硬盘上的cookie可以在不同的浏览器进程间共享，比如两个IE窗口。而对于保存在内存的cookie，不同的浏览器有不同的处理方式。 　

Session
------------------------
session机制是一种服务器端的机制，服务器使用一种类似于散列表的结构(也可能就是使用散列表)来保存信息，每一个网站访客都会被分配给一个唯一的标志符,即sessionID。

程序需要为某个客户端的请求创建一个session的时候，服务器首先检查这个客户端的请求里是否包含了一个sessionID，如果有则说明以前已经为此客户创建过session，服务器就按照sessionID把这个session检索出来使用。如果没有，则为此客户创建一个session并且同时生成一个与此session相关联的sessionID，将这个sessionID放在本次响应中返回给客户端保存在cookie里。

<img src="/images/cont/web-base-31.jpg" style="display:block;" />

总的来说，session通过cookie，在客户端保存sessionID，而将用户的其他会话消息保存在服务端的session对象中。而cookie需要将所有信息都保存在客户端。
