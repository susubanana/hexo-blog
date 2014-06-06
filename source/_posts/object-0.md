title: javascript面向对象--对象的创建
date: 2013-12-17 18:50:51
categories: [web开发]
tags: [javascript]
---

对象的创建
----------------------

对象就是无序属性的集合，可以理解成名值对的集合，其中值可以是数据，也可以是函数。

###工厂模式

解决代码重复问题，却无法识别对象类型

```sh
function createPerson(name){
　　var o = new Object();
　　o.name = name;
　　o.sayName = function() {
　　alert(this.name);
　　};
　　return o;
}
var person = createPerson('syh');
person.sayName();
```
<!--more-->
###构造函数

缺点是，对象的方法在每一次创建实例都要重新创建，不利于代码复用。

```sh

function Person(name) {
　　this.name = name;
　　this.sayName = function() {
　　alert(this.name);
　　};
}
var per = new Person('syh');
per.sayName();
```

###原型模式

让所有实例对象共享它所包含的属性和方法，当为对象实例添加一个属性，会屏蔽掉原型对象中保存的同名属性，但其他实例还是原型对象的属性值。缺点是共享属性，一旦是引用类型的属性，会带来问题。

```sh
function Person(){}
Person.prototype.name = 'syh';
Person.prototype.sayName = function() {
alert(this.name);
};
var per = new Person();
per.sayName();
```

> 理解原型
> 每个构造函数都有一个原型对象，原型对象都包含一个指向构造函数的指针（constructor），而实例都包含一个内存指针[[prototype]]指向这个原型对象。
> 重写原型对象，会切断现有原型与任何之前已经存在的对象实例的联系，因为实例的[[prototype]]属性仅仅是一个指针，指向原型，一旦将原型对象指向新的构造函数，实例的[[prototype]]仍然指向旧的构造函数的原型对象。

###组合构造函数模式和原型模式

使用最广泛的方法

```sh
function Person(name) {
　　this.name = name;
}
Person.prototype = {
　　constructor: Person,
　　sayName: function(){
　　alert(this.name);
　　}
};
var per = new Person('syh');
per.sayName();
```

