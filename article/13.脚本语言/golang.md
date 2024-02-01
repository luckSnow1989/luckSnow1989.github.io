# golang

## 1.教程
- 官网：[https://pkg.go.dev/](https://pkg.go.dev/)

基础教程
- golang中文网【可以在线执行代码】[https://tour.go-zh.org/list](https://tour.go-zh.org/list)
- [Go语言圣经（中文版）](https://books.studygolang.com/gopl-zh/)
- [简单教程](https://www.runoob.com/go/go-tutorial.html)

高级教程
- [学习参考博客](https://www.liwenzhou.com/posts/Go/golang-menu/)
- [案例](https://www.cnblogs.com/zhanchenjin/category/2166310.html?page=1)

- (零)入门级日常开发 https://code2life.top/2018/08/01/0028-go-snippets-1 
- (一)文本处理与编解码 https://code2life.top/2018/07/31/0028-go-snippets-2 
- (二)数学计算与加解密 https://code2life.top/2018/07/30/0028-go-snippets-3 
- (三)操作系统与进程操作 https://code2life.top/2018/07/29/0028-go-snippets-4 
- (四)网络编程基础篇 https://code2life.top/2018/07/28/0028-go-snippets-5 
- (五)网络编程框架篇 https://code2life.top/2018/07/27/0028-go-snippets-6 
- (六)远程方法调用 https://code2life.top/2018/07/26/0028-go-snippets-7 
- (七)数据库访问和操作 https://code2life.top/2018/07/25/0028-go-snippets-8 
- (八)常用中间件使用 https://code2life.top/2018/07/24/0028-go-snippets-9 
- (九)日志记录与链路追踪 https://code2life.top/2018/07/23/0028-go-snippets-10
- (十)多编程语言交互 https://code2life.top/2018/07/22/0028-go-snippets-11

实现原理：
- Go 语言设计与实现[https://draveness.me/golang/](https://draveness.me/golang/)
- golang 内存模型[https://go.dev/ref/mem](https://go.dev/ref/mem)
- [接口实现原理](https://blog.csdn.net/Sheena997/article/details/129556912)

## 2.介绍

1.Go 是一个开源的编程语言，它能让构造简单、可靠且高效的软件变得容易。【没有继承、多态，没有复杂设计思想，没有复杂设计模式】

2.Go 语言特色
- 简洁、快速、安全
- 并行、有趣、开源
- 内存管理、数组安全、编译迅速

3.Go 语言用途
   
Go语言被设计成一门应用于搭载 Web 服务器，存储集群或类似用途的巨型中央服务器的系统编程语言。
对于高性能分布式系统领域而言，Go语言无疑比大多数其它语言有着更高的开发效率。
它提供了海量并行的支持，这对于游戏服务端的开发而言是再好不过了。

## 3.安装
- window：安装即可，自动配置环境变量：GOROOT=c:/go/
- 为了开发方便增加环境变量：GOPATH=C:/go/workspace/(开发项目的工作空间)

Linux安装
```shell
## 下载解压即可
cd /data/golang
wget https://go.dev/dl/go1.20.linux-amd64.tar.gz
tar -zxvf go1.20.linux-amd64.tar.gz
mv go go1.20
mkdir workspace

## 配置环境变量
vim /etc/profile
export GOROOT=/data/golang/go1.20
export GOPATH=/data/golang/workspace
export GOBIN=$GOROOT/bin
export PATH=$PATH:$GOBIN

source /etc/profile

## 验证环境
go version
go env
```

## 4.使用

### 4.1.命令集
golang 提供了一整套工具箱：下载、格式化、构建、测试和安装等工具，通过go命令可以查看有哪些命令
```shell
C:\Users\zhangxue>go
Go is a tool for managing Go source code.
Usage:
        go <command> [arguments]
The commands are:
        bug         start a bug report
        build       compile packages and dependencies
        clean       remove object files and cached files
        doc         # 查看文档：Go语言中的文档注释一般是完整的句子，第一行通常是摘要说明，以被注释者的名字开头
        env         print Go environment information
        fix         update packages to use new APIs
        fmt         gofmt (reformat) package sources
        generate    generate Go files by processing source
        get         # 可以下载一个单一的包或者用...下载整个子目录里面的每个包
        install     compile and install packages and dependencies
        list        # 可以查询可用包的信息
        mod         module maintenance
        work        workspace maintenance
        run         compile and run Go program
        test        test packages
        tool        run specified go tool
        version     print Go version
        vet         report likely mistakes in packages
Use "go help <command>" for more information about a command.
Additional help topics:
        buildconstraint build constraints
        buildmode       build modes
        c               calling between Go and C
        cache           build and test caching
        environment     environment variables
        filetype        file types
        go.mod          the go.mod file
        gopath          GOPATH environment variable
        gopath-get      legacy GOPATH go get
        goproxy         module proxy protocol
        importpath      import path syntax
        modules         modules, module versions, and more
        module-get      module-aware go get
        module-auth     module authentication using go.sum
        packages        package lists and patterns
        private         configuration for downloading non-public code
        testflag        testing flags
        testfunc        testing functions
        vcs             controlling version control with GOVCS
Use "go help <topic>" for more information about that topic.
```

### 4.2.环境变量
使用命令查看全部环境变量
```shell
go env

set GO111MODULE=on
set GOARCH=amd64
set GOBIN=
set GOCACHE=C:\Users\zhangxue\AppData\Local\go-build
set GOENV=C:\Users\zhangxue\AppData\Roaming\go\env
set GOEXE=.exe
set GOEXPERIMENT=
set GOFLAGS=
set GOHOSTARCH=amd64
set GOHOSTOS=windows
set GOINSECURE=
set GOMODCACHE=D:\workspace\knowledge-go\pkg\mod
set GONOPROXY=
set GONOSUMDB=
set GOOS=windows
set GOPATH=D:\workspace\knowledge-go;D:\workspace\knowledge-go\src
set GOPRIVATE=
set GOPROXY=https://goproxy.cn,direct
set GOROOT=D:\Program Files\go\go1.19.2
set GOSUMDB=sum.golang.org
set GOTMPDIR=
set GOTOOLDIR=D:\Program Files\go\go1.19.2\pkg\tool\windows_amd64
set GOVCS=
set GOVERSION=go1.19.2
set GCCGO=gccgo
set GOAMD64=v1
set AR=ar
set CC=gcc
set CXX=g++
set CGO_ENABLED=1
set GOMOD=D:\workspace\knowledge-go\src\go.mod
set GOWORK=
set CGO_CFLAGS=-g -O2
set CGO_CPPFLAGS=
set CGO_CXXFLAGS=-g -O2
set CGO_FFLAGS=-g -O2
set CGO_LDFLAGS=-g -O2
set PKG_CONFIG=pkg-config
set GOGCCFLAGS=-m64 -mthreads -fno-caret-diagnostics -Qunused-arguments -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=C:\Users\zhangxue\AppData\Local\Temp\go-build2436557959=/tmp/go-build -gno-record-gcc-switches
```

- GOPATH：每个项目都有自己的工作空间，对于golang的项目只需要配置GOPATH的环境变量就可以运行。
```shell
export GOPATH=D:\workspace\my-prjects
```

- GOROOT：用来指定Go的安装目录，还有它自带的标准库包的位置
```shell
export GOROOT=D:\Program Files\go\go1.19.2
```

- GOOS：设置目标操作系统（例如android、linux、darwin或windows）。默认为本系统。

### 4.3.工程结构
当前主流的项目结构,包括bin、pkg、src三个根目录为如下
```text
# 下载代码
go get gopl.io/...

GOPATH/
    src/         源码：一个GOPATH工作区的src目录中可能有多个独立的版本控制系统
        gopl.io/
            .git/
            ch1/
                helloworld/
                    main.go
                dup/
                    main.go
        golang.org/x/net/
            .git/
            html/
                parse.go
                node.go
                ...
    bin/        bin子目录用于保存编译后的可执行程序
        helloworld
        dup
    pkg/        pkg子目录用于保存编译后的包的目标文件,y
        darwin_amd64/
```

### 4.4.内存泄漏分析

- [golang 内存泄漏分析案例](https://www.cnblogs.com/zhanchenjin/p/17101573.html)
- [golang 内存泄漏总结](https://www.cnblogs.com/zhanchenjin/p/17098100.html)
- [golang GC](https://www.cnblogs.com/zhanchenjin/p/17098294.html)

golang提供工具：pprof， Pprof是Go的性能工具，在程序运行过程中，可以记录程序的运行信息，可以是CPU使用情况、内存使用情况、goroutine运行情况等

使用pprof有多种方式，Go已经现成封装好了1个：net/http/pprof，使用简单的几行命令，就可以开启pprof，记录运行信息，并且提供了Web服务，能够通过浏览器和命令行2种方式获取运行数据。

使用方式1：浏览器打开http://localhost:6060/debug/pprof/

```golang
package main
import (
    "fmt"
    "net/http"
    _ "net/http/pprof"
)
func main() {
    // 开启pprof，监听请求
    ip := "0.0.0.0:6060"
    if err := http.ListenAndServe(ip, nil); err != nil {
        fmt.Printf("start pprof failed on %s\n", ip)
    }
}
```

- allocs：程序启动之后内存分配的情况
- block：导致阻塞操作的一些堆栈跟踪信息
- cmdline：当前程序启动的命令行
- goroutine：所有goroutine的信息，下面的full goroutine stack dump是输出所有goroutine的调用栈，是goroutine的debug=2，后面会详细介绍。
- heap：程序在当前堆上内存分配的情况
- mutex：锁的信息
- profile: CPU profile文件。可以在 debug/pprof?seconds=x秒 GET 参数中指定持续时间。获取pprof文件后，使用 go tool pprof x.prof命令分析pprof文件。
- threadcreate：线程信息
- Trace：当前系统的代码执行的链路情况

方式2：使用命令行
```shell
# 下载allocs profile
go tool pprof http://localhost:6060/debug/pprof/allocs

# 下载block profile
go tool pprof http://localhost:6060/debug/pprof/block# goroutine blocking profile

# 下载goroutine profile
go tool pprof http://localhost:6060/debug/pprof/goroutine # goroutine profile

# 下载heap profile
go tool pprof http://localhost:6060/debug/pprof/heap   # heap profile

# 下载mutex profile
go tool pprof http://localhost:6060/debug/pprof/mutex

# 下载cpu profile，默认从当前开始收集30s的cpu使用情况，需要等待30s
go tool pprof http://localhost:6060/debug/pprof/profile  # 30-second CPU profile
go tool pprof http://localhost:6060/debug/pprof/profile?seconds=120   # wait 120s

# 下载threadcreate profile
go tool pprof http://localhost:6060/debug/pprof/threadcreate

# 如果需要下载对应的图片，只需要在后面添加png即可，例如获取heap的图片
go tool pprof -png http://localhost:6060/debug/pprof/heap > heap.png
```


### 360报警

window系统使用golang编译后生成exe文件，因为没有数字签名，被判断为不安全应用，会报警并移除文件。
可以在360里：360设置中心->安全防护中心->开发者模式，设置忽略某个文件、或者文件夹。

![](img/golang/970a6e0d.png)

## 5.依赖管理

Go1.14版本之后，推荐使用go mod模式来管理依赖了，也不再强制我们把代码必须写在GOPATH下面的src目录了，你可以在你电脑的任意位置编写go代码

```shell
# 1. 初始化go mod：新建的项目，在根目录下执行，自动创建一个go.mod文件，其中包含项目名称和当前使用的Go版本
go mod init <module-name>

# 2.在go.mod文件中添加依赖，自动下载需要的资源，并将依赖配置增加到go.mod文件中。
go get <dependency>

# 3.构建和运行您的项目：
go build

# 4.更新依赖项：这将更新您的依赖项到最新版本。
go get -u

# 5. 删除项目中未使用的依赖项
go mod tidy

# 6. 这将列出所有当前使用的依赖项及其版本信息
go list -m all

# 7.清理依赖关系缓存：
go clean -modcache

# 8. 使用私有存储库：如果您使用的是私有存储库，您可以使用以下命令来进行身份验证：
go env -w GOPRIVATE=<repository-url>
将<repository-url>替换为您的私有存储库URL
```

和Java中使用maven一样，go也是有自己的库的仓库，但是地址在国外访问很慢，可以设置为国内的代理
```shell
默认GoPROXY配置是：GOPROXY=https://proxy.golang.org,direct，

由于国内访问不到，所以我们需要换一个PROXY，这里推荐使用https://goproxy.io 或 https://goproxy.cn。

命令如下：go env -w GOPROXY=https://goproxy.cn,direct
```

## 6.单元测试

[GoLand 运行选定的测试或测试文件夹](https://www.javatiku.cn/feed/atom/goland/2653.html)

以 _test.go 为后缀名的源文件在执行 go build 时不会被构建成包的一部分。
分为三种类型的函数：
- 测试函数:以Test为函数名前缀的函数，用于功能测试，go test命令会调用这些测试函数并报告测试结果是PASS或FAIL
- 基准测试函数：以Benchmark为函数名前缀的函数，用于性能测试，go test命令会多次运行基准测试函数以计算一个平均的执行时间
- 示例函数：以Example为函数名前缀的函数，提供一个由编译器保证正确性的示例文档

go test命令会遍历所有的*_test.go文件中符合上述命名规则的函数，生成一个临时的main包用于调用相应的测试函数，
接着构建并运行、报告测试结果，最后清理测试中生成的临时文件。

```shell
## -v可用于打印每个测试函数的名字和运行时间
go test -v

## -run对应一个正则表达式，只有测试函数名被它正确匹配的测试函数才会被go test测试命令运行
go test -v -run="TestFail"

## 单元测试覆盖率，使用coverprofile
go tool cover  -html=c.out

## 基准测试
# -benchmem命令行标志参数将在报告中包含内存的分配数据统计
go test -bench=. -benchmem
```

性能观察：使用goland观察本地代码性能，可以使用Profiler功能，目前为单独分离的三个功能

![img.png](img/golang/img.png)

profiler包括火焰图、函数调用链、过程涉及的方法列表

![img.png](img/golang/img_1.png)

工具实现:本质是调用了golang提供的工具
```shell
$ go test -cpuprofile=cpu.out
$ go test -memprofile=mem.out
$ go test -blockprofile=block.out
```
