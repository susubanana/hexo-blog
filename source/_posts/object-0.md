title: javascript面向对象--私有属性和方法
date: 2013-12-17 18:50:51
tags: [javascript探秘]
---

本文记录对象的私有属性和方法。

私有属性和方法
----------------------

javascript没有特殊的语法表示公有、私有属性和方法，所有对象的成员都是公有的。实现私有成员的方法：使用闭包。

###构造函数实现私有成员

```ssh
function Bird(){
    //私有成员
    var _birdWidth = 42;

    //公有方法或特权方法（指能访问私有成员的公有方法）
    this.getWidth = function(){
        return _birdWidth;
    }
}
Bird.prototype = (function(){
    //私有成员
    var _vBird = 45;

    //公有成员
    return {
        getVBird: function(){
            return _vBird;
        }
    };
}());

var bird = new Bird();
console.log(bird.birdWidth); //undefined
console.log(bird.getWidth()); //42
console.log(bird.getVBird()); //45
```

###对象字面量实现私有成员

```ssh
//模块模式
var Bird = (function(){
    //私有成员
    var _birdWidth = 42;

    //公有成员
    return{
        getWidth : function(){
            return _birdWidth;
        }
    };
}());
console.log(bird.getWidth()); //42
```

<!--more-->