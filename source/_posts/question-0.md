title: 热身运动
date: 2014-06-09 10:40:46
categories: [杂谈]
tags: [interview]
---

http协议
-------------------------

### http协议状态有哪些?

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
<!--more-->
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

html
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

**strong与em标莶语义化**

* `<b>`标签在HTML仅仅表示粗体这个样式，`<i>`仅仅表示斜体，并没有附加的一些情感在里面。
* `<strong>`则不只是粗体的样式、更是提现一种逻辑判断，有强调的作用。
* `<em>`斜体，em更突显句意，在句子中强调的是哪一部分，而strong则更突显内容的重要性

**article与section标莶语义化？**

* article：页面或应用程序中独立的、完整的，可以单独被外部引用的内容，可以是文章、博客、帖子、评论或者一个独立插件；
* section：对页面或应用程序的内容进行分块，一般由标题与内容组成；
    section不宜滥用的情况：
    * 不要将section元素用作设置样式的页面容器，那是div元素的工作。
    * 如果article元素、aside元素或nav元素更符合使用条件，不要使用section元素。
    * 不要为没有标题的内容区块使用section元素。

pre 元素可定义预格式化的文本。被包围在 pre 元素中的文本通常会保留空格和换行符。
fieldset 元素可将表单内的相关元素分组。

在HTML5中，article元素可以看成是一种特殊类型的section元素，它比section元素更强调独立性。即section元素强调分段或分块，而article强调独立性。具体来说，如果一块内容相对来说比较独立的、完整的时候，应该使用article元素，但是如果你想将一块内容分成几段，一般带标题的时候，应该使用section元素。另外，在HTML5中，当使用CSS样式的时候，应该使用div。

### 如何理解网站重构
使html语义化、与css样式、javascript分离，使页面加载更加快速，并易于被搜索引擎收录，代码可维护性强，可复用性强。

css
---------------------
### CSS选择符有哪些？哪些属性可以继承？优先级？内联和important哪个优先级高？

* Class 可继承
* 伪类A标签可以继承
* 列表 UL LI DL DD DT 可继承
* 优先级就近原则，样式定义最近者为准
优先级为
!important > 内联样式 > [ id > class > tag ]

### 对渐进增强与平稳退化（优雅降级）的理解
向上增强叫做渐进增强，向下兼容叫优雅降级。
优雅降级：
设计师针对最好的浏览器设计，并能保证css3各种层面的代码在较老的浏览器上剥离时，用户还能获得一种可用的体验。也就是说能否支持更好的体验在于浏览器的能力。

渐进增强：
先构建支持更低级别浏览器的网站，然后使用css3对那些能力更强的浏览器来增强体验。

对比两者，优雅降级是从能利用css3的大部分能力的浏览器出发，优雅降级到缺乏支持的老浏览器上。渐进增强是从基于兼容的标准最为基线，再针对支持css3的浏览器增加css3代码。

典型的实践路径是先使用css3实现一个特性，再使用css2.1，最后使用针对遗留的浏览器使用的hack。若是有足够的理由，可以用渐进增强的路径，先使用css2.1,再使用css3。

### 双飞翼
1. 最外围模块： float: left;position: relative;
2. 中间模块自适应： float:left;width: 100%;中间模块里面的模块：margin：0 rightWidth 0 leftWidth;
3. 最左边模块： float: left;margin-left: -100%;position: relative;
4. 最右边模块： float: left;margin-left: rightWidth;position: relative;

### IEhack

* `\9` `background:red\9; //IE6 - IE10背景变红色`
* `*` `*background:red; //IE6 - IE7背景变红色`
* `_` `_background:red; //IE6背景变红色`
* 条件注释判断浏览器
  <!--[if IE]> =所有的IE可识别 <![endif]-->
  <!–[if IE 8]> = IE8 仅IE8可识别 <![endif]-->
  <!–[if lt IE 8]> = IE7或更低版本 <![endif]-->
  <!–[if gte IE 8]> = IE8或更高版本 <![endif]-->
  gt 大于运算符
  lt 小于运算符
  gte 大于或等于运算
  lte 小于或等于运算

### display: inline-block

