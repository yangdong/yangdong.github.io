---
layout: post
name: how-to-install-mysqldb-for-python
title: 在mac上安装Mysqldb
tags: [Django, python]
permalink: yangdong/archive/2011/05/20/how-to-install-mysqldb-for-python.html
---
{% include JB/setup %}

最近在学习Django和wxPython，但是光是安装整个的开发环境，就忙了好几天，好不容易的找到了安装出错的原因，特此分享给大家。

### 确定你所安装的python版本和位数（32位还是64位）### 
mac上查询python是32位还是64位的命令是：
    
    file $(which python)
    /Library/Frameworks/Python.framework/Versions/2.7/bin/python (for architecture i386):Mach-O executable i386 /Library/Frameworks/Python.framework/Versions/2.7/bin/python (for architecture x86_64):Mach-O 64-bit executable x86_64

表示本机安装有32位和64位的python

### 下载相应的（同一个位数）的mysql和mysqldb，以及wxPython（本人安装64位python2.7) ###
如果已经安装了mysql，那么我们也可以使用

    file $(which mysql)
    /usr/local/mysql/bin/mysql: Mach-O 64-bit executable x86_64
    python setup.py build

如果出现以下信息：


    Traceback (most recent call last):
    File "setup.py", line 6, in <module>
    from setuptools import setup, Extension
    ImportError: No module named setuptools

　　这是由于没有安装setuptools, 而mysqldb的安装是依赖于setupools。（
setuptools是python的包管理工具）可以直接执行mysqldb安装包根目录下的ez_setup.py，来安装setuptools。此时执行python setup.py install 到此，在mac上安装mysqldb就成功了。
