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

#### prototype and prototype chain

>>>object that provides shared properties for other objects
以上是ECMAScript对prototype对象的定义，翻译过来便是：
>>>为其他对象提供共享属性的对象

NOTE When a constructor creates an object, that object implicitly references the constructor‘s ―prototype‖ property for the purpose of resolving property references. The constructor‘s ―prototype‖ property can be referenced by the program expression constructor.prototype, and properties added to an object‘s prototype are shared, through inheritance, by all objects sharing the prototype. Alternatively, a new object may be created with an explicitly specified prototype by using the Object.create built-in function.

ECMAScript does not use classes such as those in C++, Smalltalk, or Java. Instead objects may be created in various ways including via a literal notation or via constructors which create objects and then execute code that initialises all or part of them by assigning initial values to their properties. Each constructor is a function that has a property named ―prototype‖ that is used to implement prototype-based inheritance and shared properties. Objects are created by using constructors in new expressions; for example, new Date(2009,11) creates a new Date object. Invoking a constructor without using new has consequences that depend on the constructor. For example, Date() produces a string representation of the current date and time rather than an object.

Every object created by a constructor has an implicit reference (called the object‘s prototype) to the value of its constructor‘s ―prototype‖ property. Furthermore, a prototype may have a non-null implicit reference to its prototype, and so on; this is called the prototype chain. When a reference is made to a property in an object, that reference is to the property of that name in the first object in the prototype chain that contains a property of that name. In other words, first the object mentioned directly is examined for such a property; if that object contains the named property, that is the property to which the reference refers; if that object does not contain the named property, the prototype for that object is examined next; and so on.
<!-- more -->
#prototype of Some special object
1. Each constructor is a function that has a property named "prototype" that is used to implement prototype-based inheritance and shared properties.

1. The Function prototype object is itself a Function object (its [[Class]] is "Function") that, when invoked, accepts any arguments and returns undefined.

2. The value of the [[Prototype]] internal property of the Function prototype object is the standard built-in Object prototype object (15.2.4). The initial value of the [[Extensible]] internal property of the Function prototype object is true.
3. Object.prototype.__proto__ is null
4. 

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

#### typeof
#### 