display: inline-block 后，元素创建了一个行级的块容器，该元素内部（内容）被格式化成一个块元素，同时元素本身则被格式化成一个行内元素。inline-block 的元素既具有 block 元素可以设置宽高的特性，同时又具有 inline 元素默认不换行的特性。

IE 从 5.5 开始就已经支持 display:inline-block，IE6、7 中的 inline-block 更像是 IE 的私有属性值，但是它所支持的 inline-block 不能等同于 CSS2.1 中的 inline-block，因为 IE5.5 比 CSS2.1 更早提出 inline-block 的概念并作为所谓的「私有属性值」使用，所以二者表现出来的效果是不完全一致。

IE 5.5、6、7 中 块级元素对 inline-block 支持不完整，如果要达到类似的效果，需要先设置`*display:inline; zoom: 1;`触发 hasLayout，块级元素触发后是没有水平间隙的。

标准浏览器设置display:inline-block 后，元素会产生水平空隙，这是因为行内元素默认就有空隙存在，所以这并不是 inline-block 后产生的 bug。



```sh
.nav-report .nav-list li {
    font-size: 0;
    letter-spacing: -0.31em; /* webkit: collapse white-space between units */
    *letter-spacing: normal; /* reset IE < 8 */
    word-spacing: -0.43em; /* IE < 8 && gecko: collapse white-space between units */
    margin: 0;
}

.nav-report .nav-list a {
    height: 60px;
    line-height: 60px;
    padding: 0 20px;
    background: red;
    display: inline-block;
    zoom: 1; *display: inline; /* IE < 8: fake inline-block */
    letter-spacing: normal;
    word-spacing: normal;
    vertical-align: top;
}
```

### float与position
在css中有一个z-index属性，因为网页是“立体的”，它有z轴，这个z轴的大小就由z-index控制。所有页面元素均位于z-index:0这一层，在这一层按顺序排列的元素就构成了“文档流”。position和float，它们都是通过改变文档流来实现定位。

**float实际上是将块级元素脱离普通文档流，但还是基于普通文档流**。float属性定位的元素可以向左或向右移动，直到它的外边缘碰到包含元素或另一个浮动元素的边框为止。由于浮动元素脱离普通文档流，所以普通文档流中的块元素表现得就像浮动元素不存在一样。

position有四个值：
1. 静态（static）：

元素顺序显示，在同一个文档流中，静态定位仅仅意味着内容遵循正常从上到下的HTML流。

2. 相对(relative)：

一个相对定位的元素相对它在HTML流中的当前位置而放置。相对定位的元素在原有位置进行偏移，偏移后的位置可能覆盖别人（是漂浮在上方），但它原来的位置也空着。。相对定位的主要用处不是移动一个元素，而是给行内在它内部的绝对定位的元素设定一个新的参考点。

3. 绝对(absolute)：

绝对定位通过指定一个左、右、上或者下的位置来确定一个元素相对于父元素的边界进行定位的的位置。此外 ，绝对定位的元素被完全与普通文档流分离，换句话说，网页上的其他东西甚至不知道这个绝对定位的元素的存在。

4. 固定(fixed)：

一个固定的元素被锁定在屏幕的位置上。fixed是相对浏览器窗口的固定位置定位。

**position:absolute和float会隐式的改变display类型，让元素以display:inline-block的方式显示**，（不论之前是什么类型的元素，display:none除外），可以设置长宽，默认宽度并不占满父元素，就算是显示的设置display:inline或display:block，仍然无效。

**position:relative并不能够隐式的改变display的类型**

### css3比较流行的属性

javascript
-----------------------------
### 理解基本类型和引用类型的值复制与函数的参数传递
基本类型复制：将一个变量赋予给另一个变量，实际上是在变量对象上创建一个新值，然后将该值复制到新变量的分配的位置上。两个变量的值完全独立，两个变量的任何操作不会相互影响。

引用类型复制：将一个引用类型变量的引用复制给新变量分配的内存空间中，复制的是引用类型的引用，这个引用指向堆中同一个对象。改变其中一个变量就会影响另一个变量。

基本类型值的传递是按基本类型变量复制一样，而引用类型传递也是按引用类型变量复制一样，但是作为参数传递的时候，会将这个变量在内存中的地址复制给一个局部变量。而javascript中所有函数的参数都是按值传递的，困惑的是，在访问变量的时候是按值访问还是按引用访问两种方式。




