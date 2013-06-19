---
layout: post
title: "你了解javascript中的function吗?(2)"
description: ""
category: 
tags: [javascript]
---
{% include JB/setup %}

#### Object对象
    
Object在javascript中是一个至关重要的对象，在javascript中一切皆是对象，而
Object就是所有对象的父对象，也就是说所有对象将继承来自Ojbect的属性，我们不妨举个例子:

    var myPet = 'Peter';
    Object.prototype.getName = function(){return 'Object'};
    myPet.getName() === 'Object'; //true 
在这里你有可能会问为什么是prototype？在这里请保留这样的疑问，我们可以这样理解prototype就像是储存基因的容器。

#### 函数和对象
javascript中一切都是对象，当然函数也不例外。刚才我们说到了Object对象，在上面的例子中其实我们是将它当作构造函数来使用了（请先忽略构造两个字，接下来我们会讲到）。*等等，你说Object是函数？没错！它就是函数!*好吧我承认这里有点混乱，让我从新组织一下语言，*Object即是一个实例对象有事函数.*那么你现在就有疑问了，它是谁的实例呢？它如何作为函数呢？我们先看看下面一段代码:

    Object instanceof Function === true //true
    typeof Object === 'function'        //true



#### Prototype
#### prototype属性和__proto__属性
#### Constructor

