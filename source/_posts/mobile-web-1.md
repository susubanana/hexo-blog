title: 移动Web开发--text-size-adjust属性
date: 2014-02-17 18:22:38
categories: [移动开发]
tags: [css]
---

text-size-adjust属性
---------------------------------------

> 这个属性用来设定文字大小是否根据设备(浏览器)来自动调整显示大小。有三种属性值：
* `none` 字体大小不会自动调整
* `auto` 默认属性值，字体大小会根据设备/浏览器来自动调整
* `percentage` 字体显示的大小（百分比）

###Chrome不支持12px以下字体的解决方案
<!--more-->
**中文PC桌面版Chrome 27正式取消了-webkit-text-size-adjust属性的支持，实际上是修正了原有的bug**（该属性本职是用于mobile的，桌面版webkit支持它，这是一个bug）。目前定义该属性在Chrome调试窗口会显示`Unknown property name`警告，所有字号最小为12px。

为实现字体字号小于12px的需求，解决方案为：

```sh
p{
    font-size: 6px;
    -webkit-transform: scale(0.5);
}
```
但是，网页在三种浏览器的有不同表现：

1. Chrome下启用了缩放，所以字符间距出现问题，影响美观，这时候可以用js判断为Chrome后再用CSS属性letter-spacing去修复；
2. Firefox不认识-webkit，所以表现正常，6px；
3. Opera 内核暂未更换为webkit，但是已能够识别-webkit-前缀了，而且在检查元素时还抹掉了前缀，但又能够显示12px以下的字号，结果变成了9×0.75，影响了肉眼的识别。

因而，改进方案为：

```sh
p{
    font-size: 6px;
    -webkit-transform: scale(0.5);
    -o-transform: scale(1);    //针对能识别-webkit的opera设置
}
```

###避免iOS/Windows mobile字体大小的重置

据说该属性最初专门是为iPhone版safari设计的，用来自动调整普通网页在iPhone手机端字体的展现问题。

**移动端chrome/safari目前依然支持-webkit-text-size-adjust属性**。

另外，iPhone和iPad的默认设定是不一样的：

iPhone默认设定 -webkit-text-size-adjust: auto;

iPad默认设定 -webkit-text-size-adjust: none;

所以，当iPhone从竖屏模式切换到横屏模式时，页面字体会放大。针对这个问题，可以用如下代码：

```sh
html{
    -webkit-text-size-adjust: none;
    -ms-text-size-adjust: none;
    text-size-adjust: none;
}
```
> 优点：告诉webkit引擎在渲染页面时不要自动调整字体大小
> 缺点：对于旧版本支持该属性的PC端浏览器或者非移动客户端访问，这个设置仍会导致页面的缩放功能被禁用，对于有视觉障碍的浏览者非常不友好。

为了防止缩放功能被禁用，可以用-webkit-text-size-adjust: 100%代替;

因而，改进方案为：

```sh
html{
    -webkit-text-size-adjust: 100%;
    -ms-text-size-adjust: 100%;
    text-size-adjust: 100%;
}
```































