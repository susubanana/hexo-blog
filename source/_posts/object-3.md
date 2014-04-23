title: javascript面向对象--对象的继承（二）
date: 2013-12-22 19:40:40
tags: [javascript探秘]
---

面向对象继承的方式
----------------------

###构造函数模式

> 优点：获得父对象成员的真实副本，并且不会有子对象意外覆盖父对象的风险
> 缺点：无法从原型中继承，并不会为实例创建原型

```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

var bird = function(){
    Bird.call(this);
};
var b = new bird();
console.log(b.vBird); //45
b.getVBird(); // b.getVBird is not a function
```

###构造函数模式 + 原型继承

> 优点：获得父对象成员的真实副本，获得指向对象复用的引用（原型），并且不会有子对象意外覆盖父对象的风险
> 缺点：父级构造函数被调用了两次，效率低下
<!--more-->
```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

var bird = function(){
    Bird.call(this);
};
bird.prototype = new Bird();
var b = new bird();
console.log(b.vBird); //45
b.getVBird(); // 45
```

###构造函数模式 + 共享原型

> 优点：获得父对象成员的真实副本，并且不会有子对象意外覆盖父对象的风险，提供简短迅速的原型查询，所有对象共享一个原型
> 缺点：继承链下，某处子对象或者子孙对象修改了了原型，直接会影响父对象和祖先对象

```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

var bird = function(){
    Bird.call(this);
};
bird.prototype = Bird.prototype;
bird.prototype.vBird = 60;
var b = new bird();
console.log(Bird.prototype.vBird); //60
```

###临时构造函数模式

用于获取父对象原型的代理----被称为完美的继承，圣杯

> 优点：通过断开父对象和子对象的原型间的直接链接关系，从而解决共享同一个原型所带来的的问题，还能继承原型。另外，子对象仅继承了原型的属性，父级构造函数的任何成员不会被继承

```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

//断开父对象和子对象的原型间的直接链接关系
var F = function(){};
F.prototype = Bird.prototype;

var bird = function(){};
bird.prototype = new F();
bird.constructor = bird;

var b = new bird();
console.log(typeof b.getVBird); //function
console.log(b.vBird); //undefined
```

###原型继承

>优点：通过断开父对象和子对象的原型间的直接链接关系，从而解决共享同一个原型所带来的的问题，还能继承原型。另外，子对象可以仅继承了原型的属性，父级构造函数的任何成员不会被继承。

```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

//Object.create() 方法的实现原理
var Obj = function(f) {
    function F(){};
    F.prototype = f;
    return new F();
};

 //选择继承整个构造函数和原型
var bird = new Bird();
var b = new Obj(bird);
console.log(typeof b.getVBird); //function
console.log(b.vBird); //45

//可以选择只继承原型的属性，父级构造函数的任何成员不会被继承
var bird = Obj(Bird.prototype);	//选择继承原型，并且child的原型是空对象
console.log(typeof bird.getVBird); //function，继承了父构造函数的原型
```

###优化的临时构造函数模式--最后的圣杯，适用于项目的最佳方法

> 优点：避免每次需要继承时都创建临时构造函数，可以使用闭包存储这个临时构造函数,使之只创建一次。
> 子对象想要添加新的可复用方法到父对象原型中就显得有点麻烦，所以存储原始父对象的引用

```sh
var inherit = (function(){
    var F = function(){};
    return function(C, P) {
        F.prototype = P.prototype;
        C.prototype = new F();

        //存储原始父对象的引用
        C.uper = P.prototype;

        //重置子对象的构造函数指针
        C.prototype.constructor = C;
    };
}());

function Bird(vBird){
    this.vBird = vBird || 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};
var bird = function(vBird){
    Bird.call(this, vBird);
};

inherit(bird, Bird);

var b = new bird(50);
console.log(b.getVBird()); //50
```

###针对构造函数模式，通过object.create(object)来实现

object.create()接收一个对象，这个对象的属性将会添加到新对象中，object.create()返回一个新对象。

