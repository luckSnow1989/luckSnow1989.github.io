---
sort: 1
---
# k8s

## 1.介绍

### 1.1.基础
K8s是由Google发起的CNCF出品的容器编排工具。

服务治理：service mesh概念目前非常新，还在发展中，主要的代表作为istio，linkerd等

- Kubernetes面试题超详细总结：[https://mp.weixin.qq.com/s/1qsLwI_f3KUljx2mi7osAw](https://mp.weixin.qq.com/s/1qsLwI_f3KUljx2mi7osAw)
- Docker 不香吗，为啥还要 K8s？：[https://mp.weixin.qq.com/s/YGLKTkl7D2baM_VsZiZFww](https://mp.weixin.qq.com/s/YGLKTkl7D2baM_VsZiZFww)
- 带你快速了解 Docker 和 Kubernetes：[https://mp.weixin.qq.com/s/KLuMQj4y1gaHLCsdTbToDA](https://mp.weixin.qq.com/s/KLuMQj4y1gaHLCsdTbToDA)
- [springboot + nacos + k8s 优雅停机](https://mp.weixin.qq.com/s/BtnpuA14epZw8XKeRAZICw)

### 1.2.被放弃的Docker

K8s从1.24开始移除了docker，原因：
1. k8s为了操作pod，制定了一套CRI标准，而docker并没有实现这套标准且不打算实现。（两家公司对标准的竞争，显然docker输了） 
2. 由于docker出现的早，市场占比大，所有k8s初期为了兼容docker，增加了一层接口的转换。导致k8s操作docker的性能较差。 
3. 现在k8s的市场已经很大，且已经有很多和docker一样优秀的容器化工具，比如containerd、CRI-O、podman等。

如今使用k8s正式推荐使用Google自研的podman。
- Podman的定位是从用户使用上完全兼容docker（操作命令与docker一样）
- Docker的市场已经是昨日黄花。

### 1.3.容器类型

pod是k8s运行的最小单元。支撑pod运行的容器可以有多个，主要分为以下几种
1. 初始化容器。在主容器启动前运行，用于执行初始化任务（如配置下载、依赖检查、数据预热等）
2. 临时容器。调试用途
3. 主容器。核心业务逻辑
4. sidecar容器。辅助主容器，负责为主容器提供增强功能，如日志收集、数据同步、服务代理等。

#### 1.3.1.Sidecar

Sidecar是最常用的容器类型。关键特点：
- 同一个 Pod：主容器和 Sidecar 容器运行在同一个 Pod 中，属于同一个生命周期。
- 二者共享 Pod 的资源：共享网络、存储卷等资源，能通过 localhost 直接通信。

以下为sidecar案例，其中
1. app-container。是主容器，运行nginx。nginx的日志生成到 /var/log/nginx目录
2. sidecar-container。是sidecar容器，运行fluentd。fluentd读取nginx的日志并发送到log-server
3. 共享存储卷。定义了一个name是shared-logs的卷，用于存放日志文件，主容器和sidecar容器都挂载了这个目录。

```yml
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-demo
spec:
  containers:
  - name: app-container
    image: nginx:latest
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/nginx
  - name: sidecar-container
    image: fluentd:latest
    args:
    - "--log-file=/var/log/nginx/access.log"
    - "--destination=http://log-server"
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/nginx
  volumes:
  - name: shared-logs
    emptyDir: {}
```

架构图如下：
```text
+--------------------------- Pod ---------------------------+
|                                                           |
|  +----------------+        +--------------------------+   |
|  | App Container  |        | Sidecar Container        |   |
|  | --------------  |       | -----------------------  |   |
|  | - App Logic     |       | - Logging Agent          |   |
|  | - Generates Logs|       | - Sends Logs to Server   |   |
|  +----------------+        +--------------------------+   |
|             ^                           ^                 |
|             | Shared Volume             | Shared Network  |
|             v                           v                 |
|       Logs (/var/log)           Communication (localhost) |
|                                                           |
+-----------------------------------------------------------+
```

### 1.4.存储卷

在 k8s 中，存储是应用的重要组成部分，尤其是对于需要持久化数据的应用，如数据库、文件存储等。

#### 1.4.1.存储资源类型

1. Ephemeral Storage（临时存储）指 k8s 容器生命周期内存储的数据。当容器终止或者被销毁时，临时存储的数据将会丢失。临时存储的例子包括：
   - emptyDir：一个临时的空目录，在容器启动时创建，容器终止时删除。
   - hostPath：挂载主机上的文件或目录，通常用于调试或测试，但不适合持久化数据，因为数据会依赖宿主机。
2. Persistent Storage（持久化存储） 用于存储需要在 Pod 重启或迁移时保持的数据。k8s 提供了以下持久化存储解决方案：
   - Persistent Volume (PV)：集群中的一块存储资源。由管理员预先配置，代表外部存储（如 NFS、GlusterFS、Ceph、云存储等）。
   - Persistent Volume Claim (PVC)：用户向 k8s 请求存储资源的方式。PVC 表示应用所需的存储量，k8s 会将其与 PV 绑定，提供相应的存储。
3. 其他存储类型
   - ConfigMap 和 Secret：这两种 k8s 资源用于存储配置信息或敏感数据，可以被容器挂载为文件或作为环境变量传递。
   - StatefulSet：用于需要持久化存储的有状态应用。StatefulSet 自动管理与存储相关的细节，每个 Pod 都可以有自己的持久化存储。

在 k8s 中，存储和持久化数据是关键的基础设施之一。PV 和 PVC 提供了灵活的存储管理方式，使应用可以依赖于 k8s 提供的持久化存储来保存数据。
- PV：管理员创建的存储资源，可能是云存储、NFS 等。
- PVC：用户的存储需求声明，k8s 会根据 PVC 绑定适当的 PV。
- StorageClass：提供动态存储卷供应的功能，可以根据存储类型（如云存储）配置动态创建 PV。

通过正确使用 PV、PVC 和 StorageClass，k8s 可以为容器化应用提供高效、可靠、持久的存储解决方案。

#### 1.4.2.PV

Persistent Volume (PV) 是集群中管理员预配置的存储资源。PV 可以使用多种存储技术（如 NFS、iSCSI、Ceph、云存储等）来提供持久化存储。
PV 是由管理员创建的，存储资源具有生命周期，可以在多个 Pod 之间共享。

PV 是集群中的资源对象，类似于节点或 pod 的其他资源。管理员通过 YAML 文件定义 PV，并将其与物理存储资源相关联。
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 5Gi          # 指定存储的大小
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce       # 定义 PV 可以被访问的模式（如 ReadWriteOnce、ReadOnlyMany、ReadWriteMany）
  persistentVolumeReclaimPolicy: Retain   #定义回收策略，如 Retain（保留）、Recycle（回收）、Delete（删除）。
  storageClassName: standard  # 存储的类型（例如使用某个存储类）
  hostPath:
    path: /mnt/data           # 使用本地存储作为持久化存储，通常用于开发和测试环境
```

#### 1.4.3.PVC
Persistent Volume Claim (PVC) 是用户对存储资源的请求，它定义了需要的存储大小、访问模式等要求。PVC 会与合适的 PV 绑定，确保应用可以使用到所需的存储。
PVC 是用户创建的，它描述了应用所需的存储资源（如大小和访问模式）。k8s 会根据 PVC 的要求找到适合的 PV，并将它们绑定在一起。

当 PVC 被创建时，k8s 会寻找符合该请求的 PV 并将其绑定。如果有多个 PV 满足条件，k8s 会根据存储类、容量等选择最佳匹配。

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:  
    - ReadWriteOnce # 请求存储的访问模式
  resources:
    requests:
      storage: 5Gi  #请求的存储大小
```

#### 1.4.4.PVC和PV的绑定

1. 动态供应：如果没有预先创建的 PV 可以满足 PVC 的请求，k8s 可以使用 StorageClass 来动态创建 PV。

动态访问方式的优点：
- 灵活性高，无需管理员手动干预，适合大规模、自动化环境。
- 动态供应存储卷，减少人工配置和管理的工作量。

动态访问方式的缺点：
- 需要管理员配置适当的 StorageClass 和存储提供者。
- 可能存在存储资源使用不均衡的风险，需进行资源管理和监控。

动态供应案例:用户创建的 PVC 会自动使用 StorageClass（standard）来动态供应存储。
```yaml
1. 创建 StorageClass（storageclass.yaml）
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2

2. 创建 PVC 并使用 StorageClass（pvc-dynamic.yaml）
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: standard
```

2. 静态供应：如果管理员手动创建了 PV，则 k8s 会根据 PVC 的要求将 PVC 与 PV 进行匹配，并绑定在一起。

静态访问方式的优点：
- 提供明确的存储资源控制，可以手动配置 PV 来匹配特定的存储需求。
- 适用于已有存储设备或对存储资源有特殊要求的场景。

静态访问方式的缺点：
- 不够灵活，管理员需要预先创建 PV，管理工作量较大。
- 难以应对动态需求，特别是在存储需求变化频繁的环境中。

静态访问示例：管理员创建了一个 10Gi 的 PV，Pod 通过 PVC 请求 5Gi 的存储。PVC 会和符合要求的 PV（即 10Gi）绑定
```yaml
1. 创建 PV（pv.yaml）
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: manual
  hostPath:
    path: /mnt/data

2. 创建 PVC（pvc.yaml）
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: manual
```

#### 1.4.5.StorageClass 和动态卷供应

StorageClass 是一种用于动态供应存储卷的方式。管理员可以创建一个或多个 StorageClass，定义不同的存储类型和配置（例如基于不同云平台的存储）。

当 PVC 指定了某个 StorageClass 时，k8s 会使用该 StorageClass 中定义的策略动态创建 PV。

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/aws-ebs    # 存储供应器，指定存储类型（如 AWS EBS、GCE PD、Ceph、NFS 等）。
parameters:
  type: gp2                           # 存储类型，例如 gp2（通用SSD卷）、io1（IOPS优化SSD卷）等。
```

#### 1.4.6.访问模式
PV 和 PVC 都使用 访问模式 (Access Modes) 来控制如何访问存储资源，常见的访问模式有：

- ReadWriteOnce：只能由一个节点以读写方式访问。
- ReadOnlyMany：可以由多个节点以只读方式访问。
- ReadWriteMany：可以由多个节点以读写方式访问。

选择合适的访问模式对应用非常重要，尤其是在有多个副本或多个节点时。

#### 1.4.7.使用场景
- 数据库存储：对于需要持久化数据的应用（如 MySQL、PostgreSQL、Redis 等数据库），可以使用 PV 和 PVC 来提供可靠的存储。
- 文件存储：如果应用需要存储文件，k8s 也可以使用 PV 和 PVC 来提供持久化存储，并使文件在 Pod 重启或迁移时依然可用。
- 共享存储：某些应用可能需要多个 Pod 共享同一个存储卷。在这种情况下，可以使用 PVC 配合 ReadWriteMany 或 ReadOnlyMany 访问模式来实现共享存储。
- 备份和恢复：PV 可以用于存储应用的备份数据，以便在应用或容器发生故障时进行恢复。

#### 1.4.8.管理和生命周期
k8s 中的存储生命周期管理通常分为以下几种情况：

回收策略：
- Retain：当 PVC 被删除时，PV 保留不变，管理员需要手动回收资源。
- Recycle：删除 PVC 后，PV 的数据会被清空并重新可用（此选项已不推荐使用）。
- Delete：当 PVC 被删除时，PV 也会被删除（适用于动态供应的存储）。

持久化数据的迁移：可以通过 PV 和 PVC 配置，确保数据在 Pod 或容器迁移、重启时不会丢失。

#### 1.4.9.ConfigMap

ConfigMap 是 Kubernetes 中管理应用配置的标准方式，适用于以下场景：
1. 外部配置管理：通过 ConfigMap 将应用的配置文件外部化，使得容器在运行时能够灵活地读取和应用配置，而不需要重新构建 Docker 镜像。
2. 环境配置：不同环境（如开发、测试、生产）可能需要不同的配置，ConfigMap 可以根据环境将配置动态地注入到容器中。

命令
```shell
查看集群中的所有 ConfigMap：kubectl get configmap
更新 ConfigMap：kubectl apply -f configmap.yaml
删除 ConfigMap：kubectl delete configmap <configmap-name>
```

设置ConfigMap
```shell
1. 使用yaml定义公共的配置。name=app-config
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: "db.example.com"
  DATABASE_PORT: "3306"
  DATABASE_NAME: "mydb"
  DATABASE_USER: "user"
  DATABASE_PASSWORD: "password"

2. 通过 kubectl 命令行创建 ConfigMap
kubectl create configmap app-config \
  --from-literal=DATABASE_HOST=db.example.com \
  --from-literal=DATABASE_PORT=3306 \
  --from-literal=DATABASE_NAME=mydb \
  --from-literal=DATABASE_USER=user \
  --from-literal=DATABASE_PASSWORD=password

3. 从一个文件或目录创建 ConfigMap：
kubectl create configmap app-config --from-file=./config.json
```

Pod使用ConfigMap
```shell
1. 作为容器的环境变量
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: app-container
    image: my-app-image
    envFrom:        # envFrom 会将 ConfigMap app-config 中的所有键值对传递给容器作为环境变量
    - configMapRef:
        name: app-config

2. 作为容器的命令行参数。
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: app-container
    image: my-app-image
    command: ["./app", "--host", "$(DATABASE_HOST)", "--port", "$(DATABASE_PORT)"]
    env:                    # 自定义环境变量
    - name: DATABASE_HOST
      valueFrom:
        configMapKeyRef:
          name: app-config  # 读取    ConfigMap app-config 中的 DATABASE_HOST
          key: DATABASE_HOST
    - name: DATABASE_PORT
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: DATABASE_PORT # 读取    ConfigMap app-config 中的 DATABASE_PORT

3. 作为卷挂载到容器中。如果ConfigMap是文件则可以作为卷直接挂载到容器中。
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: app-container
    image: my-app-image
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: app-config


```

#### 1.4.10.Secret
Secret 是一种用于存储和管理敏感信息（如密码、OAuth 令牌、SSH 密钥等）的资源对象。
与 ConfigMap 类似，Secret 允许将配置信息外部化，但 Secret 专门用于存储敏感数据，并且通常会经过加密处理以提高安全性。

Secret 通常用于存储：
- 密码
- API 密钥
- 数据库凭证
- SSH 私钥
- TLS/SSL 证书和密钥

注意事项：
1. Secret将数据进行base64 编码并保存到 etcd 中，并不会加密。因此，Kubernetes 提供了 Encryption at Rest 功能，建议启用它以确保 Secret 数据在存储时加密。
2. 控制访问权限。k8s强制使用RBAC管理。

设置Secret
```shell
1. 使用yaml定义
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
data:
  db-username: dXNlcm5hbWU=  # base64 编码后的用户名
  db-password: cGFzc3dvcmQ=  # base64 编码后的密码

2. 命令创建
kubectl create secret generic db-credentials \
  --from-literal=db-username=admin \
  --from-literal=db-password=secretpassword
```

使用Secret
```shell
1. Secret 可以通过环境变量传递给容器
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: app-container
    image: my-app-image
    env:
    - name: DB_USERNAME
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: db-username
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: db-password
2.将 Secret 作为文件挂载到容器中
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: app-container
    image: my-app-image
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secret
  volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials
```

### 1.5.调度与资源管理

Kubernetes 调度和资源管理是其核心功能，负责在集群中高效分配和管理计算资源。通过调度策略、资源限制和优先级控制，Kubernetes 能够确保应用的性能、可靠性和高可用性。

1. Pod调度机制：Kubernetes使用调度器（Scheduler）来决定将Pod部署到哪个节点上运行。调度器会根据一系列的调度策略，包括资源需求、节点负载、亲和性和互斥性等因素，选择最合适的节点进行调度。
2. 资源限制和请求：在定义Pod时，可以通过资源限制（Resource Limits）和资源请求（Resource Requests）来指定容器对CPU和内存等资源的需求。
   资源限制用于限制容器使用的最大资源量，而资源请求则是向调度器申请所需的最小资源量。调度器根据这些需求来选择合适的节点进行调度。
3. 自动伸缩：Kubernetes提供了水平自动伸缩（Horizontal Pod Autoscaling，HPA）的功能，可以根据指标（如CPU使用率）自动调整Pod的副本数量。
   当负载增加时，HPA会自动增加Pod的副本数量，以满足负载需求；当负载减少时，HPA会自动减少Pod的副本数量，以节省资源。
4. 节点管理：Kubernetes通过节点管理器（Node Manager）监控节点上的资源使用情况，包括CPU、内存和存储等。
   当节点资源不足时，节点管理器会发出警告并触发自动扩容或迁移Pod的操作，将Pod调度到其他资源充足的节点上。

总的来说，Kubernetes通过调度机制、资源限制和请求、自动伸缩和节点管理等多种方式，实现了对容器资源的动态调配和管理，以确保应用程序能够高效地利用集群资源，并根据负载情况进行自动调整。

#### 1.5.1.Pod调度机制

Kubernetes 调度是指将工作负载（如 Pod）分配到合适的节点上运行的过程。调度器（kube-scheduler）是 Kubernetes 的核心组件之一，专门负责此任务。

[调度器的调度流程和算法](https://blog.csdn.net/qq_35861084/article/details/145130336)

调度过程
1. 调度请求：当用户提交一个 Pod 时，API Server 将其加入调度队列。 
2. 节点筛选（Filtering）：调度器根据一系列预定义规则过滤出满足要求的节点（候选节点）。 
3. 节点打分（Scoring）：为每个候选节点打分，选择分数最高的节点作为目标节点。 
4. 绑定 Pod：将 Pod 绑定到目标节点，并通过 API Server 通知对应节点的 kubelet 启动 Pod。

调度算法
1. 默认调度器采用了插件化设计，支持多种调度算法，包括：
   - 预选算法：用于过滤不满足条件的节点。
   - 优选算法：为符合条件的节点打分，选择最优节点。
2. 用户可以自定义调度逻辑，甚至替换默认调度器。

#### 1.5.2.资源管理

Kubernetes 通过资源配额和优先级控制实现资源的合理分配和管理，确保应用的稳定运行并防止资源滥用。

资源类型
1. 计算资源：
   - CPU：以核为单位，可以指定小数（如 0.5 表示半个 CPU 核）。
   - 内存：以字节为单位，支持 Ki、Mi、Gi 等单位。
2. 存储资源：
   - 使用 PersistentVolume（PV）和 PersistentVolumeClaim（PVC）管理存储。
3. 网络资源：
   - 管理 Pod 的网络流量和带宽。

资源限制:通过 resources 字段定义 Pod 或容器的资源限制：
```yaml
resources:
  requests:         # 资源的最低请求值，调度器根据此值选择合适的节点。
    memory: "64Mi"
    cpu: "250m"
  limits:           # 资源的最大使用值，容器运行时不能超过。
    memory: "128Mi"
    cpu: "500m"
```

资源配额（Resource Quotas）
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
spec:
  hard:     # 资源配额。用于限制命名空间内资源的总使用量，防止单个用户或应用占用过多资源。
    pods: "10"
    requests.cpu: "4"
    requests.memory: "8Gi"
    limits.cpu: "10"
    limits.memory: "16Gi"
```

#### 1.5.3.调度策略

默认调度策略
1. 资源需求匹配：根据 Pod 的 resources.requests 找到能够满足需求的节点。
2. 节点亲和性和反亲和性： 控制 Pod 部署到特定节点或避免特定节点。
3. Pod亲和性和反亲和性： 控制 Pod 部署到与其他特定 Pod 相同或不同的节点。

```yaml
affinity:
  nodeAffinity:             # 1.节点亲
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - node1
  podAffinity:              # 2.Pod亲和性
    requiredDuringSchedulingIgnoredDuringExecution:
      labelSelector:
        matchLabels:
          app: web
      topologyKey: "kubernetes.io/hostname"
```

自定义调度策略：

1.Taints 和 Tolerations：用于限制 Pod 被调度到带有特定污点的节点上。
```yaml
taints:
- key: "dedicated"
  value: "batch-processing"
  effect: "NoSchedule"
tolerations:
- key: "dedicated"
  operator: "Equal"
  value: "batch-processing"
  effect: "NoSchedule"
```

2.Priority and Preemption： 优先级定义 Pod 的重要性，优先级高的 Pod 会抢占低优先级 Pod 的资源
```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
preemptionPolicy: PreemptLowerPriority
globalDefault: false
description: "This priority class is for high priority pods."
```

#### 1.5.4.自动伸缩

- [Kubernetes-自动伸缩](https://blog.csdn.net/kankan_s/article/details/132484676)
- [k8s多维度自动弹性伸缩](https://cloud.tencent.com/developer/article/2092254)

1. HPA（Horizontal Pod Autoscaler）。调整pod数量。
2. VPA。调整pod资源大小
3. Cluster Autoscaler。k8s节点资源不足导致pod分配不到资源，自动伸缩节点数量。（多用于云服务器上）


以下为HPA的案例
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: example-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: example-deployment
  minReplicas: 1        # 最小副本数
  maxReplicas: 10       # 最大副本数    
  metrics:
  - type: Resource
    resource:
      name: cpu                 # CPU使用率高于50%触发
      target:
        type: Utilization
        averageUtilization: 50
```

### 1.6.基本网络模型
Kubernetes 网络模型定义了 Pod、节点和服务之间的网络通信规则和要求。其目标是为容器化应用提供一致、灵活的网络环境。

- Kubernetes 网络模型 强调 Pod IP 的统一性和直接通信，支持通过 CNI 插件实现灵活的网络架构。
- Netns 提供容器化环境下的网络隔离能力，通过 veth pair 和 CNI 插件实现连接。
- 主流网络方案（如 Flannel、Calico、Cilium）提供多样化选择，以适应不同的集群规模和性能需求。
- Network Policy 是实现网络安全的核心工具，用于精细控制 Pod 的网络流量，提高集群的安全性和隔离性。

#### 1.6.1.基本要求
1. 每个 Pod 有唯一的 IP 地址：
   - Kubernetes 分配给每个 Pod 一个独立的 IP 地址（Pod IP），Pod 内的所有容器共享这个网络命名空间（netns）。
   - Pod 可以直接通过 IP 地址与其他 Pod 通信，无需 NAT。
2. 所有 Pod 都可以直接相互通信：
   - 不论 Pod 是否在同一节点上，都可以通过 Pod IP 实现无障碍通信。
3. 节点上的所有 Pod 可以访问外部网络： 
   - Kubernetes 提供出口 NAT（SNAT），使 Pod 可以访问集群外部资源。
4. 服务抽象（Service）提供了 Pod 的稳定访问：
   - Kubernetes 使用 ClusterIP、NodePort 或 LoadBalancer 等机制，确保服务可以被其他服务或外部流量访问。

#### 1.6.2.网络的三个层次
- Node-to-Node 通信：不同节点上的 Pod 能够通过 Overlay 网络或路由实现直接通信。
- Pod-to-Pod 通信：在同一节点或跨节点，Pod 可以通过虚拟网络接口（veth pair）或其他网络插件实现通信。
- Service-to-Pod 通信：服务通过 kube-proxy 或其他负载均衡机制将流量路由到目标 Pod。

#### 1.6.3.Netns

Linux 的网络命名空间（Netns）是实现 Kubernetes 网络隔离的核心机制。

Netns 的定义
- Netns 是 Linux 内核的一种隔离机制，它允许创建多个独立的网络堆栈实例，包括网络接口、路由表、iptables 等。
- 每个容器或 Pod 都运行在一个独立的 Netns 中，实现网络环境的隔离。

Netns 的工作原理
1. 主机网络命名空间（Root Netns）：主机的默认网络命名空间，包含所有物理网卡和主机的网络堆栈。 
2. 容器网络命名空间： 每个容器有自己的网络命名空间，内含虚拟网络接口（veth pair），通过它与宿主机或其他网络命名空间通信。
3. veth pair 机制：
   - veth pair 是一对虚拟网络接口，类似一根网线的两端，一端连接容器的 Netns，另一端连接主机或网络插件。 
   - 数据包在容器与主机之间通过 veth pair 传递。 
4. CNI 插件与 Netns：
   - Kubernetes 使用 CNI（Container Network Interface） 插件创建和配置容器的网络命名空间。
   - 插件会负责为容器分配 IP 地址、设置路由和防火墙规则。

#### 1.6.4.网络方案

- Flannel：
  - 特点：简单、轻量级的 Overlay 网络，适合小型集群。
  - 实现方式：使用 VXLAN 或 Host-GW 进行 Pod 网络的 Overlay 实现。
  - 场景：适用于简单的 Pod 网络隔离场景。
- Calico：
  - 特点：高性能的路由网络，支持网络策略（Network Policy），无 Overlay。
  - 实现方式：基于 BGP 实现路由分发，也支持 eBPF。
  - 场景：高性能、大规模集群，复杂的网络策略需求。
- Cilium：
  - 特点：基于 eBPF 技术，性能优越，支持动态流量管理和细粒度的安全控制。
  - 实现方式：通过 eBPF 实现网络数据包的拦截和处理。
  - 场景：需要高性能和复杂网络安全控制的环境。
- Weave Net：
  - 特点：支持跨云平台的 Overlay 网络，自动发现节点和 Pod。
  - 实现方式：通过 VXLAN 实现 Pod 网络连接。
  - 场景：多云环境或需要简单配置的场景。
- Kube-Router：
  - 特点：集成网络路由、服务代理和网络策略功能的插件。
  - 实现方式：基于 IPVS 提供高效路由。
  - 场景：对路由和服务代理性能要求较高的集群。
- NSX-T（VMware 提供）：
  - 特点：企业级网络方案，支持多租户和高级网络功能。
  - 实现方式：通过虚拟化和软件定义网络（SDN）技术实现。
  - 场景：需要多租户和复杂网络控制的企业环境。

#### 1.6.5.Network Policy

Network Policy 是 Kubernetes 提供的一种网络安全机制，用于控制 Pod 之间的网络通信以及 Pod 与外部服务的访问。

Network Policy 的功能
1. 限制 Pod 间的流量：默认情况下，Kubernetes 中 Pod 之间是完全开放的。通过 Network Policy，可以限制哪些 Pod 可以与特定 Pod 通信。
2. 管理 Pod 与外部网络的访问：可以定义规则控制 Pod 是否允许访问外部网络或被外部网络访问。
3. 提高集群的安全性：防止未经授权的访问和潜在的网络攻击，尤其在多租户环境中。
4. 实现多租户隔离：在同一个集群中，确保不同租户的 Pod 流量彼此隔离。

Network Policy 的主要组件
1. PodSelector： 定义哪些 Pod 受该策略影响。
2. Ingress（入站规则）：定义允许哪些流量进入受策略影响的 Pod。
3. Egress（出站规则）：定义允许哪些流量从受策略影响的 Pod 发出。
4. 规则作用范围：规则可以基于命名空间、IP 地址范围、标签等

案例如下：定义了一个 Network Policy，允许某些 Pod（具有 app: frontend 标签）只能接收来自 app: backend 的流量
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-backend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: frontend
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: backend
```

### 1.7.控制器
控制器（Controller）是 Kubernetes 集群中负责自动化管理和维护特定资源类型的组件。

#### 1.7.1.控制器类型

1. ReplicaSet 控制器
   - 功能：确保某个 Pod 的指定副本数始终运行。
   - 工作原理：如果某些 Pod 停止工作，ReplicaSet 会创建新的 Pod 来替换这些失败的 Pod。它确保集群中有指定数量的 Pod 副本。
   - 场景：用于无状态应用的容器集群。
2. Deployment 控制器
   - 功能：管理 无状态应用的部署，支持 Pod 的滚动更新和回滚操作，支持动态扩容。
   - 工作原理：确保一定数量的 Pod 副本正在运行，并支持无停机的升级。如果新的 Pod 配置不符合期望，Deployment 会自动回滚到上一版本。
   - 场景：用于部署无状态应用，支持版本更新、滚动升级等功能。
3. StatefulSet 控制器
   - 功能：管理有状态应用的部署，保证 Pod 顺序和持久化存储
   - 工作原理：不同于 ReplicaSet，StatefulSet 会为每个 Pod 分配持久化存储（如 PersistentVolume），并确保 Pod 在重启或调度时保持顺序性。
   - 场景：用于管理有状态服务，如数据库、缓存等需要持久化和顺序管理的应用。
4. DaemonSet 控制器
   - 功能：确保在集群中的每个节点上都运行一个 Pod。
   - 工作原理：DaemonSet 会在每个新节点上启动一个 Pod，适用于需要在每个节点上运行的服务，如日志收集、监控代理。
   - 场景：运行集群级别的后台进程（如 Fluentd、Prometheus Node Exporter）。
5. Job 控制器
   - 功能：用于管理一次性任务，确保任务完成后退出。
   - 工作原理：Job 会创建一个或多个 Pod 执行指定任务，直到任务完成。
   - 场景：处理批处理任务、数据迁移等一次性任务。
6. CronJob 控制器
   - 功能：用于定时执行任务，类似于 Unix/Linux 系统中的 Cron。
   - 工作原理：CronJob 控制器按照指定的时间表创建 Job 资源，定期执行任务。
   - 场景：定时备份、定期清理日志等。

#### 1.7.2.工作流程

1. 创建资源：用户通过定义 YAML 或 JSON 文件来描述资源的期望状态，例如定义一个 Deployment。
2. 获取资源状态：控制器通过 Informer 获取集群资源的实际状态，包括 Pods、Deployments 等。
3. 比较实际状态和期望状态：控制器比较集群中资源的实际状态与用户定义的期望状态。
4. 差异计算：如果实际状态与期望状态不同，控制器会计算出差异并采取行动（如创建、删除或更新资源）来纠正实际状态。
5. 状态同步：控制器根据计算的差异采取行动，直到实际状态与期望状态一致。
6. 持续监控：控制器不断循环，监控资源的状态，并根据变化做出调整。

#### 1.7.3.核心组件

一个标准的控制器包含以下几个核心部分：

1. Informer：定期从 Kubernetes API 服务器获取集群资源的当前状态。
2. Reconciler：负责比较实际状态与期望状态，并采取措施修正差异。
3. Event Handler：处理资源状态变化时触发的事件，如资源创建、更新或删除。
4. Controller Loop：控制器的核心循环，它负责不断从集群中拉取资源状态，进行差异计算并调整状态。

#### 1.7.4.设计模式

控制器模式是面向事件驱动的编程模型，遵循以下基本设计模式：
1. 观察者模式：控制器不断监视 Kubernetes API 服务器中的资源状态变化，类似于观察者模式，自动响应状态的变化。
2. 补偿模式（Reconciliation Pattern）：控制器将实际状态与期望状态进行比较，发现差异后采取补偿措施，确保集群状态与期望一致。

#### 1.7.5.Operator

Operator 是对控制器模式的扩展，它允许开发者创建自定义的控制器来管理复杂的应用程序。通过 Operator，用户可以将应用程序的管理逻辑自动化，如自动升级、备份、扩容等。

区别：
- 控制器：通常处理基本的资源管理任务，适用于 Kubernetes 核心资源。
- Operator：通过自定义控制器来处理特定应用的生命周期管理，包括应用的部署、升级和备份等。

#### 1.7.6.应用场景

1. 自动扩展与容错：例如，ReplicaSet 和 Deployment 控制器负责确保应用的高可用性和自动扩展。
2. 无状态和有状态应用的管理：如 Deployment 和 StatefulSet 控制器分别用于管理无状态和有状态应用。
3. 集群管理：如 DaemonSet 用于在每个节点上运行代理服务，管理集群级别的功能。
4. 批处理与定时任务：Job 和 CronJob 控制器适用于管理一次性或定时任务。
5. 自定义资源管理：通过创建 Operator，用户可以为自己的应用程序创建特定的控制器，自动化管理应用生命周期。

#### 1.7.7.DaemonSet

作用：
1. 节点级服务：DaemonSet 用于在每个节点上部署 Pod，通常用于集群级别的后台服务。例如，日志收集、节点监控、网络代理等服务需要在每个节点上运行。
2. 自动管理 Pod：当集群中新增节点时，DaemonSet 会自动为该节点部署一个新的 Pod；当节点被删除时，DaemonSet 会自动删除该节点上运行的 Pod。


ctl
```shell
查看 DaemonSet 的状态:kubectl get daemonset
NAME          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd       3         3         3       3            3           <none>          10m
node-exporter 3         3         3       3            3           <none>          15m

DESIRED：        期望的 Pod 数量；
CURRENT：        当前运行的 Pod 数量；
READY：          就绪的 Pod 数量；
UP-TO-DATE：     更新后的 Pod 数量；
AVAILABLE：      可用的 Pod 数量。
```

```yaml
1.日志收集和聚合。在每个节点上运行一个日志收集器（如 Fluentd 或 Filebeat），收集日志并转发到集中式日志存储系统（如 Elasticsearch、Kibana、Logstash 等）。
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
spec:
  selector:
    matchLabels:
      name: fluentd     # 选择哪些节点应该运行 DaemonSet 管理的 Pod，通常会与 Pod 模板的标签进行匹配。
  template:
    metadata:
      labels:
        name: fluentd   # Pod 模板，定义要运行的容器及其配置。
    spec:
      containers:
      - name: fluentd
        image: fluentd:latest
        volumeMounts:
        - name: varlog
          mountPath: /var/log
  updateStrategy:           # 更新策略，指定如何更新 DaemonSet 的 Pod，通常有两种策略
                            #   RollingUpdate（默认）：滚动更新方式，逐步替换 Pod。    
                            #   OnDelete：手动删除 Pod 时才进行替换。
    type: RollingUpdate     # 默认为滚动更新，可以逐步替换旧的 Pod
    rollingUpdate:
      maxUnavailable: 1     # 在更新过程中，最多允许不可用的 Pod 数量
  volumes:
  - name: varlog
    hostPath:
      path: /var/log
      type: Directory

2.节点监控：使用 Prometheus Node Exporter 或其他监控代理在每个节点上收集系统级指标（如 CPU、内存、磁盘、网络等），并将数据推送到 Prometheus 监控系统。
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
spec:
  selector:
    matchLabels:
      name: node-exporter
  template:
    metadata:
      labels:
        name: node-exporter
    spec:
      containers:
      - name: node-exporter
        image: prom/node-exporter:latest
        ports:
        - containerPort: 9100

3.网络代理和服务网格。在每个节点上运行网络代理，确保每个节点的流量都能通过网络代理进行管理。例如，使用 Istio 或 Linkerd 等服务网格技术时，可能需要将 Sidecar Proxy 部署为 DaemonSet 以管理每个节点的流量。
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: istio-proxy
spec:
  selector:
    matchLabels:
      app: istio-proxy
  template:
    metadata:
      labels:
        app: istio-proxy
    spec:
      containers:
      - name: proxy
        image: istio/proxyv2:latest
        ports:
        - containerPort: 15001

4.防火墙和安全代理。使用 DaemonSet 部署防火墙代理或安全代理，确保每个节点都进行安全监控或数据过滤。例如，Calico 网络插件会在每个节点上部署网络安全代理。
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: calico-node
spec:
  selector:
    matchLabels:
      name: calico-node
  template:
    metadata:
      labels:
        name: calico-node
    spec:
      containers:
      - name: calico
        image: calico/node:latest
```

## 2.Harbor

- 官网：[https://goharbor.io/](https://goharbor.io/)
- 安装教程： https://www.cnblogs.com/pangguoping/p/7650014.html
- 教程：https://blog.csdn.net/robin_cai/article/details/124292678
- 简单的安装教程：[https://blog.csdn.net/shawn210/article/details/98068165](https://blog.csdn.net/shawn210/article/details/98068165)

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

k8s 提供了基础的命令行功能，一些复杂的操作还是比较麻烦的，所以需要使用更高级别的管理工具。

k8s 已然是当下容器编排领域事实上的标准，各大云服务商都急于推出 k8s 服务，互联网公司也纷纷跟进，将自己的应用容器化，并使用 k8s 编排。
在 k8s 图形化工具方面，我们已经获得了极大的可选择空间：

- 各云服务商自己推出的 k8s 服务所搭载的管理控制台，例如 
  - 阿里云的 k8s 服务
  - 青云推出的 KubeSphere
  - 其他云服务商的 CaaS 类服务
- k8s 官方的图形管理界面 k8s Dashboard
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

