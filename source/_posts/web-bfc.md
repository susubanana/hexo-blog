title: Web开发--谈谈对BFC的理解
date: 2013-12-20 17:41:12
categories: [web开发]
tags: [css]
---

###什么是BFC

> BFC的全名是block formatting context，转成中文就是块级元素格式上下文。它决定了元素如何对其内容进行定位，以及与其他元素的关系和相互作用。当涉及到可视化布局的时候，Block Formatting Context提供了一个环境，HTML元素在这个环境中按照一定规则进行布局。一个环境中的元素不会影响到其它环境中的布局。

通俗来理解，一个BFC就是一个箱子，在同一个BFC内，箱子子会一个挨着一个的摆放，相邻箱子的左右间距是由margin决定而垂直方向的margin会重叠，每一个箱子的左外边缘（margin-left）会触碰到容器的左边缘(border-left)（对于从右到左的格式来说，则触碰到右边缘）。而浮动`float`和清除浮动`clear`也只对同一个BFC内的元素有效。

深入点理解BFC的特性：

**边缘不和浮动元素重叠**，因为元素触发了BFC的话，就不会被float元素覆盖，如下：

不触发BFC，内容不多，符合预期：
<img src="/images/cont/web-bfc-0.jpg" style="display:block;" />
<!--more-->
不触发BFC，内容增多：
<img src="/images/cont/web-bfc-01.jpg" style="display:block;" />

触发BFC：

<img src="/images/cont/web-bfc-02.jpg" style="display:block;" />

**不存在collapsing margins问题**，margin不会叠加的特性，可以理解为两个处于普通流的盒子，会有margin叠加的问题，是因为他们属于相同的BFC，当他自身创建了一个新的BFC时，这个问题就不存在了。

不触发BFC：
<img src="/images/cont/web-bfc-03.jpg" style="display:block;" />

触发BFC：
<img src="/images/cont/web-bfc-04.jpg" style="display:block;" />

###如何生成BFC

当一个HTML元素满足下面任一条件，就会产生一个BFC：

* float的值不为none。
* overflow的值不为visible。（hidden，auto，scroll ）
* display的值为table-cell, table-caption, inline-block中的任何一个。
* position的值不为relative和static。（absolute，fixed）
* 早期IE的hasLayout会触发一个新的BFC

###BFC的使用

* 不和浮动元素重叠

如果一个浮动元素后面跟着一个非浮动的元素，那么就会产生一个覆盖的现象。

html结构为：

```sh
<div>
    <span class="icons fl">
        <img src="http://i.thsi.cn/images/ifund/market/wednesday/ajj-download.jpg" style="display: block;">
    </span>
    <dl class="ths-weibo">
        <dt>官方微信：</dt>
        <dd>同花顺基金销售</dd>
        <dd>扫描二维码添加</dd>
        <dd>同花顺基金销售</dd>
        <dd>扫描二维码添加</dd>
    </dl>
</div>
```

对应的样式：

```sh
.cont-list-0 .icons {
    float: left;
    display: inline;
    margin-right: 15px;
}
.cont-list-0 .ths-weibo {
    font-size: 14px;
}
```
效果为：
<img src="/images/cont/web-bfc-01.jpg" style="display:block;" />

不触发BFC，右边的dl会包住左浮动的图片，用`overflow:hidden;zoom:1;`触发BFC，如下：

对应的样式：

```sh
.cont-list-0 .icons {
    float: left;
    display: inline;
    margin-right: 15px;
}
.cont-list-0 .ths-weibo {
    overflow:hidden;
    zoom:1;
    font-size: 14px;
}
```

效果为：
<img src="/images/cont/web-bfc-02.jpg" style="display:block;" />

* 清除元素内部浮动

把父元素设为BFC就可以清理子元素的浮动。

不触发BFC：

html结构为：
```sh
<div class="sub_wraper_2 mt20">
    <div class="sub_cont_0 fl"></div>
    <div class="sub_cont_0 fr"></div>
</div>
```
对应的样式：
```sh
.fl {
    float: left;
    display: inline;
}
.fr {
    float: right;
    display: inline;
}
.sub_wraper_2 {
    width: 100%;
}
.sub_wraper_2 .sub_cont_0 {
    width: 380px;
}
```
效果为：
<img src="/images/cont/web-bfc-05.jpg" style="display:block;" />

触发BFC：

对应的样式：
```sh
.fl {
    float: left;
    display: inline;
}
.fr {
    float: right;
    display: inline;
}
.sub_wraper_2 {
    width: 100%;
    overflow:hidden;
    zoom:1;
}
.sub_wraper_2 .sub_cont_0 {
    width: 380px;
}
```
效果为：
<img src="/images/cont/web-bfc-06.jpg" style="display:block;" />

* 解决相邻两个元素垂直方向重叠的问题

html结构为：
```sh
<p class="free_register">
    <a href="#">免费开户</a>
</p>
<p class="login">
    <a href="#">交易登录</a>
</p>
```
对应的样式：
```sh
.free_register, .login{
    margin: 34px 0 0 29px;
}
.free_register a, .login a{
    background: url(http://i.thsi.cn/images/ifund/market/market_sprite.png) no-repeat scroll 0 0 transparent;
    width: 141px;
    height: 40px;
    display: block;
    text-indent: -9999px;
}
.free_register a{
    background-position: 0 0;
}
.login a{
    background-position: 0 -41px;
}
```
不触发BFC：

对应的样式：
```sh
.free_register, .login{
    margin: 34px 0 0 29px;
}
.free_register a, .login a{
    background: url(http://i.thsi.cn/images/ifund/market/market_sprite.png) no-repeat scroll 0 0 transparent;
    width: 141px;
    height: 40px;
    display: block;
    text-indent: -9999px;
}
.free_register a{
    background-position: 0 0;
}
.login a{
    background-position: 0 -41px;
}
```
效果为：
<img src="/images/cont/web-bfc-03.jpg" style="display:block;" />

触发BFC：

对应的样式：
```sh
.free_register, .login{
    clear: both;
    float: left;
    display: inline;
    margin: 34px 0 0 29px;
}
.free_register a, .login a{
    background: url(http://i.thsi.cn/images/ifund/market/market_sprite.png) no-repeat scroll 0 0 transparent;
    width: 141px;
    height: 40px;
    display: block;
    text-indent: -9999px;
}
.free_register a{
    background-position: 0 0;
}
.login a{
    background-position: 0 -41px;
}
```
效果为：
<img src="/images/cont/web-bfc-04.jpg" style="display:block;" />












