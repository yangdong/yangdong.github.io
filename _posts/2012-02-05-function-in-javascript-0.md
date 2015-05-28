---
layout: post
title: "你了解javascript中的function吗?(0)"
description: ""
tags: []
---
{% include JB/setup %}


function作为javascript的核心技术之一,清晰的理解function的机制和用法,对我们进行javascript开发非常重要.

今天本人就结合自己的实践为大家介绍一些function在javascript中的一些浅显用法.

#### function是什么 ####

从Javascript对function的定义, function是一个由代码集合而成的对象.

从中我们可看出,我们可以使用向C语言中的函数那样使用function,也可以对function进行面向对象编程.当然Javascript中function的强大还不止如此.  

#### 如何使用function ####

*定义*
{% highlight javascript %}
function myfunc(param) {
    //code
}
{% endhighlight %}

注意Javascript中的这两个function被认为是同一个:
{% highlight javascript %}
function func1() {return 'func1'; }
function func1(name) { return name; }
{% endhighlight %}
在运行时到底调用哪一个function取决于加载顺序,后一个加载的function会覆盖前一个.

<!-- more -->
换句话说就是,function的参数都是可选参数,因此funciton的识别是不包括如参的,而函数入参处的声明是为了引用方便以及可读性.
以上的代码也等价于:
{% highlight javascript %}
function func1() {
    return arguments[0] || 'func1';
}
func(); //return 'func1'
func('function'); //return 'function'
{% endhighlight %}

*function当作对象*

是的没错,在javascript中function就是对象,我们可以向使用一个对象那样使用function.

它可以有自己的属性和方法.有如下的一个funciton:
{% highlight javascript %}
function nameOf(name) {
    return name.toUpperCase();
}
{% endhighlight %}
- function作为对象进行赋值
    
{% highlight javascript %}
var person = person || {};
person.nameOf = nameOf;
person.nameOf('yang dong') // return "YANG DONG"
{% endhighlight %}

+ 定义function的属性

看看以下的代码, 你能从中的到什么信息:
{% highlight javascript %}
function nameOf() {return nameOf.blogger;}
nameOf.blogger = "YANG_DONG";
{% endhighlight %}
没错,function可以拥有自己的属性.

考虑这样一种场景, 假如我们要统计某个function被调用的次数.那么我们有两种方式来实现:

++ 设定一个全局变量来记录,该funciton被调用的次数,每调用一次,该变量加1:
{% highlight javascript %}
var globalNameOfCounter = 0;
nameOf();
globalNameOfCounter ++;
{% endhighlight %}

这样做看起来是没有问题的,在代码还是比较简单的时候,它可以工作的很好,但是随着代码越来越复杂,维护这段逻辑的成本会直线上升.

主要是因为:globalNameOfCounter污染的global命名空间,并且破坏了代码的封装性.

++ 使用function的属性

看看以下代码:
{% highlight javascript %}
function nameOf() {
nameOf.counter++;
    return nameOf.blogger;
}
nameOf.blogger = 'YANG_DONG';
nameOf.counter = 0;
nameOf(); //nameOf.counter = 1;
nameOf(); //nameOf.counter = 2;
{% endhighlight %}

显而易见,第二种方式有着很好的封装性和维护性.function的属性的应用还不止如此.请看下文. 

*function作为名字空间*

Javascript不支持名字空间(本人不太理解如此强大的语言为什么不支持名字空间呢,这是为什么呢?或许是它根本就不需要专有的机制来实现名字空间),

不过我们依然可以使用其强大的funciton为我们支持名字空间.

从上节我们知道function可以定义自己的属性,我们就可以利用该特性来生成名字空间.请看以下代码:
{% highlight javascript %}
nameOf.getBloggerName = function() {
return nameOf.blogger;
}
{% endhighlight %}

此时在nameOf名字空间之下已经包含了:blogger,counter属性和function getBloggerName.

- function作为method

在javascript中function和method其实是没有什么本质区别的,如果非的区分两者的话,我想也就是this变量不同吧.
{% highlight javascript %}
function g() {return this;}
var local = local || {};
local.method = g; //修改this指向local
local.method(); //返回local对象
g(); //返回DOMWindow对象
{% endhighlight %}

- function皆为closure

在Javascript中所有的function都绑定了一个scope chain,因此它是一个保存了调用上下文的函数.看看下面的实例代码: 
{% highlight javascript %}
var variable = 'global';
function getVariable(){
var variable = 'local',
func = function() {
return variable;
};
return func;
}
getVariable()(); //return local;
{% endhighlight %}
当func被调用的时候,它所取的varible的值是调用上下文中的变量而并非与之同名的全局变量.

#### 总结 ####

如果用一句话概括今天对funciton的介绍,那么我想应该是: function是可以被调用执行的代码集对象.以上是function的一些应用场景,当然它还不止这些.

比如: function作为[*构造函数*](/2013/06/18/function-in-javascript-1/)(也就是funciton作为类),继承等.这些内容将在以后的blog中为大家介绍.
