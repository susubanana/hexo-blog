title: javascript面向对象--对象的继承（一）
date: 2013-12-22 18:00:32
categories: [web开发]
tags: [javascript]
---

理解面向对象继承
----------------------

实现继承是依靠原型链来实现的。

###原型链

>原型链就是，将一个对象的实例赋值给一个对象的原型来实现的。子对象的原型有一个内部指针[[prototype]]指向父对象的原型，相应地，父对象也包含一个内部指针[[prototype]]指向另一个构造函数，直到Object构造函数，这样就组成一条原型链。这样子对象能共享父对象所有的属性和方法，它的问题也是共享所有的属性，比如包含引用类型，一旦更改，所有指向这个引用类型的对象的属性值也被修改。

* 所有的引用类型都默认继承Object
* 通过subObj instanceof Object检测对象的类型
* 通过Object.prototype.isPrototypeOf(subObj)检测对象是否由该原型链派生的实例的原型。
* 不要使用字面量创建原型，这样会重写原型链，constructor指向Object，不是Bird，如：

<!--more-->

字面量方式创建原型
```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

var bird = function(){
    this.displacement = 0;
};
bird.prototype = new Bird();
bird.prototype = {
    getDisplacement : function(time){
        return this.displacement += this.vBird * time
    }
};
var b = new bird();
console.log(b.getVBird()); // b.getVBird is not a function
```

非字面量方式创建原型
```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

var bird = function(){
    this.displacement = 0;
};
bird.prototype = new Bird();
bird.prototype.getDisplacement = function(time){
    return this.displacement += this.vBird * time
}
var b = new bird();
console.log(b.getVBird()); //45

```





