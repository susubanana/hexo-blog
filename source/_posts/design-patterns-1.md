title: javascript设计模式--工厂模式
date: 2014-01-07 20:30:30
categories: [web开发]
tags: [javascript]
---

工厂模式
-------------------------

> 工厂模式的目的就是为了创建对象，不用直接用new构造函数方式创建对象。
> 工厂模式在编译期间不知道一个具体对象类型，通过一个通用的接口来创建对象，这个接口由子类决定实例化哪种对象类型。通俗来理解，通过买早餐，你告诉老板，是要粥还是包子。

制作一个鸟工厂，鸟有会飞的鸟和不会飞的鸟。

<!--more-->
```sh
var Bird = Bird || {};

//会飞的鸟
Bird.FlyBird = function(){
    this.skill = 'flying';
    this.size = 'small';
}

//不会飞的鸟
Bird.FlightlessBird = function(){
    this.skill = 'swimming';
    this.size = 'big';
}

//制作鸟工厂
Bird.factory = function(type){
    var construct = type;
    var newBird = null;
    if(typeof Bird[construct] !== 'function'){
        throw {
            name: 'Error',
            message: construct + ' is not exist'
        };
    }
    newBird = new Bird[construct];
    return newBird;
}
var flyBird = Bird.factory('FlyBird');
console.log(flyBird.skill);
var flightlessBird = Bird.factory('FlightlessBird');
console.log(flightlessBird.skill);
```

###什么时候使用工厂模式

以下几种情景下工厂模式特别有用：

* 对象或组件的构建十分复杂
* 需要依赖具体环境创建不同实例
* 处理大量具有相同属性的小对象或组件

###什么时候不该用工厂模式

除非需要为创建比较复杂的对象提供接口，否则，不要滥用运用工厂模式，有时候仅仅只是给代码增加了不必要的复杂度，同时使得测试难以运行下去。

