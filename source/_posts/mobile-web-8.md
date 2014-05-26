title: 移动Web开发--Retina分辨率的像素处理
date: 2014-03-02 17:19:58
categories: [移动开发]
tags: [响应式设计]
---

苹果的新产品中已经使用了Retina(视网膜)技术。这是一种新的屏幕的显示技术，声称人类的肉眼将无法区分单个像素。这个技术得到了更多人的亲眯，因为给画面带来了前所未有的清晰平滑效果。但是Web开发人员和设计者为了确保用户得到最好的视觉体验，Retina还是给开发带来了些小麻烦。

Retina分辨率的像素处理
---------------------

###理解像素

**CSS像素**

>CSS像素是一个抽象的单位，主要使用在浏览器上，用来精确的度量（确定）Web页面上的内容。一般情况下，CSS像素被称为与设备无关的像素（device-independent像素），简称为“DIPs”。在一个标准的显示密度下，一个CSS像素对应着一个设备像素。

```sh
<div height="200" width="300"></div>
```
上面的代码，将会在显示屏设备上绘制一个200x300像素的盒子。但是在Retina屏幕下，相同的div却使用了400x600设备像素，保持相同的物理尺寸显示，导致每个像素点实际上有4倍的普通像素点，如图所示：
<!--more-->
<img src="/images/cont/mobile-web-81.jpg" style="display:block;" />

也就是说：一个CSS像素点实际分成了四个，这样就造成了颜色只能**近似选取**，于是，我们看上去就变得模糊了。

以MacBook Pro with Retina Display[3]为例，工作时显卡渲染出2880×1800个像素，其中每四个像素一组，输出原来屏幕的一个像素显示的大小区域内的图像。这样一来，用户所看到的图标与文字的大小与原来的1440×900分辨率显示屏相同，但精细度是原来的4倍…由四个像素代替原来一个像素。这样就会造成普通图片在Retina屏幕上显示模糊：

<img src="/images/cont/mobile-web-80.jpg" style="display:block;" />

**位图像素**

位图是由像素（Pixel）组成的，像素是位图最小的信息单元，存储在图像栅格中(PNG, JPG, GIF等等)。每个像素都具有特定的位置和颜色值。按从左到右、从上到下的顺序来记录图像中每一个像素的信息。

当一个图像在标准设备下全屏显示时,一位图像素对应的就是一设备像素,导致一个完全保真的显示。因为一个位置像素不能进一步分裂，当在Retina屏幕下时，他要放大四倍来保持相同的物理像素的大小，这样就会丢失很多细节，造成失真的情形。换句话说，每一位图像素被乘以四填补相同的物理表面在视网膜屏幕下显示。

<img src="/images/cont/mobile-web-82.jpg" style="display:block;" />

**如何解决普通图片在Retina屏幕下模糊的问题？**

###使用HTML/CSS

* 图片的原始大小不能是200×300像素，而需要2倍高宽，即400×600像素，再通过CSS样式或HTML属性将其压缩50%。普通屏幕下的图像被压缩，减少像素取样（只是位图含像素的四分之一），这样就造成了资源浪费。同时把这个过程称为＂Downsampled＂。

<img src="/images/cont/mobile-web-83.jpg" style="display:block;" />

有几种方法可以实现这样的效果：

1. 使用HTML
```sh
<img src="example@2x.jpg" width="200" height="300" />

```
2. 使用CSS
```sh
.image {
  background-image: url(example@2x.png);
  background-size: 200px 300px;
  height: 300px;
  width: 200px;
}
```

3. 使用JavaScript
```sh
$(window).load(function() {
  var images = $('img');
  images.each(function(i) {
    $(this).width($(this).width() / 2);
  });
});
```

上面通过三种方法实现，非Retina屏幕下必须下载更大的图片资源，造成了一定的资源浪费，Downsampled图像在不同的分辨下可能会失去一定的清晰度，另外，background-size在IE９以下浏览器不能得到友好支持

