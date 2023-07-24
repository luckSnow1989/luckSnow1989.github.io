---
sort: 1
---
# k8s

## 1.介绍
K8s是由Google发起的CNCF出品的容器编排工具。

服务治理：service mesh概念目前非常新，还在发展中，主要的代表作为istio，linkerd等

- Kubernetes面试题超详细总结：[https://mp.weixin.qq.com/s/1qsLwI_f3KUljx2mi7osAw](https://mp.weixin.qq.com/s/1qsLwI_f3KUljx2mi7osAw)
- Docker 不香吗，为啥还要 K8s？：[https://mp.weixin.qq.com/s/YGLKTkl7D2baM_VsZiZFww](https://mp.weixin.qq.com/s/YGLKTkl7D2baM_VsZiZFww)
- 带你快速了解 Docker 和 Kubernetes：[https://mp.weixin.qq.com/s/KLuMQj4y1gaHLCsdTbToDA](https://mp.weixin.qq.com/s/KLuMQj4y1gaHLCsdTbToDA)

K8s从1.24开始移除了docker。

> 原因是k8s操作pod，制定了一套CRI标准，而docker并没有实现这套标准且不打算实现。
> 由于docker出现的早，市场占比大，所有k8s初期为了兼容docker，增加了一层接口的转换。
> 而现在，k8s的市场已经很大，且已经有很多和docker一样优秀的容器化工具，比如containerd、CRI-O、podman等。

如今使用k8s正式推荐使用Google自研的podman。

> Podman的定位是从用户使用上完全兼容docker（操作命令与docker一样）
> Docker的市场已经是昨日黄花。

## 2.Harbor

- 官网：[https://goharbor.io/](https://goharbor.io/)
- 安装教程： https://www.cnblogs.com/pangguoping/p/7650014.html
- 教程：https://blog.csdn.net/robin_cai/article/details/124292678

### 2.1.介绍

1. Harbor介绍

Harbor是一个用于存储和分发Docker镜像的企业级Registry服务器，通过添加一些企业必需的功能特性，例如安全、标识和管理等，扩展了开源Docker Distribution。
作为一个企业级私有Registry服务器，Harbor提供了更好的性能和安全。提升用户使用Registry构建和运行环境传输镜像的效率。
Harbor支持安装在多个Registry节点的镜像资源复制，镜像全部保存在私有Registry中， 确保数据和知识产权在公司内部网络中管控。
另外，Harbor也提供了高级的安全特性，诸如用户管理，访问控制和活动审计等。

2. Harbor特性

- 基于角色的访问控制 ：用户与Docker镜像仓库通过“项目”进行组织管理，一个用户可以对多个镜像仓库在同一命名空间（project）里有不同的权限。
- 镜像复制 ： 镜像可以在多个Registry实例中复制（同步）。尤其适合于负载均衡，高可用，混合云和多云的场景。
- 图形化用户界面 ： 用户可以通过浏览器来浏览，检索当前Docker镜像仓库，管理项目和命名空间。
- AD/LDAP 支持 ： Harbor可以集成企业内部已有的AD/LDAP，用于鉴权认证管理。
- 审计管理 ： 所有针对镜像仓库的操作都可以被记录追溯，用于审计管理。
- 国际化 ： 已拥有英文、中文、德文、日文和俄文的本地化版本。更多的语言将会添加进来。
- RESTful API ： RESTful API 提供给管理员对于Harbor更多的操控, 使得与其它管理软件集成变得更容易。
- 部署简单 ： 提供在线和离线两种安装工具， 也可以安装到vSphere平台(OVA方式)虚拟设备。

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

## 3.管理系统

Kubernetes 提供了基础的命令行功能，一些复杂的操作还是比较麻烦的，所以需要使用更高级别的管理工具。

Kubernetes 已然是当下容器编排领域事实上的标准，各大云服务商都急于推出 Kubernetes 服务，互联网公司也纷纷跟进，将自己的应用容器化，并使用 Kubernetes 编排。
在 Kubernetes 图形化工具方面，我们已经获得了极大的可选择空间：

- 各云服务商自己推出的 Kubernetes 服务所搭载的管理控制台，例如 
  - 阿里云的 Kubernetes 服务
  - 青云推出的 KubeSphere
  - 其他云服务商的 CaaS 类服务
- Kubernetes 官方的图形管理界面 Kubernetes Dashboard
- 面向企业私有化部署的 Rancher
- 行业新星 KuberSphere


### 3.1.KuberSphere

- 官网[https://www.kubesphere.io/zh/](https://www.kubesphere.io/zh/)
- [KubeSphere简介](https://blog.csdn.net/weixin_43628257/article/details/123045417)

KubeSphere 作为企业级的全栈化容器平台，为用户提供了一个具备极致体验的 Web 控制台，让您能够像使用任何其他互联网产品一样，快速上手各项功能与服务。
目前提供了工作负载管理、微服务治理、DevOps 工程、Source to Image、多租户管理、多维度监控、日志查询与收集、告警通知、服务与网络、应用管理、基础设施管理、镜像管理、应用配置密钥管理等功能模块，
开发了适用于适用于物理机部署 Kubernetes 的 负载均衡器插件 Porter，并支持对接多种开源的存储与网络方案，支持高性能的商业存储与网络服务。

### 3.2.kuboard

- 官网[https://www.kuboard.cn/](https://www.kuboard.cn/)
- 使用文档[https://kuboard.cn/install/v3/install.html](https://kuboard.cn/install/v3/install.html)
- [k3s部署全过程kuboard管理界面](https://blog.csdn.net/xiaohucxy/article/details/127062757)

Kubernetes 官方提供的图形界面，是一款免费的Kubernetes图形化管理工具，它力图帮助用户快速在Kubernetes上落地微服务。使用Kuboard，用户无需编写YAML文件，就可以完成应用程序的部署和管理。
Kuboard可以使用内建用户库、gitlab/github单点登录或者LDAP用户库进行认证，避免管理员将 ServiceAccount的Token分发给普通用户而造成的麻烦。
使用内建用户库时，管理员可以配置用户的密码策略、密码过期时间等安全设置。

### 3.3.rancher

- 官网[https://www.rancher.cn](https://www.rancher.cn)
- [使用教程](https://code2life.top/2018/10/16/0031-rancher-trial/)

Rancher 是一个开源的企业级全栈容器部署及管理平台。Rancher 为容器提供了一揽子基础架构服务,CNI 兼容的网络服务,存储服务,主机管理,负载均衡,防护墙。
Rancher让上述服务跨越有云,私有云,虚拟机,物理环境运行,真正实现一键式应用部署和管理。