title: Web开发--谈谈对hasLayout的理解
date: 2013-12-20 20:04:21
categories: [web开发]
tags: [css]
---

###什么是hasLayout

> haslayout 是Windows Internet Explorer渲染引擎的一个内部组成部分。在InternetExplorer中，一个元素要么自己对自身的内容进行计算大小和组织，要么依赖于父元素来计算尺寸和组织内容。为了调节这两个不同的概念，渲染引擎采用了 hasLayout 的属性，属性值可以为true或false。当一个元素的 hasLayout属性值为true时，我们说这个元素有一个布局（layout）

**hasLayout 在IE8+版本中已经被抛弃，所以只需针对IE8以下的浏览器为某些元素触发hasLayout。**

###如何触发hasLayout
<!--more-->
当IE6/7效果和标准浏览器不符时，都可以通过激发元素的 haslayout 属性来修正。设置如下任一个样式，可触发hasLayout：

```sh
display: inline-block
height: (除 auto 外任何值)
width: (除 auto 外任何值)
float: (left 或 right)
position: absolute
writing-mode: tb-rl
zoom: (除 normal 外任意值)
min-height: (任意值)
min-width: (任意值)
max-height: (除 none 外任意值)
max-width: (除 none 外任意值)
overflow: (除 visible 外任意值，仅用于块级元素)
overflow-x: (除 visible 外任意值，仅用于块级元素)
overflow-y: (除 visible 外任意值，仅用于块级元素)
position: fixed
```

一般情况下，当IE6/7效果和标准浏览器不符时，常用的方法是给某元素的css设定`zoom:1`。使用`zoom:1`是因为大多数情况下，它能在不影响现有环境的条件下激发元素的 haslayout。































