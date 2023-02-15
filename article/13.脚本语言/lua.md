# lua

## 1.引言
今天讲一些redis和lua脚本的相关的东西，lua这个脚本是一个好东西，可以运行在任何平台上，也可以嵌入到大多数语言当中，来扩展其功能。
lua脚本是用C语言写的，体积很小，运行速度很快，并且每次的执行都是作为一个原子事务来执行的，我们可以在其中做很多的事情。
由于篇幅很多，一次无法概述全部，这个系列可能要通过多篇文章的形式来写，好了，今天我们进入正题吧。

## 2.Lua简介
Lua 是一个小巧的脚本语言。是巴西里约热内卢天主教大学（Pontifical Catholic University of Rio de Janeiro）里的一个研究小组，
由Roberto Ierusalimschy、Waldemar Celes 和 Luiz Henrique de Figueiredo所组成并于1993年开发。 
其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。Lua由标准C编写而成，几乎在所有操作系统和平台上都可以编译，运行。
Lua并没有提供强大的库，这是由它的定位决定的。所以Lua不适合作为开发独立应用程序的语言。Lua 有一个同时进行的JIT项目，提供在特定平台上的即时编译功能。
Lua脚本可以很容易的被C/C++ 代码调用，也可以反过来调用C/C++的函数，这使得Lua在应用程序中可以被广泛应用。不仅仅作为扩展脚本，
也可以作为普通的配置文件，代替XML,ini等文件格式，并且更容易理解和维护。 Lua由标准C编写而成，代码简洁优美，几乎在所有操作系统和平台上都可以编译，运行。
一个完整的Lua解释器不过200k，在目前所有脚本引擎中，Lua的速度是最快的。这一切都决定了Lua是作为嵌入式脚本的最佳选择。

## 3.使用Lua脚本的好处
1. 减少网络开销：可以将多个请求通过脚本的形式一次发送，减少网络时延和请求次数。
2. 原子性的操作：Redis会将整个脚本作为一个整体执行，中间不会被其他命令插入。因此在编写脚本的过程中无需担心会出现竞态条件，无需使用事务。
3. 代码复用：客户端发送的脚步会永久存在redis中，这样，其他客户端可以复用这一脚本来完成相同的逻辑。
4. 速度快：还有一个 JIT编译器可以显著地提高多数任务的性能; 对于那些仍然对性能不满意的人, 可以把关键部分使用C实现, 然后与其集成, 这样还可以享受其它方面的好处。
5. 可以移植：只要是有ANSI C 编译器的平台都可以编译，你可以看到它可以在几乎所有的平台上运行:从 Windows 到Linux，同样Mac平台也没问题, 再到移动平台. 游戏主机，甚至浏览器也可以完美使用 (翻译成JavaScript).
6. 源码小巧：20000行C代码，可以编译进182K的可执行文件，加载快，运行快。

## 4.安装&语法

官网： http://www.lua.org/

语法： http://www.runoob.com/lua/lua-tutorial.html

```text
系统可能自带了lua。一般都是高本版的。我们可以继续安装低版本的lua，多个版本可以共存

1.下载 ：
  wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz
2.解压编译：
    tar -zxvf  LuaJIT-2.0.5.tar.gz
    cd LuaJIT-2.0.5
    make install
    
    安装成功的信息，我们可以看到安装的位置
    ==== Installing LuaJIT 2.0.5 to /usr/local ====
    mkdir -p /usr/local/bin /usr/local/lib /usr/local/include/luajit-2.0 /usr/local/share/man/man1 /usr/local/lib/pkgconfig /usr/local/share/luajit-2.0.5/jit /usr/local/share/lua/5.1 /usr/local/lib/lua/5.1
    cd src && install -m 0755 luajit /usr/local/bin/luajit-2.0.5
    cd src && test -f libluajit.a && install -m 0644 libluajit.a /usr/local/lib/libluajit-5.1.a || :
    rm -f /usr/local/bin/luajit /usr/local/lib/libluajit-5.1.so.2.0.5 /usr/local/lib/libluajit-5.1.so /usr/local/lib/libluajit-5.1.so.2
    cd src && test -f libluajit.so && \
      install -m 0755 libluajit.so /usr/local/lib/libluajit-5.1.so.2.0.5 && \
      ldconfig -n /usr/local/lib && \
      ln -sf libluajit-5.1.so.2.0.5 /usr/local/lib/libluajit-5.1.so && \
      ln -sf libluajit-5.1.so.2.0.5 /usr/local/lib/libluajit-5.1.so.2 || :
    cd etc && install -m 0644 luajit.1 /usr/local/share/man/man1
    cd etc && sed -e "s|^prefix=.*|prefix=/usr/local|" -e "s|^multilib=.*|multilib=lib|" luajit.pc > luajit.pc.tmp && \
      install -m 0644 luajit.pc.tmp /usr/local/lib/pkgconfig/luajit.pc && \
      rm -f luajit.pc.tmp
    cd src && install -m 0644 lua.h lualib.h lauxlib.h luaconf.h lua.hpp luajit.h /usr/local/include/luajit-2.0
    cd src/jit && install -m 0644 bc.lua v.lua dump.lua dis_x86.lua dis_x64.lua dis_arm.lua dis_ppc.lua dis_mips.lua dis_mipsel.lua bcsave.lua vmdef.lua /usr/local/share/luajit-2.0.5/jit
    ln -sf luajit-2.0.5 /usr/local/bin/luajit
    ==== Successfully installed LuaJIT 2.0.5 to /usr/local ====
    
3.环境变量
    vim /etc/profile
    
    export LUAJIT_LIB=/usr/local/lib
    export LUAJIT_INC=/usr/local/include/luajit-2.0
    
    soource    /etc/profile
    
4.查看版本： lua -v
    Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
```