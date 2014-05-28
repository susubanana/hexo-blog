title: 移动Web开发--离线存储
date: 2014-02-25 19:41:12
categories: [移动开发]
tags: [html5]
---

移动用户访问应用的时候，网络都是在不稳定状态，又或者随着移动用户所在的信号问题，导致网络中断。离线存储可以有效缓解网络中断后，用户无法正常使用web应用的问题。

离线存储
------------------------

###如何使用离线存储

首先，**创建一个名为"manifest.appcache"文件**。

```sh
CACHE MANIFEST

#version 1 //这个manifest的版本号
http://i.thsi.cn/images/ifund/mobile/srdz/rate-bg.png
http://s.thsi.cn/js/ifund/mobile/zepto.min.js

NETWORK:

FALLBACK:

```

在`CACHE MANIFEST`语句下面，我们列出所有想要做缓存的文件，为某个页面做本地存储时，不需要指定页面本身，浏览器会自动对这个页面进行本地存储。

在`NETWORK`语句下面，我们列出所有不需要做缓存的文件的URL，这些文件只有当客户端与服务器端建立连接才能访问。

在`FALLBACK`语句下面，每一行指定两个资源文件，第一个文件为能够在线访问时使用的资源文件，第二个文件为不能在线访问时的替代资源文件。。

然后，**将要做离线缓存的html页面中的`<html>`标签，改成`<html manifest="manifest.appcache">`**。

在移动客户端访问这个页面，然后断掉网络，页面还会正常加载，并能正常交互。

###
<!--more-->