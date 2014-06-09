title: 热身运动
date: 2014-06-09 10:40:46
categories: [杂谈]
tags: [interview]
---

http协议题集
-------------------------

### http协议状态有哪些?
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

### GET和POST的区别？

* GET请求消息体为空，POST请求带有消息体。
* GET提交的数据会放在URL之后，以?分割URL和传输数据，参数之间以&相连，如：EditPosts.aspx?name=test1&id=123456。POST方法是把提交的数据放在HTTP包的body中。
* GET提交的数据大小有限制（数据大小长度并没有限制，HTTP协议规范没有对URL长度进行限制。这个限制是特定的浏览器及服务器对它的限制。），而POST方法提交的数据没有限制。
* GET方式提交数据，会带来安全问题，比如一个登录页面，通过GET方式提交数据时，用户名和密码将出现在URL上，如果页面可以被缓存或者其他人可以访问这台机器，就可以从历史记录获得该用户的账号和密码。

### 浏览器内核渲染引擎有哪几种？

* Trident内核渲染引擎 —— Internet Explorer的渲染引擎
* Gecko内核渲染引擎 —— Mozilla火狐的渲染引擎
* webkit内核渲染引擎 —— 谷歌和新版opera使用的渲染引擎
* Presto内核渲染引擎 —— 旧版Opera中所使用的渲染引擎

### 简述浏览器加载和渲染原理？

html题集
------------------------
###如何触发标准模式和怪异模式

触发标准模式
1、加DOCTYPE声明,比如：
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!DOCTYPE html>
2、设置X-UA-Compatible触发。

触发怪异模式
1、无doctype声明、定义旧的HTML版本（HTML4以下,例如3.2）
2、加XML声明，可在ie6下触发
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE ...>
3、在XML声明和XHTML的DOCTYPE之间加入HTML注释，可在ie7下触发 <?xml version="1.0" encoding="utf-8"?>
<!-- keep IE7 in quirks mode -->
<!DOCTYPE ...>
5、<!-- -->放在<!DOCTYPE前面

### 对标签语义化的理解？
用什么标签最能描述这块内容，表述更有意义，那么就可以使用这个标签。并且结构、样式、脚本分离。

### strong与em标莶语义化

* `<b>`标签在HTML仅仅表示粗体这个样式，`<i>`仅仅表示斜体，并没有附加的一些情感在里面。
* `<strong>`则不只是粗体的样式、更是提现一种逻辑判断，有强调的作用。
* `<em>`斜体，em更突显句意，在句子中强调的是哪一部分，而strong则更突显内容的重要性

### article与section标莶语义化？

* article：页面或应用程序中独立的、完整的，可以单独被外部引用的内容，可以是文章、博客、帖子、评论或者一个独立插件；
* section：对页面或应用程序的内容进行分块，一般由标题与内容组成；
    section不宜滥用的情况：
    * 不要将section元素用作设置样式的页面容器，那是div元素的工作。
    * 如果article元素、aside元素或nav元素更符合使用条件，不要使用section元素。
    * 不要为没有标题的内容区块使用section元素。

在HTML5中，article元素可以看成是一种特殊类型的section元素，它比section元素更强调独立性。即section元素强调分段或分块，而article强调独立性。具体来说，如果一块内容相对来说比较独立的、完整的时候，应该使用article元素，但是如果你想将一块内容分成几段，一般带标题的时候，应该使用section元素。另外，在HTML5中，当使用CSS样式的时候，应该使用div。

css题集
---------------------
### CSS选择符有哪些？哪些属性可以继承？优先级？内联和important哪个优先级高？

Class 可继承
伪类A标签可以继承
列表 UL LI DL DD DT 可继承
优先级就近原则，样式定义最近者为准

优先级为
!important > 内联样式 > [ id > class > tag ]

### 对渐进增强与平稳退化（优雅降级）的理解
向上增强叫做渐进增强，向下兼容叫优雅降级。
优雅降级：
使用优雅降级方案，Web站点在所有新式浏览器中都能正常工作，如果用户使用的是老式浏览器，则代码会检查以确认它们是否能正常工作。由于IE独特的盒模型布局问题，绝大多数Web设计师和开发者都通过专门的样式表或针对不同版本的IE的hack实践过优雅降级了；
使用优雅降级技术时，你必须首先完整的实现了网站，其中包括所有的功能和效果。然后再为那些无法支持所有功能的浏览器增加候选方案，使之在旧式浏览器上以某种形式降级体验却不至于完全失效。

渐进增强：
从被所有浏览器支持的基本功能开始，逐步地添加那些只有新式浏览器才支持的功能。渐进增强是值得所有开发者采用的做法。渐进增强方案并不假定所有用户都支持javascript，而总是提供一种候补方法，确保用户可以访问（主要的）内容。
使用渐进增强时，无需为了一个已成型的网站在旧式浏览器下正常工作而做逆向工程。首先，只需要为所有的设备和浏览器准备好清晰且语义化的HTML以及完善的内容，然后再以无侵入（unobtrusive）的方式向页面增加无害于基础浏览器的额外样式和功能。当浏览器升级时，它们会自动地呈现出来并发挥作用。
### 双飞翼
### IEhack
### display: inline-block
### float与position
### css3比较流行的属性

javascript题集
-------------------
###对事件捕获和事件冒泡的理解

### addEventListener和attachEvent的区别？
* addEventListener使用`click`作为事件类型，参数三个，第三个参数可忽略，可定义为捕获`true`或冒泡`false`。attachEvent使用'on' + type作为事件类型，参数为两个。
* addEventListener会按事件的注册顺序调用，对同一个对象相同的处理程序只能注册一次。attachEvent按注册顺序的相反顺序触发，对同一个对象相同的处理程序能注册多次。
* 主要区别在于事件处理程序的作用域，addEventListener是在当前元素的作用域运行：`e.target === this`为`true`，IE11以下可以使用attachEvent，attachEvent在全局作用域中进行，this指向window，`e.target === this`为`false`。可用如下代码解决这个问题：
 ```sh
 function addEvent(target, type, handler){
    if(target.addEventListener){
        target.addEventListener(type, handler, false);
    } else {
        target.attachEvent('on' + type, function(e){
            return handler.call(target, e);
        });
    }
 }
 ```

### js中this的用法？

javascript是动态类型语言，this关键字在执行的时候才能确定是哪个对象。但是总有一个原则，那就是this指的是调用函数的那个对象。
* 作为全局变量使用，this指向window。
* 作为对象的方法调用，this通常指向调用它的对象。
* 作为构造函数调用，this就是指这个对象。
* 作为apply或者call调用，this指向第一个参数对象，没有参数时，指向window。
* 在闭包中，this随着运行时的作用域改变而改变。在闭包内部匿名函数中，this通常指向window。

### 理解引用类型传递和值传递
### 多个图片加载，很慢如何处理
### html5有哪些新增的javascript API
### web前端优化
### 快速排序和数组消重
### 理解setTimeOut()作用域的问题


























