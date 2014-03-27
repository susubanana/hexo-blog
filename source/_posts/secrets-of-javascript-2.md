title: javascript作用域--闭包
date: 2013-12-11 18:30:27
tags: [javascript探秘]
---

本文记录闭包的理解、使用。

闭包的理解
----------------------
HOME="d:/node/no-forget/hexo"
HOME="$(cd "$HOME" ; pwd)"
cd

根据下面代码进行分析：

```sh
function add(){
    var firstVal = 0,
        secondVal = 1;
    return function(){
        secondVal++;
        return firstVal + secondVal;
    }
}
var sum = add();
console.log(sum()); //2
console.log(sum()); //3，说明secondVal++的值没有被销毁，还保存在内存中。
```
###从堆栈的角度理解：

在面向堆栈的编程语言中，函数的局部变量都是保存在栈上的，每当函数激活的时候，这些变量和函数参数都会压入到该堆栈上。当函数返回的时候，这些参数又会从栈中移除。
<!--more-->
但是闭包即使外部函数add已经返回，内部匿名函数仍可以访问外部函数的变量，因而要实现将局部变量在上下文销毁后仍然保存下来，基于栈的实现显然是不适用的。

因此在这种情况下，上层作用域的闭包数据是通过动态分配内存的方式来实现的（基于“堆”的实现），配合使用垃圾回收器和引用计数。

###从作用域的角度理解：

内部匿名函数会将外部函数add的活动对象添加到它的作用域链中，内部匿名函数的作用域链会包含自身的活动对象和外部函数add的活动对象和全局变量对象。

当外部函数add执行完毕，它的执行环境作用域链会被销毁，它的活动对象不会被销毁，仍然留在内存中，因为内部匿名函数还在引用这个活动对象。

###从概念上理解：

* 闭包允许内部函数引用外部函数以外定义的变量。
* 即使外部函数已经返回，当前函数仍然可以引用在外部函数所定义的变量。
* 闭包可以更新外部函数的值，闭包存储的是外部变量的引用。

###从闭包的执行步骤理解：

1. 程序预编译后，从第9行开始解析执行，创建上下文环境，创建变量对象。
2. 执行外部函数add，secondVal++，内部匿名函数保持与secondVal的联系。
3. 外部函数add把内部匿名函数返回给变量sum，实现了内部匿名函数的定义，此时sum完全继承了内部匿名函数的结构和数据。
4. 外部函数add返回后自动销毁。
5. 执行第10行代码，调用内部匿名函数，此时secondVal++已经是2。

闭包的使用
-------------------

由于闭包会携带包含它的函数的作用域，会比普通函数占用更多的内存，要慎用闭包。

让代码模块化，以减少全局变量的污染：

```sh
var test = (function(){
    var a = 1;
    function innerOne(){
        a++;
        console.log(a);
    }
    function innerTwo(){
        a++;
        console.log(a);
    }
    return {
        a : innerOne,
        b : innerTwo
    }
})();

//调用
test.a();   //2
test.b();   //3
```

用于对象中的特权方法来访问对象的私有变量（私有属性或者私有函数）

```sh
function Ob() {
    var privateVal = 1;
    var privateFunc = function(){
        return privateVal++;
    };
    this.publicFunc = function(){
        return privateFunc();
    };
};
var oo = new Ob();
function Ob() {
    var privateVal = 1;
    var privateFunc = function(){
        return privateVal++;
    };
    this.publicFunc = function(){
        return privateFunc();
    };
};
var oo = new Ob();
oo.publicFunc(); // 1
oo.privateFunc(); //TypeError: oo.privateFunc is not a function

```

延迟调用：

```sh
var val = 10;
setTimeout(function () {
  console.log(val); // 10
}, 500);
```