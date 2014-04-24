title: javascript设计模式--单例模式
date: 2014-01-06 19:10:32
tags: [javascript探秘]
---

单例模式
-------------------------

> 其思想是保证一个特定的类仅有一个实例，每次初始化的对象都是同一个对象。
> 单例的存在往往表明系统中要么紧密耦合，要么逻辑过于分散在其他模块中。如游戏中某个对象的状态需要在其他模块中通信。
> 单例可以用来划分命名空间，并将一批相关方法和属性组织在一起的对象，如果它可以被实例化，那么它只能被实例化一次。

使用对象字面量创建对象就是一个单例。

```sh
var Bird = {
    vBird : 45,
    getVBird :function(){
        return this.vBird;
    }
};
```

也可以使用构造函数方式创建单例，什么时候使用这种语法的单例实现呢，在于当使用同一个构造函数实例化多个对象时，应该指向完全相同的对象。

可以有多种方式实现：

在构造函数的静态属性中缓存该实例：

> 优点：是一个很好的实现单例方式。
> 缺点：但是静态属性instance是公有属性，容易被外界修改，造成对象丢失，但是一般也不太可能修改该属性。

```sh
var Bird = function() {
    //实例是否存在
    if(typeof Bird.instance === 'object'){
        return Bird.instance;
    }
    this.vBird = 45;

    //静态属性中缓存该实例
    Bird.instance = this;
    return this;
};
Bird.prototype.getVBird = function(){
   return this.vBird;
}
var bird = new Bird();
var bird2 = new Bird();
console.log(bird === bird2); //true

//修改instance属性，对象丢失
Bird.instance = null;
var bird = new Bird();
var bird2 = new Bird();
console.log(bird === bird2); //false
```

将构造函数和实例封装在即时函数中，在第一次调用构造函数的时候创建一个对象，并使私有变量instance指向这个对象。第二次调用的时候，返回该私有变量：

> 优点：保证实例的私有性，不会被外界修改
> 缺点：额外的闭包开销。

```sh
var bird = (function(){
    var instance;
    var Bird = function() {
        //实例是否存在
        if(instance){
            return instance;
        }
        this.vBird = 45;

        //静态属性中缓存该实例
        instance = this;
    };
    Bird.prototype.getVBird = function(){
       return this.vBird;
    }
    return Bird;
}());

var b1 = new bird();
var b2 = new bird();
console.log(b1 === b2); //ture
```