### 理解类型转换
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

### 理解setTimeOut()作用域的问题
在setTimeOut()中，this是指向全局作用域window的。

### html5有哪些新增的javascript API
* 新增了getElementsByClassName()方法，返回带有指定类名的NodeList
* 增加classList属性，可以通过这个属性来进行增`add('类字符串')`、删`remove('类字符串')`、替换类名`toggle('类字符串')`或者查询是否包含类名`contains('类字符串')`。
* 将IE专有的innerHtml和outerHTML纳入html5规范，innerHTML和outerHTML的区别是，返回的值是否包含操作元素本身。


### 页面优化以及提高前端性能
1. 减少dom标签节点，节点越多，意味着JavaScript遍历DOM的效率越慢。
2. 尽量将所有的`<script>`标签放到页面尾部。
3. 使用combo减少http请求数量，或者，页面呈现时所必需首先加载的，哪些内容和结构可以稍后再加载，将可以稍后再加载的javascript延迟加载。
4. 合理使用缓存，如果某个跨作用域的值或者对象属性或者dom集合元素在函数中被访问多次，存储到局部变量中。
5. 减少对dom的访问，将循环计算的操作尽量放在ECMAscript本身处理。
6. 对比getElementById()等返回的是HTML集合，HTML集合与文档一直保持连接，每次需要获取最新信息时，都要重新执行查询过程，querySelectorAll()返回的是NodeList静态列表的类数组对象，不实时对应文档结构，因而不会每次访问时都重新执行查询过程。
7. 减少重绘重排，如合并修改样式，批量修改dom(先隐藏元素，批量修改后，再显示，或针对要修改的节点创建一个副本，先修改副本然后替换旧的节点，最好的方式是在文档之外创建一个文档，针对这个文档操作，然后再将它附加到原始节点中，只操作一次元素节点。)
8. 使用内容分发网络，将网站内容分散到多个、处于不同地域位置的服务器上可以加快下载速度，通过向地理最近的用户传输内容，另外，浏览器同一时间针对同一域名下的请求有一定数量限制（一般10个以内），超过限制数目的请求会被阻止。可以极大减少网络延时。
9. Gzip压缩文件内容，通过设置HTTP请求中有Accept-Encoding文件头的压缩格式。Gzip大概可以减少70%的响应规模。
10. 避免使用滤镜，IE滤镜的问题在于浏览器加载图片时它会终止内容的呈现并且冻结浏览器。在每一个元素（不仅仅是图片）它都会运算一次，增加了内存开支，因此它的问题是多方面的。可以使用PNG8格式来代替。如果确实需要使用AlphaImageLoader，使用下划线_filter又使之对IE7以上版本的用户无效。
11. 优化CSS Sprite，在Sprite中水平排列你的图片，垂直排列会稍稍增加文件大小。Sprite中把颜色较近的组合在一起可以降低颜色数。不要在Spirite的图像中间留有较大空隙。这虽然不大会增加文件大小，但它需要更少的内存来把图片解压为像素地图。100x100的图片为1万像素，而1000x1000就是100万像素。
12. 保持单个内容小于25K，主要是因为iPhone不能缓存大于25K的文件。


### 快速排序和数组消重


数组消重：
```sh
var array = [1, 2, 3, 3, 4];
function hash_unique(array) {
    var o = {};
    for(var i = 0, j = 0; i < array.length; i++) {
        if(typeof o[array[i]] == 'undefined') {
            o[array[i]] = j++;
        }
    }
    array.length = 0;
    for(var k in o) {
        array[o[k]] = k;
    }
    return array;
}
console.log(hash_unique(array));
```

