title: javascript高级技巧--函数柯里化
date: 2013-12-12 17:45:24
tags: [javascript探秘]
---

函数柯里化
----------------------

与函数bind()紧密相关的主题是函数柯里化。

> 将函数及其参数的子集绑定来实现函数委托的方式称为函数柯里化
> 柯里化主要工作是将被返回的函数的参数进行排序

柯里化函数通常如下创建：调用另一个函数，并为它传入柯里化函数和必要参数，返回给定的函数的函数和传入的参数。

```sh
function curry(fn) {

    //1表示返回的数组包含从第二个参数开始的所有参数，args包含外部函数传入的参数。
    var args = Array.prototype.slice.call(arguments, 1);
    return function(){

        //innerArgs存放内部函数的参数
        var innerArgs = Array.prototype.slice.call(arguments);
        var finalArgs = args.concat(innerArgs);

        //不用绑定执行环境，所以为null
        return fn.apply(null, finalArgs);
    };
}
function sum(x1, x2){
    return x1 + x2;
}
var currySum = curry(sum, 1, 2);
currySum(); //3
```

柯里化函数常作为bind方法的一部分。

```sh
function bind(fn, context) {

    //2表示返回的数组包含从第三个参数开始的所有参数，args包含外部函数传入的参数。
    var args = Array.prototype.slice.call(arguments, 2);
    return function(){

        //innerArgs存放内部函数的参数
        var innerArgs = Array.prototype.slice.call(arguments);
        var finalArgs = args.concat(innerArgs);

        //绑定执行环境context
        return fn.apply(context, finalArgs);
    };
}
```
