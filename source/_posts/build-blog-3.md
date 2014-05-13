title: 用hexo搭建博客--博客站点的配置
date: 2013-11-19 19:10:38
categories: [项目]
tags: [hexo]
---

博客站点的配置
------------------

找到`hexo\_config.yml`文件

<!--more-->

```sh
# Hexo Configuration
## Docs: http://zespia.tw/hexo/docs/configuration.html
## Source: https://github.com/tommy351/hexo/

# Site
title: no forget //博客首页title
subtitle: //博客的副标题
description: //博客的描述
author: dancing waves //博主名称
email: susubanana@163.com //博主邮箱
language: ZH-TW //用中文

# URL 域名配置
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: http://yoursite.com
root: /
permalink: :year/:month/:day/:title/
tag_dir: tags
archive_dir: archives
category_dir: categories
code_dir: downloads/code

# Directory  不修改
source_dir: source
public_dir: public

# Writing 文章布局、写作格式的定义，不修改
new_post_name: :title.md # File name of new posts
default_layout: post
auto_spacing: false # Add spaces between asian characters and western characters
titlecase: false # Transform title into titlecase
external_link: true # Open external links in new tab
max_open_file: 100
multi_thread: true
filename_case: 0
render_drafts: false
post_asset_folder: false
highlight:
  enable: true
  line_number: true
  tab_replace:

# Category & Tag  不修改
default_category: uncategorized
category_map:
tag_map:

# Archives 默认值为2，这里都修改为1，相应页面就只会列出标题，而非全文
## 1: Enable pagination
## 1: Disable pagination
## 0: Fully Disable
archive: 1
category: 1
tag: 1

# Server 不修改
## Hexo uses Connect as a server
## You can customize the logger format as defined in
## http://www.senchalabs.org/connect/logger.html
port: 4000
server_ip: 0.0.0.0
logger: false
logger_format:

# Date / Time format  不修改
## Hexo uses Moment.js to parse and display date
## You can customize the date format as defined in
## http://momentjs.com/docs/#/displaying/format/
date_format: MMM D YYYY
time_format: H:mm:ss

# Pagination 每页显示文章数，可以自定义，我将10改成了5
## Set per_page to 0 to disable pagination
per_page: 5
pagination_dir: page

# Disqus  不修改
disqus_shortname:

# Extensions  不修改
## Plugins: https://github.com/tommy351/hexo/wiki/Plugins
## Themes: https://github.com/tommy351/hexo/wiki/Themes
theme: light
exclude_generator:

# Markdown  不修改
## https://github.com/chjj/marked
markdown:
  gfm: true
  pedantic: false
  sanitize: false
  tables: true
  breaks: true
  smartLists: true
  smartypants: true

# Stylus  不修改
stylus:
  compress: false

# Deployment 站点部署到github要配置，上一节中已经讲过
## Docs: http://zespia.tw/hexo/docs/deployment.html
deploy:
  type: github
  repository: https://github.com/susubanana/dancing-waves.git
  branch: master

```

敲入`hexo g`，`hexo s`，打开localhost:4000查看效果。









