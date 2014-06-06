title: 移动Web开发--响应式设计
date: 2014-03-01 19:12:38
categories: [移动开发]
tags: [响应式设计, css]
---

响应式设计
---------------------

网页设计应该能够自动进行调整，不应该针对用户分类，去定制无数的解决方案。响应式设计不关乎屏幕的分辨率，不只是技术的实现，它更像是一种对于设计的全新思维模式。

除了横屏和竖屏两种模式，还需考虑数以百计的屏幕尺寸，很明显，我们不能针对每一种设备都创建定制化的解决方案。

###响应式图片

处理原理：浏览器根据用户终端的屏幕尺寸、分辨率处理后输出适应的图片，如屏幕分辨率320*480，那么我们匹配给它的是宽度应小于320px的图片。如果终端屏幕是高清屏，那么我们就得输出2倍分辨率的图形(宽:640px)；以保证在高清屏下图形的清晰度。

有几种技术可以按比例调整图片：
<!--more-->
* 最流行的方法，**使用`width:100%`简单修复**，其原理是以大尺寸图片进行，不在代码中声明宽度和高度，用CSS来控制图片的相对大小，让浏览器按比例缩放图片。

```sh
img{width: 100%;}
```

问题：图片的分辨率可能会失真，图片太大会导致下载时间过长，若图片为大型设备准备的，在移动设备该考虑重新调整图片大小。

* **Filament Group的响应式图片**，不仅要同比的缩放图片，还要在小设备上降低图片的分辨率。很大的图片在较小屏幕上也不会浪费空间。

大致的原理是，rwd-images.js会检测当前设备的屏幕分辨率，如果是大屏幕设备，则向页面head部分中添加BASE标记，并将后续的图片、脚本和样式表加载请求定向到一个虚拟路径“/rwd-router”。当这些请求到达服务器端，.htacces文件会决定这些请求所需要的是原始图片还是小尺寸的“响应式图片”，并进行相应的反馈输出。对于小屏幕的移动设备，原始尺寸的大图片永远不会被用到。

<img src="/images/cont/mobile-web-70.jpg" style="display:block;" />

这个技术的实现需要使用几个相关文件，我们可以在Github上[Responsive-Images](https://github.com/filamentgroup/Responsive-Images)获取。包括一个JavaScript文件(rwd-images.js)，一个.htaccess文件，以及一些范例资源文件。具体使用方法可以参考Responsive Images的[说明文档](https://github.com/filamentgroup/Responsive-Images#readme)。

* **禁用iPhone中的图片自动缩放**

iPhone或iPod Touch的页面会被自动的同比例缩小至最适合屏幕大小的尺寸，x轴不会产生滚动条，用户可以上下拖拽浏览全部页面，或在需要的时候放大页面的局部。这里会产生一个问题，即使我们运用响应式Web设计的思想，专门为iPhone的小屏输出小图片，它同样会随着整个页面一起被同比例缩小，如下图左侧所示。

<img src="/images/cont/mobile-web-71.jpg" style="display:block;" />

我们可以使用苹果专有的一些meta标记来解决类似的问题。在页面的<head>部分添加以下代码：

```sh
<meta name="viewport" content="width=device-width; initial-scale=1.0">
```

将initial-scale的值设定为“1”，即可覆写默认的缩放方式，保持原始的尺寸及比例。

###响应式布局

当页面所需要适应的不同设备的屏幕尺寸差异过大时，除了图片方面，我们也应该考虑到整个布局的调整。可使用独立的样式表，或者更有效的，使用CSS media query。大部分样式保持或和原来一样，特定的元素会继承这些样式，并去掉浮动float、宽度width和高度等height的设置来改变位置。

<img src="/images/cont/mobile-web-72.jpg" style="display:block;" />

实现响应式布局的几种方式：

* **创建多个样式表**，以适应不同设备屏幕的宽度范围或横屏竖屏设置。

```sh
//屏幕宽度小于或者等于480px加载shetland.css
<link rel="stylesheet" type="text/css" media="screen and (max-device--width: 480px)" href="shetland.css">
```
* **把多个媒体查询放到一个单独的样式表中**，这是使用最有效率的。

```sh
//浏览器或屏幕宽度超过640px时才会有效
@media screen and (min-width: 640px) {
     .hereIsMyClass {
          width: 30%;
          float: right;
     }
}
```

```sh
//浏览器或屏幕宽度小于640px时才会有效
@media screen and (max-width: 640px) {
     .aClassforSmallScreens {
          clear: both;
          font-size: 1.3em;
     }
}

```

可以看到，通过min-width的设置，我们可以在浏览器窗口或设备屏幕宽度高于这个值的情况下，为页面指定一个特定的样式；max-width则反之。

媒体查询组合一起可以对一个范围内进行设置

```sh
//浏览器或屏幕宽度大于800，小于1200px时才会有效
@media screen and (min-width: 800px) and (max-width: 1200px) {
     .classForaMediumScreen {
          background: #cc0000;
          width: 30%;
          float: right;
     }
}
```

通过media queries作用于某种特定的设备，而忽略其上运行的浏览器是否由于没有最大化而在尺寸上与设备屏幕尺寸产生不一致的情况。这时，我们需要使用min-device-width与max-device-width，用来判断设备本身的屏幕尺寸。

```sh
@media screen and (max-device-width: 480px) {
     .classForiPhoneDisplay {
          font-size: 1.2em;
     }
}
```
```sh
@media screen and (min-device-width: 768px) {
     .minimumiPadWidth {
          clear: both;
          margin-bottom: 2px solid #ccc;
     }
}
```

```sh
//设备宽度320px
@media only screen and (max-device-width:320px){
	selector{ ... }
}

// 设备宽度480px
@media only screen and (min-device-width:321px) and (max-device-width:480px){
	selector{ ... }
}

// 设备宽度640px
@media only screen (min-device-width:481px)and (max-device-width:640px){
	selector{ ... }
}
```

还有其他的media queries可以指定某些指定的设备，如iphone（Retina显示屏）、ipad。

对于iPad来说，orientation属性尤其有用。它的值可以是landscape(横屏)或portrait(竖屏)。

```sh
@media screen and (orientation: landscape) {
     .iPadLandscape {
          width: 30%;
          float: right;
     }
}
```

```sh
@media screen and (orientation: portrait) {
     .iPadPortrait {
          clear: both;
     }
}
```
这个属性目前确实只在iPad上有效。对于其他可以转屏的设备，譬如iPhone，可以使用min-device-width和max-device-width来变通实现。


* **响应式另一途径javascript**

当某些旧设备无法完美支持CSS3的媒体查询时，JavaScript也是我们的武器之一。已经有专门的JS库来帮助旧浏览器(IE 5+，Firefox 1+，Safari 2等)支持CSS3的media queries。使用方法很简单，下载[css3-mediaqueries.js](http://code.google.com/p/css3-mediaqueries-js/)并在你的页面中调用它。

```sh
//使用jquery代码检测浏览器宽度
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(window).bind("resize", resizeWindow);
        function resizeWindow(e){
            var newWindowWidth = $(window).width();

            // If width width is below 600px, switch to the mobile stylesheet
            if(newWindowWidth < 600){
                $("link[rel=stylesheet]").attr({href : "mobile.css"});
            } else if(newWindowWidth > 600){
                $("link[rel=stylesheet]").attr({href : "style.css"});
            }
        }
    });
</script>
```













