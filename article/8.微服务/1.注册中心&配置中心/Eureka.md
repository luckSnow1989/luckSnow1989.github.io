---
sort: 1
---
# Eureka

- [eureka性能测试](img/eureka/eureka性能测试.docx)
- [深入理解Eureka实现原理](https://jbone.cn/learn/spring-cloud/deep-eureka.html)
- [Eureka优化技巧](https://blog.csdn.net/weixin_45380450/article/details/119962762)

## 1.介绍

### 1.1.介绍
Eureka 是Netflix开发的服务发现组件，使用REST提供服务。Spring Cloud将它集成在其子项目 spring-cloud-netflix 中， 以实现 Spring Cloud 的服务注册于发现， 同时还提供了负载均衡、 故障转移等能力。

服务拓扑图如下：
![](img/eureka/4b228b81.png)

涉及到3中角色：
- Eureka Server:通过 Register、 Get、 Renew 等接口提供服务的注册和发现。
- Application Service (Service Provider)：服务提供方，把自身的服务实例注册到 Eureka Server 中
- Application Client (Service Consumer)：服务调用方，通过 Eureka Server 获取服务列表， 消费服务

角色之间的工作：
- Register(服务注册)： 把自己的 IP 和端口注册给 Eureka。
- Renew(服务续约)： 客户端主动发送心跳包， 每 30 秒发送一次，告诉 Eureka 自己还活着。
- Cancel(服务下线)： 当客户端关闭时会向 Eureka 发送消息， 把自己从服务列表中删除。 防止 consumer 调用到已下线的服务发生异常。
- Get Registry(获取服务注册列表)： 获取其他服务列表。因为Eureka注册表没有隔离性，所以每个客户端会拉取全部的注册表。
- Replicate(集群中数据同步)： eureka 集群中的数据复制与同步。
- Make Remote Call(远程调用)： 完成服务的远程调用。

### 1.2.特点
- 可用性（AP原则）：Eureka 在设计时就紧遵AP原则，Eureka的集群中，只要有一台Eureka还在，就能保证注册服务可用，只不过查到的信息可能不是最新的（不保证强一致性）。
- 去中心化架构：Eureka Server 可以运行多个实例来构建集群，不同于 ZooKeeper的选举 leader 的过程，Eureka Server 采用的是Peer to Peer 对等通信。这是一种去中心化的架构，无 master/slave 之分，每一个 Peer 都是对等的。节点通过彼此互相注册来提高可用性，每个节点需要添加一个或多个有效的 serviceUrl 指向其他节点。每个节点都可被视为其他节点的副本。
- 请求自动切换：在集群环境中如果某台Eureka Server宕机，Eureka Client 的请求会自动切换到新的Eureka Server节点上，当宕机的服务器重新恢复后，Eureka会再次将其纳入到服务器集群管理之中。
- 节点间操作复制：当节点开始接受客户端请求时，所有的操作都会在节点间进行复制操作，将请求复制到该 Eureka Server 当前所知的其它所有节点中。
- 自动注册&心跳：当一个新的 Eureka Server 节点启动后，会首先尝试从邻近节点获取所有注册列表信息，并完成初始化。Eureka Server 通过 getEurekaServiceUrls() 方法获取所有的节点，并且会通过心跳契约的方式定期更新。
- 自动下线：默认情况下，如果 Eureka Server 在一定时间内没有接收到某个服务实例的心跳（默认周期为30秒），Eureka Server 将会注销该实例（默认为90秒， eureka.instance.lease-expiration-duration-in-seconds 进行自定义配置）。
- 保护模式：当 Eureka Server 节点在短时间内丢失过多的心跳时，那么这个节点就会进入自我保护模式。如果在15分钟内超过 85% 的节点都没有正常的心跳，那么Eureka就认为客户端与注册中心出现了网络故障，此时会出现以下几种情况：
    - Eureka不再从注册表中移除因为长时间没有收到心跳而过期的服务；
    - Eureka仍然能够接受新服务注册和查询请求，但是不会被同步到其它节点上（即保证当前节点依然可用）
    - 当网络稳定时，当前实例新注册的信息会被同步到其它节点中。
 
Eureka放弃一致性，保证了服务的高可用。通常认为注册服务更重要的是可用性，可以接受短期内达不到一致性的状况。
所以如果某个Eureka服务出现问题，客户端在向这个Eureka注册发现连接失败，则会自动切换至其它节点，只要有一台Eureka还在，就能保证注册服务可用。 

### 1.3.工作流程

了解完 Eureka 核心概念，自我保护机制，以及集群内的工作原理后，我们来整体梳理一下Eureka的工作流程：

- Eureka Server 启动成功，等待服务端注册。在启动过程中如果配置了集群，集群之间定时通过 Replicate 同步注册表，每个Eureka Server都存在独立完整的服务注册表信息。
- Eureka Client 启动时根据配置的 Eureka Server 地址去注册中心注册服务。
- Eureka Client 会每 30s 向Eureka Server发送一次心跳请求，证明客户端服务正常。
- 当 Eureka Server 90s 内没有收到 Eureka Client 的心跳，注册中心则认为该节点失效，会注销该实例。
- 单位时间内 Eureka Server 统计到有大量的Eureka Client没有上送心跳，则认为可能为网络异常，进入自我保护机制，不再剔除没有上送心跳的客户端。
- 当 Eureka Client 心跳请求恢复正常之后，Eureka Server 自动退出自我保护模式。
- Eureka Client 定时全量或者增量从注册中心获取服务注册表，并且将获取到的信息缓存到本地。
- 服务调用时，Eureka Client 会先从本地缓存找寻调取的服务。如果获取不到，先从注册中心刷新注册表，再同步到本地缓存。
- Eureka Client 获取到目标服务器信息，发起服务调用。
- Eureka Client 程序关闭时向 Eureka Server 发送取消请求，Eureka Server 将实例从注册表中删除。

Eureka 为了保障注册中心的高可用性，容忍了数据的非强一致性，服务节点间的数据可能不一致，Client-Server 间的数据可能不一致。比较适合跨越多机房、对注册中心服务可用性要求较高的使用场景。

简单来说，eureka为了保证高可用，只能实现数据的最终一致性（弱一致性，短时间内会出现数据不一致的问题）

### 1.4.注意事项

- 集群监控：使用spring boot的监控 actator
- 优雅停服：因为kill -9服务，注册表会被动监测删除，导致调用方无法感知服务下线。所以客户端需要使用优雅停服，帮助应用正常被下线。可以使用 actator 的shutdown接口
- 密码认证：使用spring-boot-starter-security
- 注册表隔离。需要二次开发，推进规范化命令，比如：系统名称-模块名称-运行环境。参数之间以中划线隔离，例如：myProject-myModel-dev
- 租户：因为eureka天然的对应用的隔离性支持的不好，没有租户的概念。我们基于 spring-boot-starter-security 扩展用户认证。实现简单的多租户
    [使用Spring Security实现单点登录](https://blog.csdn.net/m0_64714024/article/details/125549592)

### 1.5.内部枚举

```text
1. 实例状态。枚举：InstanceStatus
    UP              示例已注册成功
    DOWN            示例已下线
    STARTING        示例开始注册（中间状态）
    OUT_OF_SERVICE  不提供服务
    UNKNOWN         未知状态
2 实例操作类型。参考：PeerAwareInstanceRegistryImp.Action
    Heartbeat               心跳检查
    Register                注册
    Cancel                  取消
    StatusUpdate            状态变更
    DeleteStatusOverride    删除
3.任务处理结果。参考：TaskProcessor.ProcessingResult
    Success             成功，服务端返回200～300，不包含300
    Congestion          拥堵，比如服务繁忙503、超时异常
    TransientError      处理异常，可重试。主要通过判断是否IOException
    PermanentError      处理异常
```

## 2.最佳实践

### 2.1.Eureka自我保护

#### 2.1.1.自我保护条件
- 自我保护的条件： 一般情况下， 微服务在Eureka上注册后， 会每30秒发送心跳包，Eureka通过心跳来判断服务是否健康， 同时会定期删除超过90秒没有发送心跳服务。
- 触发阀值：Eureka Server 在运行期间，会统计心跳失败的比例在 15 分钟内是否低于 85%这种算法叫做 Eureka Server 的自我保护模式

Eureka Server收不到微服务的心跳：
- 微服务自身的原因
- 大规模服务上下线。  
- 网络故障，通常(微服务的自身的故障关闭)只会导致个别服务出现故障， 一般不会出现大面积故障， 而(网络故障)通常会导致Eureka Server在短时间内无法收到大批心跳。

考虑到这个区别，Eureka设置了一个阀值， 当判断挂掉的服务的数量超过阀值时，Eureka Server 认为很大程度上出现了网络故障， 将不再删除心跳过期的服务。

#### 2.1.2.为什么需要自我保护
- 因为同时保留好数据与坏数据总比丢掉任何数据要更好， 当网络故障恢复后，这个 Eureka节点会退出自我保护模式。
- Eureka还有客户端缓存功能(也就是微服务的缓存功能)。 即便 Eureka 集群中所有节点都宕机失效， 微服务的 Provider 和 Consumer都能正常通信。
- 微服务的负载均衡策略会自动剔除死亡的微服务节点

#### 2.1.3.关闭自我保护

```properties
#关闭自我保护:true 为开启自我保护， false 为关闭自我保护
eureka.server.enableSelfPreservation=false

## 自我保护触发的阈值，可以适当修改      
eureka.server.renewal-percent-threshold: 0.85

#清理间隔(从服务列表删除无用服务的时间间隔，单位:毫秒， 默认是 60*1000)
eureka.server.eviction.interval-timer-in-ms=60000
```

#### 2.1.4.开启建议

注册应用数量非常小，不建议开启。例如注册服务本身就3个，服务重启就会造车进入包含模式。

### 2.2.优雅停服

客户端使用 actuator
```text
1.maven坐标
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>

2.配置信息
###### 优雅停服######
##启用 shutdown
management.endpoint.shutdown.enabled=true
# 暴露所有端点
management.endpoints.web.exposure.include=*
#禁用密码验证
management.endpoints.shutdown.sensitive=false

3.post调用：http://127.0.0.1:9080/actuator/shutdown
```

### 2.3.密码认证

[密码认证](https://developer.aliyun.com/article/971982)

```text
1.maven坐标
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-security</artifactId>
</dependency>

2.Eureka Server配置
#开启 http basic 的安全认证 没有用 需要通过下面方法来关闭或开启
#spring.security.basic.enabled=true
spring.security.user.name=user
spring.security.user.password=123456
 # 修改访问集群节点的 url
eureka.client.serviceUrl.defaultZone=http://user:123456@eureka2:8761/eureka/

3.客户端配置
spring.application.name=eureka-provider
server.port=9090
#设置服务注册中心地址， 指向另一个注册中心
eureka.client.serviceUrl.defaultZone=http://user:123456@eureka1:8761/eureka/,http://user:123456@eureka2:8761/eureka/
#启用 shutdown
management.endpoints.shutdown.enabled=true
#禁用密码验证
management.endpoints.shutdown.sensitive=false

4.关闭csrf认证
Spring Cloud 2.0 以上的security默认启用了csrf检验，要在eurekaServer端配置security的csrf检验为false

@EnableWebSecurity
@Configuration
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable(); //关闭csrf
        //开启认证  若注释掉，就关闭认证了
        http.authorizeRequests().anyRequest().authenticated().and().httpBasic(); 
    }
}


```

### 2.4.健康监测

[数据库异常导致eureka注销问题排查](https://segmentfault.com/a/1190000023766801)

Eureka-client定时通过所有的HealthIndicator的health方法获取对应的健康检查状态，如果有HealthIndicator检测结果为DOWN，
那Eureka-client就会判定当前服务有问题，是不可用的，就会将自身状态设置为DOWN，并上报给Eureka-server。
Eureka-server收到信息之后将该节点状态标识为DOWN，这样其他服务就无法从Eureka-server获取到该节点。

### 2.5.实例ID

```properties
# 推荐使用ip:port。默认规则 机器hostname:应用名称:端口
eureka.instance.instance-id = ${spring.cloud.client.ip-address}:${server.port}
```

### 2.6.性能优化

eureka是去中心化的，对等星型同步架构，ap模型。所以对于每次变更(注册/心跳续约/状态变更等)都会生成相应的同步任务来用于所有实例数据的同步，
这样一来同步作业量随着集群规模、实例数正相关同步上涨。 如果集群里注册的服务实例数过万，可能出现CPU占用率、负载都很高，时不时还会发生 Full GC 导致业务抖动。

再加上eureka的二级队列发布模型，很容易造成同步队列任务积压，加剧服务发现的延迟，如果再遇到网络抖动，导致客户端切换eureka节点，就会引发同步任务的重试风暴，性能直接爆炸。

eureka官方提到：Eureka 的这种广播复制模型，不仅会导致它自身的架构脆弱性，也影响了集群整体的横向扩展性。

## 3.高可用方案

常用的高可用方案有两个
1. 同一个机房内部，启动多个eureka实例，实例之间相互注册，实现集群搭建。 
2. 用户量比较大或者用户地理位置分布范围很广的项目，一般都会有多个机房。我们希望一个机房内的服务优先调用同一个机房内的服务，当同一个机房的服务不可用的时候，再去调用其它机房的服务，以达到减少延时的作用。

> PS: 集群使用域名或者ip对外提供服务。配置的方式稍有不同。
> 本地模拟搭建集群，必须使用域名。否则集群不可用。

### 3.1.方案1

eureka服务配置相同的地址，启动后就可以相互注册。
```properties
eureka.client.fetch-registry=true
eureka.client.register-with-eureka=true
eureka.client.service-url.defaultZone=http://10.10.10.1:9001/eureka/,http://10.10.10.2:9001/eureka/,http://10.10.10.2:9001/eureka/
```

### 3.2.方案2

eureka提供了region和zone两个概念来进行分区，这两个概念均来自于亚马逊的AWS：
- region：可以简单理解为地理上的分区，比如亚洲地区，或者华北地区，再或者北京等等，没有具体大小的限制。根据项目具体的情况，可以自行合理划分region。
- zone：可以简单理解为region内的具体机房，比如说region划分为北京，然后北京有两个机房，就可以在此region之下划分出zone1,zone2两个zone。

[eureka的region和zone的使用](https://www.freesion.com/article/3518113081/)

![](img/eureka/ca510eba.png)

> PS：在公有云的维度，一般情况下，region之间网络是不通，同一个region下的zone之间网络互通。
> 当然互通的前提是必须使用同一个VPC。【公有云的网络是VPC进行隔离的】


eureka服务配置如下。在3个zone中分别部署集群。集群之间也会定时相互同步注册信息，当zone的集群出现问题后，可以直接进行切换。
```properties
# 获取实例所在的地区。默认为us-east-1
eureka.client.region=beijing
#实例是否使用同一zone里的eureka服务器，默认为true，理想状态下，eureka客户端与服务端是在同一zone下
eureka.client.prefer-same-zone-eureka=true
# 获取实例所在的地区下可用性的区域列表，用逗号隔开。（根据AWS云实际情况设计的高可用方案）
eureka.client.availability-zones.beijing=zone-1,zone-2,zone-3

eureka.client.fetch-registry=true
eureka.client.register-with-eureka=true
# 集群1，2，3
eureka.client.service-url.zone-1=http://ip1/eureka/,http://ip2/eureka/,http://ip3/eureka/
eureka.client.service-url.zone-2=http://ip4/eureka/,http://ip5/eureka/,http://ip6/eureka/
eureka.client.service-url.zone-3=http://ip7/eureka/,http://ip8/eureka/,http://ip9/eureka/
```

erueka客户端的配置如下
```properties
# 获取实例所在的地区。默认为us-east-1
eureka.client.region=beijing
#实例是否使用同一zone里的eureka服务器，默认为true，理想状态下，eureka客户端与服务端是在同一zone下
eureka.client.prefer-same-zone-eureka=true
# 获取实例所在的地区下可用性的区域列表，用逗号隔开。（根据AWS云实际情况设计的高可用方案）
eureka.client.availability-zones.beijing=zone-2,zone-1,zone-3

eureka.client.fetch-registry=true
eureka.client.register-with-eureka=true
# 集群1，2，3
eureka.client.service-url.zone-1=http://ip1/eureka/,http://ip2/eureka/,http://ip3/eureka/
eureka.client.service-url.zone-2=http://ip4/eureka/,http://ip5/eureka/,http://ip6/eureka/
eureka.client.service-url.zone-3=http://ip7/eureka/,http://ip8/eureka/,http://ip9/eureka/

########### 这个配置最重要，表示自己当前属于哪个zone                         #############
########### 同时修改availability-zones中的zone顺序，将zone-2调整到第一的位置 #############

# 服务消费者和服务提供者分别属于哪个zone，均是通过eureka.instance.metadata-map.zone来判定的。
# 服务消费者会先通过ribbon去注册中心拉取一份服务提供者的列表，然后通过eureka.instance.metadata-map.zone指定的zone进行过滤，过滤之后如果同一个zone内的服务提供者有多个实例，则会轮流调用。
# 只有在同一个zone内的所有服务提供者都不可用时，才会调用其它zone内的服务提供者
eureka.instance.metadata-map.zone=zone-2
```

## 4.原理分析

### 4.1.请求负载及故障转移

[如何实现客户端请求负载及故障转移](https://mp.weixin.qq.com/s/LUx6nZASaRQMU8k3ufJtYQ)

总结：eureka是ap的集群。加入集群有3个节点。eureka采用的是客户端负载均衡。项目启动时，会打乱client的3个节点顺序。依次进行连接，实现节点负载均衡。当出现节点异常时，也是异常访问重试，实现故障的转移。

### 4.2.缓存机制

Eureka服务发现的速度其实是比较慢的，这也是ap模型的通病。所有我们可以进行优化。

- [Eureka的缓存机制/三级缓存](https://blog.csdn.net/Saintmm/article/details/122335819)
- [eureka延迟优化](https://www.cnblogs.com/ilovejaney/p/16356672.html)

### 4.3.同步机制

[Eureka服务端集群数据同步原理](https://blog.csdn.net/guyue35/article/details/122442587)

集群节点之间数据一致性是通过节点之间数据同步来实现的，数据同步采用的是Acceptor - Worker 模式的消息广播机制来完成的，整个过程大致就是：
1. 某个节点收到客户端的消息（注册、心跳、下线、状态变更等）后，刷新本地注册信息（这里调用已经返回成功，下面步骤采用异步的方式进行）；
2. 遍历所有的节点（会排除自己），将消息转发到其他节点；

<p style="color: red">数据同步方式？</p>
分为全量同步与增量同步。全量同步为客户端第一次启动时进行的，增量同步为运行过程中进行的。
PS：服务同步机制是用来同步Eureka Server节点之间服务信息的

同步的方式，都是先从缓存中读取（二级缓存，一级一级的读取），如果缓存中不存在，则从注册表中加载缓存，再从缓存中读取。（注册表只有数据结构，缓存中保存ready的服务信息）

![](img/eureka/b507ecd3.png)

过程：
1. 先从一级缓存中获取
    - 先判断是否开启了一级缓存
    - 如果开启了则从一级缓存中获取，如果存在则返回，如果没有，则从二级缓存中获取
    - 如果未开启，则跳过一级缓存，从二级缓存中获取
2. 再从二级缓存中获取
    - 如果二级缓存中存在，则直接返回；
    - 如果二级缓存中不存在，则先将数据加载到二级缓存中，再从二级缓存中获取。 
3. 注意加载时需要判断是增量同步还是全量同步，
   - 增量同步从recentlyChangedQueue中load
   - 全量同步从registry中load。


<p style="color: red">如何避免死循环？</p>
假如：客户端对服务端A进行了下线操作，服务端A将操作同步到B、C、D其他3个服务端，当服务端B接收到同步过来的下线请求后，
会不会再将该操作又同步到其他的服务端，从而使同步陷入死循环呢？

答案是不会，Eureka会区分正常的客户端请求与服务端发起的数据同步请求，对于任何服务端发起的数据同步请求，Eureka不会再进行其他同步操作，从而避免数据同步出现死循环。

具体的做法是Eureka在http请求头中加入特殊的标识，用来区分正常的客户端请求与数据同步请求。


<p style="color: red">如何解决数据冲突？</p>

1. 使用版本号解决数据冲突。一般我们给数据加一个版本号就行，如时间戳，只要有任何数据更新操作，就更新时间戳，最后更新数据的时间戳最大，
    也就是最新的数据，上面讲Eureka中注册表中时间信息就是做此用途的。
2. 客户端主动通过拉取服务端注册表数据，如果发现与本地数据存在冲突，则让有冲突的客户端从新执行注册操作


## REST API列表

| 操作                      | API                                                                | 描述                                     |
| --------------------------- | -------------------------------------------------------------------- | ------------------------------------------ |
| 注册新的已用实例          | POST /eureka/apps/{appId}                                          | 输入json或xml格式的body，成功返回204     |
| 注销应用实例              | DELETE /eureka/apps/{appId}/{instanceId}                           | 成功返回200                              |
| 应用实例发送心跳          | PUT /eureka/apps/{appId}/{instanceId}                              | 成功返回200，如果instanceId不存在返回404 |
| 查询所有实例              | GET /eureka/apps/                                                  | 成功返回200，输出json或xml格式。         |
| 查询指定appId实例         | GET /eureka/apps/{appId}                                           | 成功返回200，输出json或xml格式。         |
| 查询指定appId和instanceId | GET /eureka/apps/{appId}/{instanceId}                             | 成功返回200，输出json或xml格式。         |
| 查询指定instanceId        | GET /eureka/instances/{instanceId}                                 | 成功返回200，输出json或xml格式。         |
| 暂停应用实例              | PUT /eureka/apps/{appId}/{instanceId}/status?value=OUT_OF_SERVICE | 成功返回200，失败返回500。               |
| 恢复应用实例              | DELETE /eureka/apps/{appId}/{instanceId}/status?value=UP          | 成功返回200，失败返回500                 |
| 更新元数据                | PUT /eureka/apps/{appId}/{instanceId}/metadata?key=value          | 成功返回200，失败返回500                 |
| 根据vip地址查询           | GET /eureka/vips/{appId}/{vipAddress}                             | 成功返回200，输出json或xml格式。         |
| 根据svip地址查询          | GET /eureka/svips/{appId}/{svipAddress}                           | 成功返回200，输出json或xml格式。         |

注册实例请求案例 
- PS：设置请求参数的类型为JSON。否则默认接受XML格式的请求。Accept:application/json
- PS：如果server开启了security，就要设置请求头：Authorization:Basic cm9vdDpzRkFJZDcyaw== 。后面的内容就是 base64(账号:密码)

```shell
curl --location --request POST 'http://127.0.0.1:9001/eureka/apps/OPENFEIGN-PROVIDER' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "instance": {
        "instanceId": "zhangxue07-phq-PC:TEST-8007:8007",
        "hostName": "127.0.0.1",
        "app": "TEST-8007",
        "ipAddr": "127.0.0.1",
        "status": "UP",
        "overriddenStatus": "UNKNOWN",
        "port": {
            "$": 8007,
            "@enabled": "true"
        },
        "securePort": {
            "$": 443,
            "@enabled": "false"
        },
        "countryId": 1,
        "dataCenterInfo": {
            "@class": "com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo",
            "name": "MyOwn"
        },
        "leaseInfo": {
            "renewalIntervalInSecs": 30,
            "durationInSecs": 90,
            "registrationTimestamp": 1672748297041,
            "lastRenewalTimestamp": 1672748297041,
            "evictionTimestamp": 0,
            "serviceUpTimestamp": 1672748297041
        },
        "metadata": {
            "management.port": "8007"
        },
        "homePageUrl": "http://127.0.0.1:8007/",
        "statusPageUrl": "http://127.0.0.1:8007/actuator/info",
        "healthCheckUrl": "http://127.0.0.1:8007/actuator/health",
        "vipAddress": "TEST-8007",
        "secureVipAddress": "TEST-8007",
        "isCoordinatingDiscoveryServer": "false",
        "lastUpdatedTimestamp": "1672748297041",
        "lastDirtyTimestamp": "1672748296432",
        "actionType": "ADDED"
    }
}'
```