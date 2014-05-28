title: 移动Web开发--纯CSS实现的立体按钮
date: 2014-02-18 19:18:23
categories: ['移动开发']
tags: [css]
---

产品经理让弄一个老虎机用作手机客户端积分抽奖，为了节省网络带宽，要求文件大小尽可能小，蛋疼的各种按钮效果不能用图片，都要用样式搞定。

纯CSS实现的立体按钮
---------------------------------------

实现如下按钮效果：

<img src="/images/cont/mobile-web-21.jpg" style="display: block;" />

html结构为：
```sh
<div class="td-yellow">
    <div class="mask"></div>
    <div class="item-wraper">
        <div class="item-cont">
            <p><strong>18</strong></p>
            <p>基金份额</p>
        </div>
    </div>
</div>
```
<!--more-->
对应的样式为：
```sh
.td-yellow .item-wraper {
    width: 100px;
    height: 70px;

    //按钮的底色
    border: 1px solid #b77921;
    border-top: 1px solid #f9e0b7;
    border-radius: 3px;
    background: #db9e48;
}
.td-yellow .item-wraper .item-cont {
    padding-top: 10px;
    height: 55px;
    text-align: center;
    color: #fff;
    font-size: 14px;
    text-shadow: 1px 1px 1px #d29236;

    //按钮的上层颜色，通过margin拉开与底部边距，形成错层已达到按钮效果
    border-bottom: 1px solid #fddb74;
    border-radius: 2px;
    margin-bottom: 4px;
    background: #fddb74;
}
.item-cont p {
    text-align: center;
    color: #fff;
    font-size: 14px;
    text-shadow: 1px 1px 1px #ff384d;
}
.item-cont p strong {
    font-size: 30px;
    line-height: 30px;
}
```

主要是通过结合`border`，`border-radius`，`background`，`margin`等属性相辅完成。

###用border实现多种图形

* 用border实现梯形

原理：利用border相交的角和背景色来实现梯形。如图：

<img src="/images/cont/mobile-web-23.jpg" style="display: block;" />

对应的样式为：

```sh
.angular-shape{
    width:50px;
    height:50px;
    border-width:25px;
    border-style:solid;
    border-color:#da4632 #ffb601 #009c58 #1369ea;
}
```

从上面的图，能看到梯形，但是，从产品到设计，不一定，这样简单的就能符合预期，但是至少梯形的斜边的实现原理可以从这里得到。

如下图，有3D立体效果的按钮，利用上下两层间的梯形，来达到立体效果，这里中间部分是圆角的，所以又不能完全用上面的原理来实现效果，但是原理可以借鉴的。

<img src="/images/cont/mobile-web-22.jpg" style="display: block;" />

html结构为：
```sh
<a id="isBtn" class="try-wraper" target="_self" href="javascript:;" onclick="startOrNot();">
    <div class="try-cont">
        <p class="my-try">我要抽</p>
        <p>还有2次机会</p>
    </div>
    <div class="after-l"></div>
    <div class="after-c"></div>
    <div class="after-r"></div
</a>
```

对应的样式为：
```sh
//从上面的按钮吸收的经验，这个按钮的上半部分
.try-wraper {
    //实现按钮底色
    background: #d94949;
    display: block;
    cursor: pointer;
    width: 102px;
    height: 72px;
    overflow: hidden;
    position: relative;
}
//实现按钮的上半部分的边距和按钮表层的颜色
.try-wraper .try-cont {
    background: #e45a5a;
    margin: 3px 6px 0;
    width: 90px;
    height: 55px;
    border-radius: 3px;
}
.try-wraper .my-try {
    font-size: 15px;
    color: #fff;
    text-shadow: 1px 1px 1px #d22f2f;
    padding-top: 8px;
    font-weight: 700;
    line-height: 20px;
    text-align: center;
}
.try-wraper p {
    color: #fff;
    font-size: 12px;
    line-height: 20px;
    text-align: center;
}
//借鉴上面的原理，实现梯形左斜边框
.after-l {
    position: absolute;
    left: 0;
    bottom: 0;
    height: 0;
    width: 0;
    overflow: hidden;
    font-size: 0;
    line-height: 0;
    border-width: 15px 6px 0 0;
    border-style: solid solid dashed dashed;
    border-color: #d94949 #c63b3b transparent transparent;
}
//梯形中间的矩形
.after-c {
    position: absolute;
    left: 6px;
    bottom: 0;
    height: 15px;
    width: 90px;
    background: #c63b3b;
}
//借鉴上面的原理，实现梯形的右斜边框
.after-r {
    position: absolute;
    right: 0;
    bottom: 0;
    height: 0;
    width: 0;
    overflow: hidden;
    font-size: 0;
    line-height: 0;
    border-width: 15px 0 0 6px;
    border-style: solid dashed dashed solid;
    border-color: #d94949 transparent transparent #c63b3b;
}
```
这个立体效果主要也是用边框`border`实现。

到这里，按钮立体效果完成，多个按钮拼出来的效果如下，就是我们需要的产品：

最后，整体效果为：

<img src="/images/cont/mobile-web-20.jpg" style="display: block;" />

* 用border实现三角形。

原理：利用border相交的角把html元素的宽高变为0，来实现三角形。如图：

<img src="/images/cont/mobile-web-24.jpg" style="display: block;" />

对应的样式为：

```sh
.angular-shape{
    width:0;
    height:0;
    border-width:25px;
    border-style:solid;
    border-color:#da4632 #ffb601 #009c58 #1369ea;
}
```
从上图可知，三角形的雏形已经出来了，只需要再处理它其他3个边框的颜色设为透明或者为背景色即可。

实现红色的三角形：

<img src="/images/cont/mobile-web-25.jpg" style="display: block;" />

对应的样式为：

```sh
.angular-shape{
    width:0;
    height:0;
    border-width:25px;
    border-style:solid dashed dashed dashed;
    border-color: #da4632 transparent transparent transparent;
}
```




总的来说，css嘛，重复，鼓噪，但是不可否认它瘦弱的躯体拥有各种技巧，从这些技巧中提炼出各式各样的神奇视觉效果，在鼓噪中拥抱它吧。





























