title: web基础--浏览器缓存
date: 2013-12-06 19:25:18
tags: [web基础]
---

本文记录浏览器缓存。

浏览器缓存
--------------------

是把页面信息保存到用户本地磁盘里，包括html缓存和图片js，css等资源的缓存。如下图：

<img src="/images/cont/web-base-2.jpg" style="display:block;" />

###缓存的优点：
<!--more-->
* 服务器响应更快：请求缓存服务器而不是源服务器，这个过程耗时更少，让服务器看上去响应更快。
* 减少网络带宽消耗：当副本被重用时会减低客户端的带宽消耗。

###缓存工作原理

页面缓存状态是由http header决定的，一个浏览器请求信息，一个是服务器响应信息。主要包括Pragma: no-cache、Cache-Control、 Expires、 Last-Modified、If-Modified-Since。

原理主要分三步：

1. 第一次请求：浏览器通过http的header报头，附带Expires，Cache-Control，Last-Modified/Etag向服务器请求，此时服务器记录第一次请求的Last-Modified/Etag
2. 再次请求：当浏览器再次请求的时候，请求头附带Expires，Cache-Control，If-Modified-Since/Etag向服务器请求
3. 服务器根据第一次记录的Last-Modified/Etag和再次请求的If-Modified-Since/Etag做对比，判断是否需要更新，服务器通过这两个头判断本地资源未发生变化，客户端不需要重新下载，返回304响应。

原理图：

<img src="/images/cont/web-base-21.jpg" style="display:block;" />

流程图：

<img src="/images/cont/web-base-22.jpg" style="display:block;" />

与缓存相关的HTTP扩展消息头

>Expires：设置页面过期时间，格林威治时间GMT
>Cache-Control：更细致的控制缓存的内容
>Last-Modified：请求对象最后一次的修改时间 用来判断缓存是否过期 通常由文件的时间信息产生
>ETag：响应中资源的校验值，在服务器上某个时段是唯一标识的。ETag是一个可以 与Web资源关联的记号（token），和Last-Modified功能差不多，也是一个标识符，一般和Last-Modified一起使用，加强服务器判断的准确度。
>Date：服务器的时间
>If-Modified-Since：客户端存取的该资源最后一次修改的时间，用来和服务器端的Last-Modified做比较
>If-None-Match：客户端存取的该资源的检验值，同ETag。

Cache-Control的主要参数

>Cache-Control: private/public Public 响应会被缓存，并且在多用户间共享。 Private 响应只能够作为私有的缓存，不能再用户间共享。
>Cache-Control: no-cache：不进行缓存
>Cache-Control: max-age=x：缓存时间 以秒为单位
>Cache-Control: must-revalidate：如果页面是过期的 则去服务器进行获取。

###关于图片，css，js，flash的缓存

主要通过修改服务器的配置来实现缓存。
