# Daddy项目报告

---

daddy tourism网站是一个特别为旅行图片交流而设计的网站项目，支持远程部署，包含关于图片网站一切的基础功能，并提供一个轻量级的聊天室

> * 需求分析
> * 项目功能介绍
> * 项目开源组件介绍


----------


## **需求分析**


----------

*主要对较为复杂/在开发中产生了较多考量的地方进行了分析*
*其他简单需求不在此赘述*

 1. 注册&登录

    **Springboot思路**：使用JWT字符串赋予登陆权限，并将该字符串存放在localStorage中。
    
    **简化思路**： 在服务端验证登陆有效后，在客户端cookie中写入相应的username和login状态信息，**缺陷** 是登录相比JWT字符串存在更大的隐患，**优点** 是在原生Sevlet上的表现更好
    

 2. 图片的收藏

    **数据**：使用mysql存放用户+图片的键值对组合，建立如下数据表
    
    `->CREATE TABLE collection (
        ->user CHAR(15),
        ->id INT,
        ->title
        ->url CHAR(255),
        ->);`
       
    
    **展示**：为了减少数据库访问次数，在collection中除了存放已经存在的**user、id**两个限制关键词以外，还存放了图片的**地址**和**标题**

 

 3. 图片的上传
    
    **前端**：文件的上传需要进行确认，由于本项目采用了后端对表单内容进行分析，因而使用了**bootstrap的modal窗口**进行了确认提示
    **后端**：文件名存在重复的时候会导致文件写入失败，因而写入的文件必须是文件名互不相同的，这里采用了java的一个后端库

        private static final long serialVersionUID = 1L;
        String filesqlName = UUID.randomUUID().toString() + str;
    用UUID随机生成的文件名可以保证不会重复。
    

 4. 聊天室

    使用ajax短询轮进行聊天室的实现，基本原理如下：
    
    **前端**：ajax对聊天信息进行请求：
    
        function get() {
             $.ajax(
            {
                url: "/daddy/chat",
                data: {
                    action:"get"
                },
                type: "POST",
                dataType: "TEXT",
                contentType: 'application/x-www-form-urlencoded;charset=UTF-8',
                success: function (data) {
                    console.log(data);
                    $("#chat").html(data);
                        }
                    }
                )
            }

在页面加载时设置每500ms执行一次get函数保证消息的同步发布。

**后端**：使用一个变量List来存放信息，并且在servlet初始化的同时添加系统信息

    private List<Chat> chatList = new ArrayList<>();
    @Override
    public void init() {
        chatList.add(new Chat("Chat room has been set.", "System", String.valueOf(new Date().getTime())));
    }


----------

##**项目功能介绍**


----------

 - index.jsp
         ![avatar](/imgMarkdown/index.jpg)
主页展示了**最新上传**的5张图片和**热度最高**的3张图片，后者使用了轮播进行展示，点击相关的链接可以直接跳转到相关页面
 - /personal
    - /personalCenter.jsp
        ![avatar](/imgMarkdown/center.jpg)
        在显示**登录用户**的主页时，会提供相关的**权限设置、登出**等功能，显示用户当前的**收藏、好友和足迹**，并且提供前往**修改/删除图片的router**
        ![avatar](/imgMarkdown/center2.jpg)
        在显示**非登录用户**的主页时，会提供添加好友（follow按钮），并且会根据好友的设置**显示/不显示收藏**，且**足迹被隐藏**
    - /personalPic.jsp
        ![avatar](/imgMarkdown/pic.jpg)
        仅有登录用户与请求用户相同时方可访问，否则会被**重定向至主页**。点击删除按钮，按钮组会发生变换，原来**删除**的地方会变成**取消**，防止用户出现**误触**
 - /picture 
    - pictureDetail.jsp
        ![avatar](/imgMarkdown/detail.jpg)
        提供**收藏**功能，在用户未登录时，收藏会变成登录的router
        ![avatar](/imgMarkdown/detail2.jpg)
        将鼠标移动至图片处，可以**局部放大**图片，这个功能**支持移动端**
    - pictureUpload.jsp & pictureModify.jsp
        上传图片，功能和其他表单类似，上传的图片支持拖拽，在提交之前会有modal窗口进行确认
    - pictureSearchResult.jsp
        ![avatar](/imgMarkdown/center.jpg)
    显示搜索结果，每页显示10个，在**页面滑动至底部时自动加载下一页**，对移动端更加友好
 - /Auth
 - /Auth.jsp
    - /Login.jsp
        ![avatar](/imgMarkdown/login.jpg)
    - /Register.jsp
        ![avatar](/imgMarkdown/register.jpg)
    注册和登录都继承在了auth中，使用动画效果来进行页面切换
 - /Chat
    - /Chat.jsp
    简易的聊天室


----------


##**开源组件介绍**


----------
####**bootstrap**

Bootstrap，来自 Twitter，是目前最受欢迎的前端框架。Bootstrap 是基于 HTML、CSS、JAVASCRIPT 的，它简洁灵活，使得 Web 开发更加快捷。

> 项目地址[bootcss][1]

####**animate.css**

Animate.css is a library of ready-to-use, cross-browser animations for use in your web projects. Great for emphasis, home pages, sliders, and attention-guiding hints.

> 项目地址[animated.css][2]


####**Jquery_Zoomio**

Description: Zoomio is an easy to set up, mobile friendly Image Zoom script that overlays an enlarged image directly on top of the original image when activated. Users simply mouse over to bring up the enlarged image that can then be explored by moving the mouse around. On mobile devices, users tap the image to bring up the larger image that can then be dragged around. The zoom function works by taking the original image and showing it in its native dimensions when triggered, meaning the same image is used as both the initial and "enlarged" image. Alternatively, you can specify a different, higher resolution image as the "enlarged" image that's loaded on demand instead.

>项目地址[Zoomio][3]

####**AOS**

AOS即Animation of scroll，是一个滚动时触发动画的类库

>项目地址[AOS][4]


  [1]: https://www.bootcss.com/
  [2]: https://animate.style/
  [3]: https://github.com/dynamicdriverepo/zoomio
  [4]: https://github.com/michalsnik/aos