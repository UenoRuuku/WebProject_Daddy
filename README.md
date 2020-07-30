# WebProject_DaddyTourism
**一个为提供一个旅行图片交流平台所设计的网站**

daddy tourism网站是一个特别为旅行图片交流而设计的网站项目，支持远程部署，包含关于图片网站一切的基础功能，并提供一个轻量级的聊天室

## HOW TO USE ##

本项目在安装了jdk10以上版本、tomcat9以上版本、mysql8以上版本的服务器上可进行部署运行

需要在本地先部署名为travel的数据库以及数据表，数据表详细信息在项目文档中有详细介绍

## 完成的功能 ##

**基础功能**

全部完成

**附加功能**

图片的局部放大（所有picture_detail页面的图片均可以局部放大）

一个基于ajax短询轮的简单多人聊天室

一个完备的项目报告（包括全部的需求分析和项目内容介绍）

## 前端构成 ##

**框架**

~~本项目基于vue.js进行开发~~

~~>vue.js的[项目地址](https://cn.vuejs.org/)~~

前端基于原生jsp开发

**样式部分**

注意！需要在支持*Jquery*和*css3*的浏览器上进行浏览

样式基于*bootstrap样式库*，采用bootstrap特色的栅格化布局对网页的用户界面进行了设计，满足了用户的基本需求，并且尽量让网站界面在不同尺寸的宽屏上均有良好表现

>bootstrap的[项目地址](https://www.bootcss.com/)

动画特效除了使用原生css帧动画进行编辑，还引入了*animate.css样式库*

>animate.css的[项目地址](https://animate.style/)

前端的图片放大功能引入了github的开源项目jquery Zoomio

>jquery_Zoomio的[项目地址](https://github.com/dynamicdriverepo/zoomio)

## 后端构成 ##

**框架**

~~本项目基于springboot进行开发~~

本项目基于原生Servlet开发

层级结构大致如下

Servlet层

~~Service层~~（功能较为简单，已与servlet层合并）

domain层

util层

~~Repository层~~（CurdRepository引入失败，放弃了不使用mysql语句的思路）

## 功能思路 ##

**聊天室**

~~使用websocket套接字来开发一个完善的聊天室~~，但遇到了一些无法解决的问题，在这边进行简单记录

1、浏览器拒绝了新建websocket

运行后，控制台报错can't solve 以及 security 相关问题

2、连接池的生命周期问题

3、数据库对聊天信息的定时清理问题

无法在开发周期中测试

最终采用了ajax短询轮的方案，每500ms向服务端发送获取信息请求，基本能够等同于即时聊天

缺陷是对于过多的访问存在很大的安全隐患（就是ddos攻击），项目最终没有在服务器上部署的原因也是这个

