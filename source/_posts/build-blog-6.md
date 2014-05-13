title: 用hexo搭建博客--博文技巧
date: 2013-11-21 19:25:26
categories: [项目]
tags: [hexo]
---

做了那么多准备工作，实在很急啊，很想写几篇博文过过瘾，验收一下辛苦建站的成果。

创建博文
----------------
在hexo文件夹下，敲入`hexo n 博文名称`或`hexo new 博文名称`，找到`\hexo\source\_posts文件夹`，接着用markdown语法写博文

```sh
hexo n my-first-blog
```

显示摘要
----------------
在博文合适位置，使用`<!--more-->`就可将文章分割。

<!--more-->

实时预览
----------------
老是F5，或者点击浏览器刷新也挺烦的，hexo作者编写了[hexo-livereload](https://github.com/hexojs/hexo-livereload)，安装如下：

* 安装 hexo-liveReload，`npm install -g hexo-livereload`。
* 還要搭配浏览器插件才能正常运作。由於我所使用的是google chrome，因此得安裝這個google chrome extension：[LiveReload Extension](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei/related)。
* 敲入`hexo s`会启动实时监听

>livereload不仅仅跨平台，而且是开源的，提供自动编译Less、Stylus或集成Sublime Text等编辑器的插件。






