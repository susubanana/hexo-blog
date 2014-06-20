title: jQuery源码解读 -- jQuery对象的初始化
date: 2014-06-19 09:59:13
tags: [jQuery]
---

jQuery 对象的初始化
--------------------------

**jQuery对象构造函数**：

```sh
var jQuery = function( selector, context ) {
    // The jQuery object is actually just the init constructor 'enhanced'
    // Need init if jQuery is called (just allow error to be thrown if not included)
    return new jQuery.fn.init( selector, context );
},

```

这里定义了jQuery对象，返回jQuery.fn.init的实例，也就是说jQuery对象是jQuery.fn.init的实例。
<!--more-->
**jQuery.fn.init的定义如下**：

```sh
var rootjQuery,

	// Use the correct document accordingly with window argument (sandbox)
	document = window.document,

	// A simple way to check for HTML strings
	// Prioritize #id over <tag> to avoid XSS via location.hash (#9521)
	// Strict HTML recognition (#11290: must start with <)
	rquickExpr = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/,

init = jQuery.fn.init = function( selector, context ) {
    var match, elem;

    // HANDLE: $(""), $(null), $(undefined), $(false)
    if ( !selector ) {
        return this;
    }
    ...
};

// Give the init function the jQuery prototype for later instantiation
init.prototype = jQuery.fn;

// Initialize central reference
rootjQuery = jQuery( document );
```

**jQuery对象的原型**：

```sh
jQuery.fn = jQuery.prototype = {
	// The current version of jQuery being used
	jquery: version,

	constructor: jQuery,

	// Start with an empty selector
	selector: "",
    ...
}
```
这里定义了jQuery的原型就是jQuery.fn


由上面三段代码得知关系如下：

```sh
var jQuery = new jQuery.fn.init( selector, context );
jQuery.fn = jQuery.prototype;
var init = jQuery.fn.init = function( selector, context ) {...};
init.prototype = jQuery.fn;
```

最终的关系结果是：
jQuery = new jQuery.fn.init( selector, context );
jQuery.fn.init.prototype = init.prototype = jQuery.fn = jQuery.prototype;

从代码上看，jQuery是jQuery.fn.init的实例。所有挂载到jQuery.fn的方法或者属性，挂载到jQuery.prototype上，即挂载到jQuery对象的原型上，但最终相当于挂载到了 jQuery.fn.init.prototype上，即挂载到了最终使用的jQuery对象上。

这里比较绕，但是经过测试，这里是为了**保护jQuery对象**，当外部环境发生改变的时候，jQuery对象很容易被修改。

假设新手不小心将jQuery的原型重定义，这个时候jquery对象原型已经被修改，但是` $(document).on('click', '.nav-list li', function(){}`仍然可以正常使用：
```sh
jQuery.prototype = {}
alert(jQuery.fn.init.prototype.extend) //function(){...}
alert(jQuery.prototype.extend) //undefined
```
这里说明jQuery对象原型的重定义对代码使用并无影响。

假设刻意将jQuery.fn.init.prototype对象重定义（傻瓜才会这么干，为了测试，找出它们的关系），这个时候` $(document).on('click', '.nav-list li', function(){}`没法正常使用，会报`Uncaught TypeError: undefined is not a function `错误：
```sh
jQuery.fn.init.prototype = {}
alert(jQuery.prototype.extend) //undefined
```
为啥jQuery对象没被更改，但是代码却不能正常使用？原因在于：
```sh
jQuery.fn.init.prototype = init.prototype = jQuery.fn;
```
jQuery.fn.init.prototype 和 jQuery.fn 的引用指向同一个引用地址，所有方法或者属性挂载到jQuery.fn上，jQuery.fn加强了内部的封装，也就是说真正在内部起作用的是jQuery.fn，而jQuery.fn.init.prototype作为载体，再将属性和方法又挂载到刚开始定义的jQuery对象上。

### jQuery.fn.init生成jQuery对象的过程