```sh
function Bird(){
    this.vBird = 45;
};

Bird.prototype.getVBird = function(){
    return this.vBird;
};

var bird = function(){
    Bird.call(this);
};
bird.prototype = Object.create(Bird.prototype);
var b = new bird();
console.log(b.vBird); //45
console.log(b.getVBird()); //45
```

###针对字面量模式，通过object.create(object, descripts)来实现

```sh
var Bird = {
    vBird : 45,
    getVBird :function(){
        return this.vBird;
    }
};
var bird =  Object.create(Bird);
console.log(bird.getVBird()); //45 继承了对象自身属性


//字面量对象继承 + 传入属性
var Bird = {
    vBird : 45,
    getVBird :function(){
        return this.vBird;
    }
};
var bird =  Object.create(Bird, {
    x: {
        value: 1,
        writable: true,
        configurable: true,
        enumerable: true
    },
    y: {
        value: 'mh',
        writable: true,
        configurable: true,
        enumerable: true
    }
});
console.log(bird.getVBird()); //45 继承了对象自身属性
console.log(bird.x); //1
console.log(bird.y); //mh
```

###浅复制

通过遍历，把一个对像赋值给一个变量时,那么这个变量所指向的仍就是原来对像的地址/引用就是浅拷贝。当修改子对象的对象和数组时，这些操作也会修改父对象。

```sh
function extend(parent, child) {
    var i,
        child = child || {};
    for (i in parent){
        if(parent.hasOwnProperty(i)){
            child[i] = parent[i];
        }
    }
    return child;
}
var Bird = {
    vBird : 45,
    colors: ['blue', 'yellow'],
    getVBird :function(){
        return this.vBird;
    }
};

var bird = extend(Bird);
console.log(bird.getVBird()); //45 继承了Bird
bird.colors.push('red'); //修改子对象
console.log(Bird.colors.toString()); //blue,yellow,red  父对象引用类型也跟着被修改
```

###深复制

不仅复制对象的基本类,同时也复制原对象中的对象.就是说完全是新对象产生的，新对象所指向的不是原来对像的地址。这也是clone的原理。

```sh
function extendDeep(parent, child) {
    var i,
        child = child || {},
        toStr = Object.prototype.toString,
        arrStr = '[object Array]';
    for (i in parent){
        if(parent.hasOwnProperty(i)){
            if(typeof parent[i] === "object"){
                child[i] = (toStr.call(parent[i]) === arrStr) ? [] : {};
                extendDeep(parent[i], child[i]); //递归实现复制对象内的对象或者数组
            }else{
                child[i] = parent[i];
            }
        }
    }

    return child;
}

var Bird = {
    vBird : 45,
    colors: ['blue', 'yellow'],
    getVBird :function(){
        return this.vBird;
    }
};

var bird = extendDeep(Bird);
console.log(bird.getVBird()); //45 继承了Bird
bird.colors.push('red'); //修改子对象，blue,yellow,red
console.log(Bird.colors.toString()); //blue,yellow  父对象没有被修改
```

###借用方法

只需要使用对象的一个或两个方法，但又不希望继承那些永远用不到的方法。受益于call()和apply()。

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
console.log(Bird.getVBird.call(bird)); //60，bird借用Bird中的getVBird方法
```

在借用的方法中this指向的对象取决于调用表达式，应该预先将其绑定到特定对象。在客户端编程中有大量的事件和回调，所以这些场景发生很多：

this将指向全局变量

```sh
//给变量赋值时，this将指向全局变量
var Bird = {
    vBird : 45,
    colors: ['blue', 'yellow'],
    getVBird :function(whichBird){
        return whichBird + '的速度是 ' + this.vBird;
    }
};
var getV = Bird.getVBird;
getV('redBird'); // "redBird的速度是 undefined"


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
上面两种情况，this指向了全局变量，所以需要将绑定对象和方法间的联系。
bind函数接受被绑定对象和要借用的对象的方法，通过闭包访问被绑定的对象和方法，在bind函数返回后，仍可访问，并总是指向原始被绑定的对象和方法。
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

###bind方法

ECMAScript5 将bind添加到function.prototype中。

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
