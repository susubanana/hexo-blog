title: node.js--异步I/O与非阻塞I/O
date: 2014-03-10 19:27:10
categories: [nodejs]
tags: [node.js]
---

异步、非阻塞容易导致学习的概念混淆，听起来貌似一回事。从实际效果上看，两者都实现了并行I/O的目的。但是从计算机内核I/O看，两者实际上是两回事。

阻塞与非阻塞
-------------------------

操作系统内核对于I/O只有两种方式：阻塞与非阻塞

###阻塞I/O

> 线程在执行中遇到I/O操作，耗时较长，这时操作系统会剥夺其CPU的控制权，使其暂停执行，同时将资源让给其他工作线程，这种线程调度方式称为阻塞。
> 当I/O操作完毕，操作系统将这个线程的阻塞状态解除，恢复其控制权，令其继续执行。
> 阻塞I/O造成CPU浪费时间等待I/O，CPU的处理能力得不到充分利用。

###非阻塞I/O
<!--more-->
> 线程遇到I/O操作时，将I/O请求发送给操作系统，立即返回当前调用状态。为了获取完整的数据，应用程序需要不断调用I/O操作是否完成。
> 它会浪费CPU资源处理状态判断，处理期间，CPU仍然需要浪费时间等待。

异步I/O
--------------------------

> 线程遇到I/O操作时，将I/O请求发送给操作系统，立即返回并继续执行下一个语句。
> 操作系统完成I/O操作后，以事件的形式通知执行I/O的线程，线程会事件循环队列中，依次检查并处理事件。
> 应用程序发起非阻塞调用，无须CPU等待，直接处理下一个任务，只需回调将数据传递给应用程序即可。

Node的异步I/O
--------------------------

node.js用异步式I/O和事件驱动代替多线程提升性能，除了使用高效的V8作为JavaScript引擎外还使用了高效的libev和libeio库支持事件驱动和异步I/O。

###事件循环

Node是由事件循环开始，到事件循环结束，所有的逻辑都是事件的回调函数。

> 每一次执行事件循环，都会检查事件队列是否有未处理事件，有则处理事件及其相关的回调函数，直到程序结束。
> Node没有显式的事件循环，其由底层libev库实现。

###观察者

每次事件循环有一个或者多个观察者（就是事件监听器），异步I/O或者网络请求不断为Node提供事件，事件传递到对应的观察者中，libev事件循环从观察者中询问是否有事件需要被处理。

###请求对象

在Node的异步I/O的回调函数并不是由程序员来调用，而是javascript代码通过调用C++核心模块进行底层工作，内建模块通过libuv进行系统调用。请求对象是异步I/O过程中的中间产物，javascript层传入的参数和当前方法都封装在这个请求对象中，包括送入线程池等待执行以及I/O操作完毕后的回调处理这些状态都会保存在这个请求对象中。

<img src="/images/cont/nodejs-0.jpg" style="display:block;"/>

node.js作者在libeio和libev的基础上抽象出了libuv层，对于POSIX(Portable Operating System Interface 是一套操作系统API规范，遵循的有Unix、Linux、Mac OS X等)操作系统下，libuv通过封装libev和libio来利用epoll或kqueue。而在Windows下libuv使用了IOCP（Input/Output Completion Port,I/O完成端口）机制实现异步I/O。

> epoll是linux下效率最高的I/O事件通知机制，在进入轮询的时候如果没有检查到I/O事件则进入休眠状态，直到事件发生将它唤醒。它是真实利用时间通知执行回调机制，而不是遍历查询，所以不会浪费CPU。

###执行回调

封装好请求对象，送入I/O线程池等待执行，这是完成I/O的第一部分，回调通知是第二部分，事件循环的I/O观察者会调用相关方法检查线程池中是否有执行完成的请求，有则将请求对象加入I/O观察者的事件队列中，回调函数取出请求对象调用执行，以此达到javascript中传入回调函数的目的。

整个异步I/O流程如图：

<img src="/images/cont/nodejs-01.jpg" style="display:block;"/>

libuv 与 libev 的对比
--------------------------

来源自：https://www.idndx.com/2013/01/05/comparison-between-libuv-and-libev/

libuv 和 libev ，两个名字相当相近的 I/O Library，最近有幸用两个 Library 都写了一些东西，下面就来说一说我本人对两者共同与不同点的主观表述。

高性能网络编程这个话题已经被讨论烂了。异步，异步，还是异步。不管是 epoll 也好，kqueue 也罢，总是免不了异步这个话题。

libev 是系统异步模型的简单封装，基本上来说，它解决了 epoll ，kqueuq 与 select 之间 API 不同的问题。保证使用 livev 的 API 编写出的程序可以在大多数 *nix 平台上运行。但是 libev 的缺点也是显而易见，由于基本只是封装了 Event Library，用起来有诸多不便。比如 accept(3) 连接以后需要手动 setnonblocking 。从 socket 读写时需要检测 EAGAIN 、EWOULDBLOCK 和 EINTER 。这也是大多数人认为异步程序难写的根本原因。

libuv 则显得更为高层。libuv 是 joyent 给 Node 做的一套 I/O Library 。而这也导致了 libuv 最大的特点就是处处回调。基本上只要有可能阻塞的地方，libuv 都使用回调处理。这样做实际上大大减轻了程序员的工作量。因为当回调被 call 的时候，libuv 保证你有事可做，这样 EAGAIN 和 EWOULDBLOCK 之类的 handle 就不是程序员的工作了，libuv 会默默的帮你搞定。

libev 在 socket 发生读写事件时，只告诉你，“XX socket 可以读/写了，自己看着办吧”。往往我们需要自己申请内存并调用 read(3) 或者 write(3) 来响应 I/O 事件。

libuv 则稍微复杂一些，我们分读/写两个部分来描述。

当接口可读时，libuv 会调用你的 allocate callback 来申请内存并将读到的内容写入。当读取完毕后，libuv 会 call 你为这个 socket 设置的回调函数，在参数中带着这个 buffer 的信息。你只需要负责处理这个 buffer 并且 free 掉就OK了。因为是从 buffer 中读取数据，在你的 callback 被调用时数据已经 ready 了，所以程序员也就不用考虑阻塞的问题了。

而对写的处理则更显巧妙。libuv 没有 write callback ，如果你想写东西，直接 generate 一个 write request 连着要写的 buffer 一起丢给 libuv ，libuv 会把你的 write request 加进相应 socket 的 write queue ，在 I/O 可写时按顺序写入。

C 没有闭包，所以确定读写上下文是 libuv 的使用者需要面对的问题。否则程序面对汹涌而来的 buffer 也不能分得清哪个是哪个的数据。在这一点的处理上，libuv 跟 libev 一样，都是使用了一个 void *data 来解决问题。你可以用 data 这个 member 存储任何东西，这样当 buffer 来的时候，只需要简单的把 data cast 到你需要的类型就 OK 了。

libev 没有异步 DNS 解析，这一点一直广为垢病。

libuv 有异步的 DNS 解析，解析结果也是通过回调的方式通知程序。

libev 完全是单线程的。

libuv 需要多线程库支持，因为其在内部维护了一个线程池来 handle 诸如 getaddrinfo(3) 这样的无法异步的调用。

libev 貌似是作者一个人在开发，版本管理使用的还是 CVS ，社区参与度明显不高。

libuv 社区十分活跃，几乎每天都有人提出 Issue 并贡献代码。

libev 不支持 IOCP ，如果需要在 Win 下运行的程序会很麻烦。

libuv 支持 IOCP ，有相应脚本编译 Win 下的库。


