###字符串的操作
* `str.length` 获取字符串的长度
* `str.charAt(index)` 获取字符串的指定位置的字符
* `str.slice(start, end),str.substring(start, end),str.substr(start, num)` 获取字符串的子串，第二个参数可选，只指定start，返回的三个字符串副本一致。指定第二个参数时，前两者返回以start位置开始，end位置结束（不包括end位置字符）的字符串；substr返回的是以start位置开始的num个字符的字符串。
  上面三个方法的第一个参数为负值时，slice和substr会将第一个参数加上字符串的长度作为起始位置，substring会将所有负值参数转为0：假设长度是5，`str.slice(-1)`，`str.substring(-1)`，`str.substr(-1)`会转化为：`str.slice(4)`，`str.substring(0)`，`str.substr(4)`
  上面三个方法的第二个参数为负值时，slice将第二个参数加上字符串的长度作为起始结束位置，substring会将所有负值参数转为0，substr会将第二个参数转为0，所以返回空字符串：假设长度是5，`str.slice(2,-1)`，`str.substring(2, -1)`，`str.substr(2, -1)`会转化为：`str.slice(2, 4)`，`str.substring(2, 0)`，`str.substr(2, 0)`
* `str.indexOf()/str.lastIndexOf()` 查找给定字符串，str.indexOf(string)从开头向后搜索，str.lastIndexOf()是从末尾向前搜索子字符串，返回指定字符串的位置。
* `str.trim()` 删除字符串前缀或者后缀的所有空格。
* `str.toLowerCase()、str.toUpperCase()` 字符串大小写转换
* `str.match()/str.search()` 字符串模式匹配，str.match()只接收一个参数（正则表达式/RegExp对象），返回一个数组。str.search()只接收一个参数（正则表达式/RegExp对象），返回的是第一个匹配项的索引。
* `str.split()`基于指定的分隔符，将一个字符串分割成多个子字符串，并放在一个数组中。
* `str.localeCompare(字符串)` 比较两个字符串是否相等，字符串的首字母在str前面则返回1，相同的字符串则返回0，首字母排在str后面则返回-1。

### 数组的操作

* `toString()/valueOf()/toLocaleString()` 返回将数组中的值的字符串的形式拼接成以`,`分隔的字符串。
* `join(',')` 返回以`,`分隔的字符串。
* `push()/pop()` 分别是将数据项插入数组末端并返回数组的长度/弹出最后一项，并返回该值。
* `push()/shift()/unshift()` 分别是将数据项插入数组末端并返回数组的长度/弹出第一个项，并返回该值/在第一项插入任意项数据，并返回数组长度。
* `sort()/reverse()` 分别是按升序排列/按降序排列，sort会调用数组的toString()把数据项转换为字符串再比较，但结果不是最佳方案，sort()能接收一个函数作为参数。
* `contact()` 是创建当前数组的一个副本，然后将contact括号内的数据项添加在副本数组的末尾，并返回新数组。
* `slice()` 基于当前当前数组一个或者多个项创建一个新数组。slice(1, 4)从位置1开始，到位置3结束，返回第二项到第四项组成的新数组。
* `splice()` 主要用途是向数组中部插入数据项。
  * 删除任意数量的项：`splice(1, 2)` 从第二个位置开始，删除两项，并返回删除后的项组成的新数组。
  * 在指定位置插入数据项：`splice(1, 0, 'ok')` 参数：起始位置，要删除的项的数量，要插入的项，返回空数组。
  * 指定位置中替换任意项：`splice(1, 1, 'ok')` 参数：起始位置，要删除的项的数量，要插入的项，并返回删除后的项组成的新数组。
* `indexOf()/lastIndexOf()`接收两个参数：要查找的项，查找起点位置的索引（可选，没有则从位置0开始查找），`lastIndexOf()` 从数组的末尾开始查找，并返回查找项在数组中的位置。支持的浏览器有IE9+，火狐，safari，谷歌，opera。

### eval()方法
eval方法就是一个完整的javascript解析器，它接收一个参数（要执行的ECMAScript语句或者字符串）。使用eval执行的代码比不使用eval的代码慢100倍以上，使用`eval`，则`eval`中的代码（实际上为字符串）无法预先识别其上下文，无法被提前解析和优化，即无法进行预编译的操作。所以，其性能也会大幅度降低。使用eval方法容易被恶意代码侵入，有安全性隐患。

### javascript操作节点和jquery操作节点（包括位置和事件）

