---
layout: post
title: "你了解javascript中的function吗?(2) [draft]"
description: ""
category: todo
tags: [javascript]
---
{% include JB/setup %}

#### 回顾

在上一遍文章中，我们讲解了function作为构造函数的场景，它的作用类似于java中的类，他是创建对象的模板，通常需要与new一同使用来创建对象。

#### 继承
在开始之前，先让我们来热热身，看看一个非常常见的javascript继承代码，

{% highlight javascript %}
//定义Animal
function Animal(name) {
    this.name = name;
}
Animal.prototype.bark = function() {
    return this.name + ' is barking!';
}

//定义Dog
function Dog(name) {
    this.name = name
}
//Dog继承Animal
Dog.prototype = new Animal();
//定义Dog的方法
Dog.prototype.eat = function() {
    return this.name + ' is eating!';
}

Dog.constructor = Dog;
//创建Dog对象
var dog = new Dog('pipi');
dog.eat();   //pipi is eating!
dog.bark();  //pipi is barking!
{% endhighlight %}

<!-- more -->
#### prototype对象

prototype对象是class的灵魂，如果用另外一种方式来定义class的话，他可以是满足以下条件的函数，它能够创建基于给定prototype对象的实例对象。因此，我们可以显而易见的看出prototype的重要地位。

那些对象能够访问prototype对象呢？
#### 原型链

- prototype属性和__proto__属性
#### Constructor对象
