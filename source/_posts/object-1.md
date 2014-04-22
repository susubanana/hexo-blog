title: javascript面向对象--对象的成员
date: 2013-12-21 19:00:06
tags: [javascript探秘]
---

私有属性和方法
----------------------

javascript没有特殊的语法表示公有、私有属性和方法，所有对象的成员都是公有的。实现私有成员的方法：使用闭包。

###构造函数实现私有成员

局部变量(私有成员)被所有在构造函数中定义的公有方法所共享，而且仅被在构造函数中定义的公有方法所共享，所以在prototype中定义的类成员不能访问在构造器中定义的局部变量。

```ssh
function Bird(){
    //私有成员
    var _birdWidth = 42;

    //公有方法或特权方法（指能访问私有成员的公有方法）
    this.getWidth = function(){
        return _birdWidth;
    };
}
Bird.prototype = (function(){
    //私有成员
    var _vBird = 45;

    //公有成员
    return {
        getW : function(){
            console.log(this._birdWidth); //undefined
        },
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
<!--more-->

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


静态成员
------------------------

静态属性和方法是从一个实例到另一个实例都不会发生改变的属性和方法。

公有静态成员：通过使用构造函数并向其添加属性。

```ssh
function Bird(){
    this.vBird = 45;

    //私有成员
    var _birdWidth = 42;

    //公有方法或特权方法（指能访问私有成员的公有方法）
    this.getWidth = function(){
        return _birdWidth;
    };
};

//公有静态成员
Bird.isFly = function(){
    return "isFlying";
};
Bird.prototype.getVBird = function(){
    return this.vBird;
};
console.log(Bird.isFly()); //isFlying，静态方法不需要继承Bird对象就能运行。

var bird = new Bird();
console.log(bird.getVBird()); //45，对象的公有成员需要继承Bird对象就能运行。

//子类直接调用静态方法无法正常运行
console.log(bird.isFly()); //bird.isFly is not a function

//若需要子类能与静态方法一起工作，可以向原型中添加一个属性指向静态方法
Bird.prototype.isFly = Bird.isFly;
var bird2 = new Bird();
console.log(bird2.isFly()); //isFlying

```

私有静态成员：在模块模式中使用var声明变量，以同一个构造函数创建的实例共享该成员，构造函数外不可访问该成员。

```ssh
var FlyBird = (function(){

    //私有静态成员
    var acceleration = 0;
    var Bird = function(){
        this.vBird = 45;

        //私有成员
        var _birdWidth = 42;

        acceleration += 2.5;
        this.vBird += acceleration;

        //公有方法或特权方法（指能访问私有成员的公有方法）
        this.getWidth = function(){
            return _birdWidth;
        };
    };

    //公有静态成员
    Bird.isFly = function(){
        return "isFlying";
    };
    Bird.prototype.getVBird = function(){
        return this.vBird;
    };
    return Bird;
}());


var bird = new FlyBird();
console.log(bird.getVBird()); //47.5

var bird2 = new FlyBird();
console.log(bird2.getVBird()); //50

```
