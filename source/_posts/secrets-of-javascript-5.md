title: javascript高级技巧--高阶函数
date: 2013-12-12 19:15:44
categories: [web开发]
tags: [javascript]
---

高阶函数
----------------------

> 高阶函数是用函数封装好重复或者相似的代码，作为参数（回调函数）或者返回值的函数。
> 需要引入高阶函数的信号是出现重复相似的代码
> 实现了高阶函数抽象出来重复代码，进行优化操作时，仅需操作一处。

假设用26位英文字符实现字符串：
```sh
var aIndex = "a".charCodeAt(0);
var alphabet = '';
for(var i = 0; i < 26; i++){
    alphabet += String.fromCharCode(aIndex + i);
}
console.log(alphabet); //abcdefghijklmnopqrstuvwxyz
```
<!--more-->
生成一串数字组成的字符串：

```sh
var digits = '';
for(var i = 0; i < 10; i++){
    digits += i;
}
console.log(digits); //0123456789
```

通过上面两个相似的代码，可以抽象出来一个高阶函数：

```sh
//buildString函数实现了相似部分，并将变化部分作为参数传递
function buildString(n, callback){
    var str = '';
    for(var i = 0; i < n; i++){
        str += callback(i);
    }
    return str;
}
var aIndex = "a".charCodeAt(0);
var alphabet = buildString(26, function(i){
    return String.fromCharCode(aIndex + i);
});
console.log(alphabet); //abcdefghijklmnopqrstuvwxyz

var digits = buildString(10, function(i){
    return i;
});
console.log(digits); //0123456789
```
