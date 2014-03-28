title: web基础--HTTP协议详解
date: 2013-12-06 18:20:22
tags: [web基础]
---

本文记录HTTP协议详解。

HTTP是一种通过Internet发送与接收数据的协议，客户端发出一个请求，服务器响应这个请求。,它建立在TCP协议之上，一般采用TCP的80端口。
HTTP协议是无状态的，同一个客户端的这次请求和上次请求是没有对应关系，对HTTP服务器来说，它并不知道这两个请求是否来自同一个客户端。

HTTP协议详解之url
------------------

http url的格式如右：`http://host[":"port][abs_path]`
<!--more-->
* http表示要通过HTTP协议来定位网络资源；
* host表示合法的Internet主机域名或者IP地址；
* port指定一个端口号，为空则使用缺省端口80；
* abs_path指定请求资源的URI；
* 如果URL中没有给出abs_path，那么当它作为请求URI时，必须以“/”的形式给出，通常这个工作浏览器自动帮我们完成。
example：
1、输入：www.guet.edu.cn
浏览器自动转换成：http://www.guet.edu.cn/
2、http:192.168.0.116:8080/index.jsp

HTTP协议详解之请求篇
-------------------

http请求由三部分组成，分别是：请求行、消息报头、请求正文

```sh
GET /domains/example/ HTTP/1.1      //请求行: 请求方法 请求URI HTTP协议/协议版本
Host：www.iana.org             //服务端的主机名
User-Agent：Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4   //告诉HTTP服务器， 客户端使用的操作系统和浏览器的名称和版本
Accept：text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8    //客户端能接收的mine
Accept-Encoding：gzip,deflate,sdch     //是否支持流压缩
Accept-Charset：UTF-8,*;q=0.5      //客户端字符编码集
//空行,用于分割请求头和消息体
//消息体,请求资源参数,例如POST传递的参数
```

###请求行的请求方法

请求方法有多种，最基本的有4种，分别是GET,POST,PUT,DELETE，对应资源的查，改，增，删4个操作。

主要看看GET和POST的区别:

* GET请求消息体为空，POST请求带有消息体。
* GET提交的数据会放在URL之后，以?分割URL和传输数据，参数之间以&相连，如：EditPosts.aspx?name=test1&id=123456。POST方法是把提交的数据放在HTTP包的body中。
* GET提交的数据大小有限制（因为浏览器对URL的长度有限制），而POST方法提交的数据没有限制。
* GET方式提交数据，会带来安全问题，比如一个登录页面，通过GET方式提交数据时，用户名和密码将出现在URL上，如果页面可以被缓存或者其他人可以访问这台机器，就可以从历史记录获得该用户的账号和密码。

HTTP协议详解之响应篇
-----------------------

HTTP响应也是由三个部分组成，分别是：状态行、消息报头、响应正文

```sh
HTTP/1.1 200 OK                     //状态行：HTTP协议版本号 状态码 状态消息
Server: nginx/1.0.8                 //服务器使用的WEB软件名及版本
Date:Date: Tue, 30 Oct 2012 04:14:25 GMT        //发送时间
Content-Type: text/html             //服务器发送信息的类型
Transfer-Encoding: chunked          //表示发送HTTP包是分段发的
Connection: keep-alive              //保持连接状态
Content-Length: 90                  //主体内容长度
//空行 用来分割消息头和主体
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"... //消息体
```

###状态码
状态码用来告诉客户端,服务器是否产生了预期的Response。状态代码由三位数字组成，第一个数字是响应类别，有五种可能值：

1XX 提示信息 - 表示请求已被成功接收，继续处理
2XX 成功 - 表示请求已被成功接收，理解，接受
3XX 重定向 - 要完成请求必须进行更进一步的处理
4XX 客户端错误 - 请求有语法错误或请求无法实现
5XX 服务器端错误 - 服务器未能实现合法的请求

常见状态代码：
200 OK      //客户端请求成功
400 Bad Request  //客户端请求有语法错误，不能被服务器所理解
401 Unauthorized //请求未经授权，这个状态代码必须和WWW-Authenticate报头域一起使用
403 Forbidden  //服务器收到请求，但是拒绝提供服务
404 Not Found  //请求资源不存在，eg：输入了错误的URL
500 Internal Server Error //服务器发生不可预期的错误
503 Server Unavailable  //服务器当前不能处理客户端的请求，一段时间后，可能恢复正常

###Connection: keep-alive
从HTTP/1.1起，默认都开启了Keep-Alive，保持连接特性，简单地说，当一个网页打开完成后，客户端和服务器之间用于传输HTTP数据的TCP连接不会关闭，如果客户端再次访问这个服务器上的网页，会继续使用这一条已经建立的连接

Keep-Alive不会永久保持连接，它有一个保持时间，可以在不同服务器软件（如Apache）中设置这个时间。
