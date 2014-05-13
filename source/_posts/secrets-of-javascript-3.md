title: javascript高级技巧--函数绑定bind()
date: 2013-12-11 20:28:51
categories: [web开发]
tags: [javascript探秘]
---

函数绑定bind()方法
----------------------

###自定义bind方法

这个技巧常用于回调函数中。其中this指向的对象取决于调用表达式。可能会出现不符合预期的情况，因而需要绑定函数的原始对象。

```sh
// 作为回调函数传递时，this指向全局变量
var Bird = {
    vBird : 45,
    colors: ['blue', 'yellow'],
    getVBird :function(whichBird){
        return whichBird + '的速度是 ' + this.vBird;
    }
};
var bird = {
    vBird : 60
    method: function(callback) {
        return callback('blueBird');
    }
};
bird.method(Bird.getVBird); // "blueBird的速度是 undefined"
```

简单的bind(一个环境，一个函数)，这个bind函数返回给定环境中调用给定的函数的函数，并将所有参数传递过去：
<!--more-->
```sh
function bind(obj, method){
    return function(){
        return method.call(obj, [].slice.apply(arguments));
    };
}
var Bird = {
    vBird : 45,
    colors: ['blue', 'yellow'],
    getVBird :function(whichBird){
        return whichBird + '的速度是 ' + this.vBird;
    }
};
var bird = {
    vBird : 60
};
var birdGetVBird = bind(bird, Bird.getVBird);
birdGetVBird('blueBird'); //"blueBird的速度是 60"
```

###ECMAScript5的bind方法

ECMAScript5 将bind添加到function.prototype中。支持的有IE9+、火狐、谷歌，其实现原理：

```sh
if(type of Function.prototype.bind === "undefined"){
    Function.prototype.bind = function(thisArg){
        var fn = this,
            slice = Array.prototype.slice,
            args = slice.call(arguments, 1);
        return function(){
            return fn.apply(thisArg, args.contact(slice.call(arguments)));
        };
    };
}
```

使用ECMAScript5的bind方法
```sh
var Bird = {
    vBird : 45,
    colors: ['blue', 'yellow'],
    getVBird :function(){
        return this.vBird;
    }
};

var bird = {
    vBird : 60
};
var vBird = Bird.getVBird.bind(bird);
console.log(vBird()); //60
```

被绑定的函数和普通函数相比，需要更多的内存，也因为多重函数调用会稍慢，所以最好在必要时使用。
