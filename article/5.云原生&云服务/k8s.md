---
sort: 1
---
# k8s

## 1.介绍
K8s是由Google发起的CNCF出品的容器编排工具

服务治理：service
mesh概念目前非常新，还在发展中，主要的代表作为istio，linkerd等

Kubernetes面试题超详细总结：[https://mp.weixin.qq.com/s/1qsLwI_f3KUljx2mi7osAw](https://mp.weixin.qq.com/s/1qsLwI_f3KUljx2mi7osAw)

Docker 不香吗，为啥还要
K8s？：[https://mp.weixin.qq.com/s/YGLKTkl7D2baM_VsZiZFww](https://mp.weixin.qq.com/s/YGLKTkl7D2baM_VsZiZFww)

带你快速了解 Docker 和
Kubernetes：[https://mp.weixin.qq.com/s/KLuMQj4y1gaHLCsdTbToDA](https://mp.weixin.qq.com/s/KLuMQj4y1gaHLCsdTbToDA)

K8s从1.24开始移除了docker。

> 原因是k8s操作pod，制定了一套CRI标准，而docker并没有实现这套标准且不打算实现。
>
> 由于docker出现的早，市场占比大，所有k8s初期为了兼容docker，增加了一层接口的转换。
>
> 而现在，k8s的市场已经很大，且已经有很多和docker一样优秀的容器化工具，比如containerd、CRI-O、podman等。

如今使用k8s正式推荐使用Google自研的podman。

> Podman的定位是从用户使用上完全兼容docker（操作命令与docker一样）
>
> Docker的市场已经是昨日黄花。


## 2.Harbor

官网：[https://goharbor.io/](https://goharbor.io/)



安装教程： https://www.cnblogs.com/pangguoping/p/7650014.html

教程：https://blog.csdn.net/robin_cai/article/details/124292678

### 2.1.介绍

1. Harbor介绍

Harbor是一个用于存储和分发Docker镜像的企业级Registry服务器，通过添加一些企业必需的功能特性，例如安全、标识和管理等，扩展了开源Docker Distribution。作为一个企业级私有Registry服务器，Harbor提供了更好的性能和安全。提升用户使用Registry构建和运行环境传输镜像的效率。Harbor支持安装在多个Registry节点的镜像资源复制，镜像全部保存在私有Registry中， 确保数据和知识产权在公司内部网络中管控。另外，Harbor也提供了高级的安全特性，诸如用户管理，访问控制和活动审计等。

2. Harbor特性

基于角色的访问控制 ：用户与Docker镜像仓库通过“项目”进行组织管理，一个用户可以对多个镜像仓库在同一命名空间（project）里有不同的权限。

镜像复制 ： 镜像可以在多个Registry实例中复制（同步）。尤其适合于负载均衡，高可用，混合云和多云的场景。

图形化用户界面 ： 用户可以通过浏览器来浏览，检索当前Docker镜像仓库，管理项目和命名空间。

AD/LDAP 支持 ： Harbor可以集成企业内部已有的AD/LDAP，用于鉴权认证管理。

审计管理 ： 所有针对镜像仓库的操作都可以被记录追溯，用于审计管理。

国际化 ： 已拥有英文、中文、德文、日文和俄文的本地化版本。更多的语言将会添加进来。

RESTful API ： RESTful API 提供给管理员对于Harbor更多的操控, 使得与其它管理软件集成变得更容易。

部署简单 ： 提供在线和离线两种安装工具， 也可以安装到vSphere平台(OVA方式)虚拟设备。

### 2.2.安装

下载安装包，比如1.10.14 是目前稳定的版本。

- 停止harbor: docker-compose stop
- 启动harbor: docker-compose up -d

配置：https://www.tracymc.cn/archives/1371


基本操作

```shell

# 1.登录
docker login -u admin -p Harbor12345 192.168.3.101:9010

# 2.构建镜像 /usr/local/data 目录下有dockerfile，可以自动化进行构建镜像
docker build -t public/my_project:1.0 /usr/local/data

# 3.对本地镜像创建tag
docker tag 1319b1eaa0b7 192.168.3.101:9010/public/my_project:1.0

# 4.推送仓库
docker push 192.168.3.101:9010/public/my_project:1.0

# 5.移除已经运行的容器
docker rm -f my_project

# 6.运行新容器
docker run -d -p 8080:8080 --name=my_project public/my_project:1.0
```
