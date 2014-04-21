title: 用hexo搭建博客--博客主题的配置
date: 2013-11-19 19:30:49
tags: [hexo]
---

本文记录博客的配置，主要是针对博客主题的配置。

博客主题的配置
------------------

找到`hexo\themes\_config.yml`文件

<!--more-->

```sh
# menu 站点的导航，左边是导航文字显示，右边是导航链接
menu:
  首页: /
  web开发: /webdevelop
  移动开发: /mobiledevelop
  nodejs: /nodejsdevelop
  项目: /mycase
  杂谈: /mylife
  关于我: /aboutme

#widgets 右侧栏显示的模块
widgets:
- category
- about_me
- tag
- recent_posts
- links

# 这里将英文改成阅读全文
excerpt_link: 阅读全文

twitter:
  username:
  show_replies: false
  tweet_count: 5

#SNS分享，身在天朝，当然用“百度分享”
addthis:
  enable: true
  pubid:
  facebook: true
  twitter: true
  google: true
  pinterest: true

fancybox: true

google_analytics:
rss:

#这里是右侧栏信息设置，后面介绍修改及使用
about_me:
  title: 关于我
  pic: /images/girl.jpg
  name: susubanana
  texts:
  - 专注前端领域，但是不仅专注前端
  - 熟悉html/html5、css2/css3、javascript、jquery、coffeescript、nodejs

links:
- name: 树莓派的奇幻漂流
  link: http://www.codeforfun.info/

comment_provider: facebook
# Facebook comment
facebook:
  appid: 123456789012345
  comment_count: 5
  comment_width: 840
  comment_colorscheme: light
```













