---
layout: post
title: "简单几步成为微信公众平台开发者"
description: ""
category: 
tags: [wechat, heroku, ruby]
---
{% include JB/setup %}

**“微信，是一个生活方式”**，这是微信的自我评价，是不是觉得如果那天不在朋友圈里分享一下自己的最新状态，并且收到几个赞和评价的话，会觉得空虚寂寞呢？它实实在在的改变了我们的生活方式。

**“微信，也是一个生意方式”**，在微信成为我们日常必备之app的同时，它同样具备巨大的的商业潜力，或许不应该称为潜力，因为有很多人已经获利，名人们在微信上开设公众账户来吸金，商家来做推广，服务行业借此拓展渠道，甚至微信已经支持支付了, 还有越来越的自媒体在微信平台涌现出来。

这篇文章就是介绍如何快速的成为公众平台开发者，由于个人只能申请订阅号，因此本文是以订阅号为例。
关于订阅号和服务号的区别，请参见[*微信公众平台服务号、订阅号的相关说明*](http://kf.qq.com/faq/120911VrYVrA130805byM32u.html)。

从微信用户角度简单来说:
订阅号主要用于信息辐射，典型的如各家新闻媒体。
服务号主要由于自助服务，典型的如招商银行。

<!-- more -->

### 申请公众平台账户

  1. 到[*微信公众平台*](https://mp.weixin.qq.com/)填写注册信息

  ![basic info](https://lh3.googleusercontent.com/-X7Q_CqHxbcQ/Ukeh0K5sVUI/AAAAAAAABrE/w_44OSM6dOU/w559-h401-no/wechat-01-basic-info.png)

  2. 按照提示激活邮箱

  ![activate email](https://lh5.googleusercontent.com/-0r02C8mhQ2w/Ukeh0R8UimI/AAAAAAAABrM/Ik15ZjYtl2k/w555-h266-no/wechat-02-email-activation.png)

  3. 上传个人照片，需要有清晰的身份证照片

  ![pic](https://lh5.googleusercontent.com/-E9aA7Gf-JNY/Ukeh0i_XwlI/AAAAAAAABrU/fZ4DyYgSSxY/w378-h584-no/wechat-03-identification.png)
  4. 选择公众账户的类型，对于个人账户只能选择**订阅号**

  ![account](https://lh5.googleusercontent.com/-XNd_u1Je82U/Ukeh08_aodI/AAAAAAAABrc/CDboqI1wFtw/w564-h455-no/wechat-04-account-type.png)

  5. 最后一会看到自己账户的所有信息，请上传账号的头像，否则无法完成开发者的申请

  ![information](https://lh4.googleusercontent.com/-PxvG6z41m4I/Ukeh1Ikv8xI/AAAAAAAABr4/yT2XHSackSA/w383-h530-no/wechat-05-profile.png)

  6. 等待审核通过，这个过程大约需要2～3天，当你收到如下通知，那么恭喜你，你已经成功的申请到了微信公众账户了

  ![validation](https://lh5.googleusercontent.com/-BBIsc6ccr88/Ukeh1eqPwnI/AAAAAAAABrg/I5u-vYkrqYk/w560-h133-no/wechat-05-success.png)

  7. OK, 激动人心的时刻到了，是时候进入开发模式了，点击导航栏的“高级功能”，你将会看到两种模式可供选择，请直接忽略编辑模式，进入“*开发模式*”

  ![developer mode](https://lh4.googleusercontent.com/-4eMk81zkxHo/Ukeh13uV1KI/AAAAAAAABrw/sEMRqb160hE/w575-h422-no/wechat-06-choose-developer-mode.png)

  8. 注册公众账户的服务器

  这里需要两部分信息，*服务器地址*和用于验证的*Token*（用来验证请求来自微信服务器）。
  如果你还没有自己的服务器，没有关系，为了完成这篇文章我特意申请了一个微信账户：

    名称：公众账号开发指南
    账户ID：we-chat-tutorial
    服务器地址：http://wechattutorial.herokuapp.com/

  这是一个用于示范的服务器，所有的源码都托管在github上，有兴趣的朋友可以拷贝一份，搭建一个服务器。下面我会讲到服务器的搭建。
  ![register your server](https://lh3.googleusercontent.com/-8kd4zoJdUxA/Ukeh2OpOkYI/AAAAAAAABr0/mJO9MvbV9gM/w502-h331-no/wechat-07-register-your-server.png)

  9. 成功就在眼前，当验证完成之后，请打开“开发者模式”，至此所有的账户申请就完成了

  ![done](https://lh3.googleusercontent.com/-DuAMTuwffAI/Ukeh2k5-kDI/AAAAAAAABsA/zkPjgIYQegk/w506-h689-no/wechat-08-server-registered.png)

  10. 关注你的公共账户
  拿起你的手机扫一扫下面的二维码，然后你将会收到一个*欢迎消息*，接着试试“*help*”，该账号会返回相应的帮助信息。如果输入其他任何文本，该账户会返回预先定义的*图文消息*给你。再次声明一下，这不是在打广告，该账户仅仅是用来做样例用的。

  ![qrcode](https://lh4.googleusercontent.com/-uT8m2Dnci8M/Uke5MROGBTI/AAAAAAAABsk/SrjkULFUres/s344-no/wechat-qrcode.jpg)

接下来，我们说说如何搭建这个服务器。

### 搭建服务器
微信公众平台是通过消息与公众账号服务器进行通讯，每个消息都会包含如下信息:
微信用户ID，开发者微信号，时间戳，消息类型（文字，链接，图文，音乐，事件），消息内容，消息ID。其中最常用的便是文字类型的消息和关注事件。如果以一个饭店的微信账户为例的话，典型的应用场景可以是这样的:用户输入“**_menu_**”，公众账户返回给用户菜单的图文消息。我自己也有一个微信公众账号，这个账号可以提供简单的澳洲商业房产搜索:
> 用户输入“澳洲的任何你感兴趣的地址（如：Melbourne）”，公众账户会根据该地址帮你找到排名前5位的商业地产
说到这里有点广告植入的嫌疑，其实这个账号就是3天工作的产物，只是想用来验证一下自己的想法，与*公众账号开发指南*不同的是它的结果是真实数据。
![au commercial](http://farm3.staticflickr.com/2844/9952364123_be26735673_n.jpg)

#### 代码
所有的代码都托管在github上

> git@github.com:yangdong/wechat-tutorial.git

该服务器完成了对以下功能：

1. 响应微信平台的验证请求  
2. 响应用户关注该公众账户  
3. 响应用户查询帮助信息   
4. 响应用户其他文字请求   

#### 部署
*准备工作*：
[*github*](http://github.com/)账户
[*Heroku*](http://heroku.com/)账户

*目标*：
将github中的代码部署到Heroku

*工具*
[snap ci](https://snap-ci.com)它是一个持续集成工具，能够帮助我们非常轻松的将github中的代码，部署到Heroku上，这样我们仅需要关注我们的业务代码，而无需关心部署的流程。
如果想要深入了解持续集成，可以参考[Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration)，同时这本书也不错[持续集成](http://book.douban.com/subject/2580604/)。

*LET'S GO*

  1. Fork wechat-tutorial到自己的github

  2. 使用github账户登陆snap-ci

  ![snap ci login](https://lh6.googleusercontent.com/-BmUGhR0BZQI/UkfG8AS_tbI/AAAAAAAABuk/h1hi3bwyX7g/w507-h213-no/snap-ci-01-login.png)
  3. 为刚刚fork的代码仓库创建一个snap-ci的工程

  ![snap ci create project](https://lh4.googleusercontent.com/-e4n756zBU9I/UkfG8cFg8gI/AAAAAAAABuo/x9zrWikOVqM/w488-h107-no/snap-ci-02-add-project.png)
  
  snap ci会加载你托管在github中的所有仓库，我们选择wechat-tutorial
  ![snap ci we chat](https://lh4.googleusercontent.com/-3NvlIe4-RQc/UkfG8Rrs0fI/AAAAAAAABu4/Tdlp5ghwln0/w517-h69-no/snap-ci-03-add-wechat.png)
  ![snap ci creating](https://lh3.googleusercontent.com/-pHkiUH-JB84/UkfG86q0_0I/AAAAAAAABu8/fCgfWaTxO5U/w516-h78-no/snap-ci-04-creating.png)
  4. 为该流水线创建所需要的构建流程，我们只需要增加部署到Heroku

  ![snap ci adding build stage](https://lh3.googleusercontent.com/-6BjKY5RuQSI/UkfPrFd9c0I/AAAAAAAABwY/Zbp4ZYYTNdU/w603-h561-no/snap-ci-05-create-pipleline.png)
  
  我们选择“*Heroku Deployment Stage*”，在这一步中，需要你Heroku账户为snap-ci授权，以便于它能够创建和部署应用
  ![snap ci adding heroku](https://lh5.googleusercontent.com/-LemmnW0NQBw/UkfPrAIq3hI/AAAAAAAABwU/bb47y425Qkw/w590-h190-no/snap-ci-07-use-heroku.png)
  ![snap ci adding deploying wechat to heroku](https://lh5.googleusercontent.com/-2HoW00ILVs4/UkfG9xXfsLI/AAAAAAAABvM/DTjMb7rHwus/w548-h221-no/snap-ci-09-pipeline-created.png)

  5. 等待构建

  恭喜你，已经完成99%的工作了，剩下的1%将由snap-ci为你完成，并且以后永远都是由它帮你完成，你成功的拥有了一个免费的不知疲倦的劳动力了。
  ![snap ci waiting for build](https://lh4.googleusercontent.com/-QW15QCwZoys/UkfG-pCRunI/AAAAAAAABvc/zwB4bG7bZH4/w255-h411-no/snap-ci-10-build-scheduled.png)

  6. 大功告成

  当你看到绿色的“*PASSED*”字样时，你的所有部署工作就完成了，你现在就可以访问自己的公众账户服务器了。
  ![snap ci build success](https://lh6.googleusercontent.com/-Z87CYa4xEKc/UkfG_BEBDZI/AAAAAAAABvo/GjZx-YS1R0U/w409-h441-no/snap-ci-11-builds.png)

  如何验证你的服务器是否工作正常，很简单，在浏览器中输入“http://你的应用名称.herokuapp.com/?echostr=token”，当浏览器返回“*token*”时，就意味着你的服务器已经就绪。

