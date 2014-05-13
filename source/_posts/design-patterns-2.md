title: javascript设计模式--装饰者模式
date: 2014-01-08 16:15:32
categories: [web开发]
tags: [javascript探秘]
---

装饰者模式
-------------------------

> 从单一的普通对象开始，针对已有功能动态添加附加功能到对象中，而不需要大量修改原有的底层代码。
> 装饰者用于包装同接口的对象，不仅允许你向方法添加行为，而且还可以将方法设置成原始对象调用
> 装饰者模式是为已有功能动态地添加更多功能的一种方式，把每个要装饰的功能放在单独的函数里，然后用该函数包装所要装饰的已有函数对象，因此，当需要执行特殊行为的时候，调用代码就可以根据需要有选择地、按顺序地使用装饰功能来包装对象。

假设鸟飞行的时候是匀速，在瀑布中冲浪的加速下降，遇到危险袭击死里逃生。

###实现方式一：使每一个装饰者成为一个对象

```sh
var Bird = function(){
    this.vBird = 45;
}
Bird.prototype.getVBird = function(){
    return this.vBird;
}
Bird.prototype.decorate = function(decorator){
    var F = function(){};
    var currentObj = this.constructor.decorators[decorator];
    var newObj = function(){};
    var i;
    F.prototype = this;
    newObj = new F();
    newObj.uber = F.prototype;
    for (i in currentObj){
        if(currentObj.hasOwnProperty(i)){
            newObj[i] = currentObj[i];
        }
    }
    return newObj;
}
Bird.decorators = function(){};

//瀑布中冲浪
Bird.decorators.surfing = {
    getVBird: function(){
        var vBird = this.uber.getVBird();
        var acceleration = 3.5;
        var time = 10;
        return vBird = vBird + acceleration * time;
    }
}


//死里逃生
Bird.decorators.escape = {
    getVBird: function(){
        var vBird = this.uber.getVBird();
        var acceleration = 5;
        var time = 5;
        return vBird = vBird + acceleration * time;
    }
}

Bird = Bird.prototype.decorate('surfing');
Bird = Bird.prototype.decorate('escape');
Bird.getVBird();
```