javascript原生创建新节点
```sh
document.createDocumentFragment() //创建一个DOM片段
document.createElement() //创建一个具体的元素
document.createTextNode() //创建一个文本节点
```
jquery创建节点
```sh
var ele = $('<p>创建节点</p>')
````


javascript原生添加、移除、替换、插入
```sh
element.appendChild(newNode) //用于向childNodes列表的末尾添加一个节点，返回要添加的元素节点，若child节点是存在节点则移动到childNodes列表末尾。
element.removeChild(child)
element.replaceChild(newNode, replaceChild) //用于替换节点，接受两个参数，第一参数是要插入的节点，第二个是要替换的节点，返回被替换的节点
element.insertBefore(newNode, indexChild) //用于指定插入位置，接受2个参数，第一个是要插入的节点，第二个是参照节点，节点插入到参照节点的前面，返回要添加的元素节点
element.cloneNode() //用于复制节点，接受一个布尔值参数，true 表示深复制（复制节点及其所有子节点），false 表示浅复制（复制节点本身，不复制子节点）
```

jquery添加、移除、替换、插入
```sh
$(A).append(B) //将B加入到A内部末尾
$(A).appendTo(B) //将A加入到B内部末尾
$(A).prepend(B) //将B加入到A内部开头
$(A).prependTo(B) //将A加入到B内部开头
$(A).after(B) //将B加入到A后面
$(A).insertAfter(B) //将A加入到B后面
$(A).before(B) //将B加入到A前面
$(A).insertBefore(B) //将A加入到B前面

$(A).remove()
$(A).clone()
$(A).replaceWidth()
````

查找
```sh
document.getElementsByTagName() //通过标签名称
document.getElementsByName() //通过元素的Name属性的值
document.getElementById() //通过元素Id，唯一性
document.documentElement //取得html标签
document.body //取得body标签
```

### HTML集合和NodeList的区别
NodeList是一个类数组的静态列表，在访问DOM文档时实时动态查询，也就是文档改变时，都会立即得到更新，始终保持最新最准确的信息，可通过[index]或item(index)访问。
返回NodeList的API：
```sh
element.childNodes
document.querySelectorAll()
```

HTMLCollection 是HTML 元素的集合，在访问DOM文档时实时动态查询，也就是文档改变时，都会立即得到更新，始终保持最新最准确的信息，比NodeList多了一个namedItem()方法，这个方法是通过name属性查找。
返回HTMLCollection的API：

```sh
element.children
document.images
document.forms
document.all
```

IE/火狐返回HTMLCollection，谷歌、opera、safari返回NodeList的API：

```sh
document.getElementsByName()
document.getElementsByTagName()
document.getElementsByClassName()
```

两者因为对文档的实时查询，都有性能方面的考虑，但是querySelectAll返回的NodeList对象，底层实现如同一个快照，不用不断对文档进行动态查询，则避免大多性能方面的考虑。

```sh
document.querySelectorAll() //返回一个nodelist对象，能避免大多数性能问题。
```

### element.childNodes和element.children的区别

`element.childNodes` 它返回指定元素的子元素集合，包括HTML节点，所有属性，文本，IE8及以下版本会返回html节点，IE8+会返回具体节点类型。只有当nodeType==1时才是元素节点，2是属性节点，3是文本节点。

`element.children` 只返回html元素的节点，除此之外和childNodes没什么区别。IE8及以下版本也会包含注释节点（无注释则返回元素节点）。其他浏览器均返回元素节点。

### jquery中一些API的实现原理，如：on、bind、delegate、live的区别和实现原理，ready实现机制。
### ECMAScript5增加了哪些API
### 如何解决回调层级过深的问题
### Ajax跨域的几种方法以及每种方法的原理
### 当需要更新一个ui节点下的1000个li节点的某个属性时候该怎么做才能保证页面性能
### 多个图片加载，很慢如何处理
图片懒加载
http://blog.wakao.me/index.php/page/2

### 什么是哈希表？
### 请指出Javascript宿主对象和内置对象的区别？
### JavaScript的模板系统
### 什么是FOUC？如何来避免FOUC

以无样式显示页面内容的瞬间闪烁,这种现象称之为文档样式短暂失效(Flash of Unstyled Content),简称为FOUC。
原因大致为：
1. 使用import方法导入样式表。
2. 将样式表放在页面底部
3. 有几个样式表，放在html结构的不同位置。

原理：当样式表晚于结构性html加载，当加载到此样式表时，页面将停止之前的渲染。此样式表被下载和解析后，将重新渲染页面，也就出现了短暂的花屏现象。

















