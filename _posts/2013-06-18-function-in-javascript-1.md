---
layout: post
title: "你了解javascript中的function吗?(1)"
description: ""
category: 
tags: [javascript]
tagline: 构造函数
---
{% include JB/setup %}

#### 回顾
上一篇文章中介绍了function在javascirpt作为一等公民所担任的重要责任，在不同
的上下文中它担任着不同的角色，在对象内部它可以是函数，同时又能充当名字空间，不仅如此所有的function都是闭包。看起来它的确是了不得，不过除此之外，function还能担当构造函数，亦或者说它同时还是一个类的声明。

这篇文章的目的向大家详细介绍function是如何作为*构造函数*。

#### 如何定义一个函数
* _声明式_

函数定义最常用的方式之一。

    //声明函数
    function add(x, y) {
        return x + y;
    }

    //声明构造函数
    function Animal(name, age) {
        this.name = name;
        this.age = age;
    }
    
    Animal.prototype.bark = function() {return 'bark'};

其实这两种发式完全一样，没有任何区别，你同样可以为add的prototype属性增加新的函数或者属性。不过两种方式是基于不同的用途产生的，我们之所以称后者为构造函数，仅仅因为它的*命名*和*函数实现*。

*命名*: 对于构造函数我们遵循首字母大学的规则以区别普通函数和方法，这和java中对于类的定义是非常相似的。<br>
*实现*: 构造函数是我们用来生产实例对象的工具，它通长与new关键字连用，如

    var dog = new Animal('pipi', 3);
    dog; // Animal {name: "pipi", age: 3}

同时你可能也注意到了Animal中使用到了*this*关键字，通长情况下*this*会指向函数的调用对象，也就是说如果你在浏览器中运行一下代码，你应该得到*window*对象:

    function getThis() {return this};
    getThis(); //window

试想一下，如果你这样使用构造函数:
    
    var dog = Animal('pipi', 3);

这段代码会产生什么有趣的结果呢？<br>
恭喜你！你中招了！<br>
你会发现，你的window对象新增加了两个属性, 同时没有任何对象产生:

    window.name === 'pipi'; //true
    window.age === 3        //true
    dog === undefined;      //true

对比使用构造函数的两种方式，其实这都是*new*在作怪，当我们在像使用java类那样对构造函数new出javascript对象时，它帮我们完成了一些magic（这也是javascript new关键字被人诟病的地方），我们不妨来一次魔术揭秘:

    //魔术
    var dog = new Animal('pipi', 3);

    //揭秘
    function newAlternative(constructor, name, age) {
        var obj = {};
        //修改this，指向新对象obj
        constructor.call(obj, name, age);    
        obj.__proto__ = constructor.prototype;
        return obj;
    }
    var dog = newAlternative(Animal, 'pipi', 3);
    dog; //Animal {name: "pipi", age: 3, bark: function}
因此，我们需要非常细心的处理函数，如果它就是‘类’那么请根据潜规则，首字母大写它，并且在使用的时候一定要与new连用。

* _匿名_

匿名函数广泛在javascript代码中使用，

    var Animal = function(name, age) {
        this.name = name;
        this.age = age;
    }
    Animal.prototype.bark = function() {return 'bark'};

    Animal.name === ''; //true
    var dog = new Animal('pipi', 3);
    dog; //{name : 'pipi', age : 3, bark : function}
    dog.__proto__; //Object {bark: function}

* _Function_

相对与前两种方式，使用Function来定义一个新的function相对少见。如果说构造函数是为生成实例对象而生，那么Function就是为生成函数而生，它是生成函数的模板，构造函数，‘类’.

    var Animal = 
    new Function('name', 'age', 'this.name = name; this.age = age;');
    Animal.prototype.bark = function() {return 'bark'};