###使用CSS Media Queries

可以通过“device-pixel-ratio”属性或者其扩展属性“min-device-pixel-ratio”和“max-device-pixel-ratio”。这几个Media Queries可以使用background-image为Retina准备高精密度像素的图片。

先了解设备像素比devicePixelRatio：
>window.devicePixelRatio是设备上物理像素和设备独立像素(device-independent pixels (dips))的比例。
 公式表示就是：window.devicePixelRatio = 物理像素 / dips

所有非视网膜屏幕的iphone在垂直的时候，宽度为320物理像素。当你使用<meta name="viewport" content="width=device-width">的时候，会设置视窗布局宽度（不同于视觉区域宽度，不放大显示情况下，两者大小一致，见下图）为320px, 于是，页面很自然地覆盖在屏幕上。

<img src="/images/cont/mobile-web-84.jpg" style="display:block;" />

这样，非视网膜屏幕的iphone上，屏幕物理像素320像素，独立像素也是320像素，因此，window.devicePixelRatio等于1.

而对于视网膜屏幕的iphone，如iphone4s, 纵向显示的时候，屏幕物理像素640像素。同样，当用户设置<meta name="viewport" content="width=device-width">的时候，其视区宽度并不是640像素，而是320像素，这是为了有更好的阅读体验 – 更合适的文字大小。
这样，在视网膜屏幕的iphone上，屏幕物理像素640像素，独立像素还是320像素，因此，window.devicePixelRatio等于2.


**Retian屏幕和普通屏幕**

```sh
@media only screen and (min-width: 320px) {

  /* Small screen, non-retina */
  background: url(sprite.png) no-repeat 0 -100px;

}

@media
only screen and (-webkit-min-device-pixel-ratio: 2) and (min-width: 320px),
only screen and (min--moz-device-pixel-ratio: 2) and (min-width: 320px),
only screen and (-o-min-device-pixel-ratio: 2/1) and (min-width: 320px),
only screen and (min-device-pixel-ratio: 2) and (min-width: 320px),
only screen and (min-resolution: 192dpi) and (min-width: 320px),
only screen and (min-resolution: 2dppx) and (min-width: 320px) {

  /* Small screen, retina, stuff to override above media query */
  /* Reference the @2x Sprite */
  background-image: url(sprite@2x.png);
  /* Translate the @2x sprite's dimensions back to 1x */
  background-size: 200px 200px;

}

@media only screen and (min-width: 700px) {

  /* Medium screen, non-retina */

}

@media
only screen and (-webkit-min-device-pixel-ratio: 2) and (min-width: 700px),
only screen and (min--moz-device-pixel-ratio: 2) and (min-width: 700px),
only screen and (-o-min-device-pixel-ratio: 2/1) and (min-width: 700px),
only screen and (min-device-pixel-ratio: 2) and (min-width: 700px),
only screen and (min-resolution: 192dpi) and (min-width: 700px),
only screen and (min-resolution: 2dppx) and (min-width: 700px) {

  /* Medium screen, retina, stuff to override above media query */

}

@media only screen and (min-width: 1300px) {

  /* Large screen, non-retina */

}

@media
only screen and (-webkit-min-device-pixel-ratio: 2) and (min-width: 1300px),
only screen and (min--moz-device-pixel-ratio: 2) and (min-width: 1300px),
only screen and (-o-min-device-pixel-ratio: 2/1) and (min-width: 1300px),
only screen and (min-device-pixel-ratio: 2) and (min-width: 1300px),
only screen and (min-resolution: 192dpi) and (min-width: 1300px),
only screen and (min-resolution: 2dppx) and (min-width: 1300px) {

  /* Large screen, retina, stuff to override above media query */

}
```

这种方式只能通过HTML元素的背景图片来实现，没有语义。

这些解决方法都有利有弊，一切在于权衡。















