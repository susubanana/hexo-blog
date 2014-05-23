title: 移动Web开发--移动端的配置和优化
date: 2014-02-27 20:16:13
categories: [移动开发]
tags: [html5]
---

移动端的配置和优化
------------------------

###视口宽度设置为匹配设备可视宽度

```sh
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
    <!-- 视口宽度设置为匹配设备可视宽度 -->
    <meta name="viewport" content="width=divice-width,initial-scale=1.0">
</head>
<body>
	<header>
		移动开发
	</header>
	<section>
		<p>TEST MOBILE</p>
	</section>
	<footer>
	</footer>
</body>
</html>
```

###iphone下全屏模式启动
<!--more-->
```sh
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
    <!-- 视口宽度设置为匹配设备可视宽度 -->
    <meta name="viewport" content="width=divice-width,initial-scale=1.0">
    <!-- 当web应用从界面图标启动时，以全屏模式启动，隐藏浏览器顶部的工具栏、地址栏和底部的加载状态栏 -->
    <meta name="apple-mobile-app-capable" content="yes" />
    <!-- 在浏览器顶部显示状态栏 -->
    <meta name="apple-mobile-app-status-bar-style" content="black" />
    <!-- 程序启动时，显示一个预加载图片 -->
    <link rel="apple-touch-startup-image" href="path/to/img" />
</head>
<body>
	<header>
		移动开发
	</header>
	<section>
		<p>TEST MOBILE</p>
	</section>
	<footer>
	</footer>
</body>
</html>
```

###禁用或限制部分webkit特性

在移动版浏览器上，经常会遇到一些与设备相关的问题，可以用CSS技术来解决。

修改点击后的背景颜色

```sh
<style>
a{
    -webkit-tap-highlight-color: #F8BE06;
}
</style>
```

让文本内容可编辑，-webkit-appearance属性

使用方法：

```sh
.elementClass{
   -webkit-appearance: value;
   -moz-appearance:    value;
   appearance:         value;
}
```
value分别可为：button以按钮的风格渲染、listbox以listbox风格渲染、listitem以listitem风格渲染、以searchfield风格渲染、textarea以textarea风格渲染、menulist以menulist风格渲染。

以按钮渲染为例：

```sh
.elementClass{
   -webkit-appearance: button;
   -moz-appearance: button;
   appearance: button;
}
```

为狭窄的屏幕添加省略号功能

```sh
.ellipsis{
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}
```