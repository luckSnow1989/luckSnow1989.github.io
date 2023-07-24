# golang

## 1.教程
- 官网[https://golang.org/dl/](https://golang.org/dl/)
- Go官方镜像站[https://golang.google.cn/dl/](https://golang.google.cn/dl/)

- [中文网](https://tour.go-zh.org/list)
- [中文网-学习指南]( https://tour.go-zh.org/welcome/1)
  
- [【强烈推荐】Go语言圣经（中文版）](https://books.studygolang.com/gopl-zh/)
- [学习参考博客](https://www.liwenzhou.com/posts/Go/golang-menu/)
- [Go 语言设计与实现](https://draveness.me/golang/)
  
- [简单教程](https://www.runoob.com/go/go-tutorial.html)

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

## 2.介绍

1.Go 是一个开源的编程语言，它能让构造简单、可靠且高效的软件变得容易。

2.Go 语言特色
- 简洁、快速、安全
- 并行、有趣、开源
- 内存管理、数组安全、编译迅速

3.Go 语言用途
   
Go语言被设计成一门应用于搭载 Web 服务器，存储集群或类似用途的巨型中央服务器的系统编程语言。

对于高性能分布式系统领域而言，Go语言无疑比大多数其它语言有着更高的开发效率。

它提供了海量并行的支持，这对于游戏服务端的开发而言是再好不过了。

4.安装与下载
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

## 修改GOPROXY
Go1.14版本之后，都推荐使用go mod模式来管理依赖了，也不再强制我们把代码必须写在GOPATH下面的src目录了，你可以在你电脑的任意位置编写go代码

默认GoPROXY配置是：GOPROXY=https://proxy.golang.org,direct，
由于国内访问不到，所以我们需要换一个PROXY，这里推荐使用https://goproxy.io 或 https://goproxy.cn。

命令如下：go env -w GOPROXY=https://goproxy.cn,direct
```

5.开发工具
- LiteIDE： http://www.golangtc.com/download/liteide
- goland：https://www.jetbrains.com/zh-cn/go/