这个函数接收三个参数，分别是选择器，上下文和root，

源码：
```sh
var	init = jQuery.fn.init = function( selector, context ) {
    var match, elem;

    //如果选择器为空、null、undefined的时候，返回空的jQuery对象
    if ( !selector ) {
        return this;
    }

    // 如果selector是字符串
    if ( typeof selector === "string" ) {
        //通过正则判断传入的选择器是HTML字符串还是ID
        if ( selector.charAt(0) === "<" && selector.charAt( selector.length - 1 ) === ">" && selector.length >= 3 ) {
            // Assume that strings that start and end with <> are HTML and skip the regex check
            match = [ null, selector, null ];

        } else {
            match = rquickExpr.exec( selector );
        }

        // 如果match[1]不为空或者context为空的时候
        if ( match && (match[1] || !context) ) {

            // 如果match[1] 不为空（即为html字符串）
            if ( match[1] ) {
                context = context instanceof jQuery ? context[0] : context;

                // scripts is true for back-compat
                // Intentionally let the error be thrown if parseHTML is not present
                // 返回jQuery、选择器两数组合并后的对象
                jQuery.merge( this, jQuery.parseHTML(
                    match[1],
                    context && context.nodeType ? context.ownerDocument || context : document,
                    true
                ) );

                // HANDLE: $(html, props)
                if ( rsingleTag.test( match[1] ) && jQuery.isPlainObject( context ) ) {
                    for ( match in context ) {
                        // Properties of context are called as methods if possible
                        if ( jQuery.isFunction( this[ match ] ) ) {
                            this[ match ]( context[ match ] );

                        // ...and otherwise set as attributes
                        } else {
                            this.attr( match, context[ match ] );
                        }
                    }
                }

                return this;

            // HANDLE: $(#id)
            // 如果context为空的时候，直接调用getElementById来选择元素 （即为id）
            } else {
                elem = document.getElementById( match[2] );

                // Check parentNode to catch when Blackberry 4.6 returns
                // nodes that are no longer in the document #6963
                if ( elem && elem.parentNode ) {
                    // Handle the case where IE and Opera return items
                    // by name instead of ID
                    if ( elem.id !== match[2] ) {
                        return rootjQuery.find( selector );
                    }

                    // Otherwise, we inject the element directly into the jQuery object
                    this.length = 1;
                    this[0] = elem;
                }

                this.context = document;
                this.selector = selector;
                return this;
            }

        // HANDLE: $(expr, $(...))
        // 如果context为空 或者 context是一个jQuery对象，则直接调用context.find(selector)
        } else if ( !context || context.jquery ) {
            return ( context || rootjQuery ).find( selector );

        // HANDLE: $(expr, context)
        // (which is just equivalent to: $(context).find(expr)
        } else {
            return this.constructor( context ).find( selector );
        }

    // HANDLE: $(DOMElement)
    } else if ( selector.nodeType ) {
        this.context = this[0] = selector;
        this.length = 1;
        return this;

    // HANDLE: $(function)
    // 如果selector是一个函数，则在$(document).ready(functon(){})中调用此函数
    // 对$(document).ready(functon(){});的一个缩写$(function(){});
    } else if ( jQuery.isFunction( selector ) ) {
        return typeof rootjQuery.ready !== "undefined" ?
            rootjQuery.ready( selector ) :
            // Execute immediately if ready is not present
            selector( jQuery );
    }

     // 如果选择器是一个jQuery对象
    if ( selector.selector !== undefined ) {
        this.selector = selector.selector;
        this.context = selector.context;
    }

    return jQuery.makeArray( selector, this );
};

// Give the init function the jQuery prototype for later instantiation
init.prototype = jQuery.fn;

// Initialize central reference
rootjQuery = jQuery( document );
```



http://www.360doc.com/content/13/1128/09/10504424_332741972.shtml
http://nuysoft.iteye.com/blog/1190542