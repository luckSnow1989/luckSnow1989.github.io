# JMH

[官方案例](https://hg.openjdk.java.net/code-tools/jmh/file/tip/jmh-samples/src/main/java/org/openjdk/jmh/samples/) 

[代码案例](https://gitee.com/luckSnow/spring-boot-example/tree/master/lab_000_base_web/src/main/java/com/zx/web/jmh/test) 

[JMH 与 8 个测试陷阱](https://www.cnkirito.moe/java-jmh/) 

[使用JMH进行微基准测试：不要猜，要测试！](http://www.hollischuang.com/archives/1072)

[使用JMH做Java微基准测试](https://developer.aliyun.commeasurementIterations/article/341539)

源码[https://github.com/openjdk/jmh](https://github.com/openjdk/jmh)

## 1.介绍

JMH是OpenJDK开发的微基准测试框架。

在日常开发中，我们对一些代码的调用或者工具的使用会存在多种选择方式，在不确定他们性能的时候，我们首先想要做的就是去测量它。大多数时候，我们会简单的采用多次计数的方式来测量，来看这个方法的总耗时。

但是，如果熟悉JVM类加载机制的话，应该知道JVM默认的执行模式是JIT编译与解释混合执行。JVM通过热点代码统计分析，识别高频方法的调用、循环体、公共模块等，基于JIT动态编译技术，会将热点代码转换成机器码，直接交给CPU执行。

也就是说，JVM会不断的进行编译优化，这就使得很难确定重复多少次才能得到一个稳定的测试结果？所以，很多有经验的同学会在测试代码前写一段预热的逻辑。

JMH，全称 Java Microbenchmark Harness (微基准测试框架），是专门用于Java代码微基准测试的一套测试工具API，是由 OpenJDK/Oracle 官方发布的工具。

何谓 Micro Benchmark 呢？简单地说就是在 method 层面上的 benchmark，精度可以精确到微秒级。

Java的基准测试需要注意的几个点：

- 测试前需要预热。
- 防止无用代码进入测试方法中。
- 并发测试。
- 测试结果呈现。

JMH的使用场景：

- 定量分析某个热点函数的优化效果
- 想定量地知道某个函数需要执行多长时间，以及执行时间和输入变量的相关性
- 对比一个函数的多种实现方式

## 2.基于注解的使用

### 2.1.@BenchmarkMode

微基准测试类型。JMH 提供了以下几种类型进行支持。可以注释在方法级别，也可以注释在类级别

- Throughput: 	整体吞吐量，例如“1秒内可以执行多少次调用”。
- AverageTime: 	调用的平均时间，例如“每次调用平均耗时xxx毫秒”。
- SampleTime: 	随机取样，最后输出取样结果的分布，例如“99%的调用在xxx毫秒以内，99.99%的调用在xxx毫秒以内”
- SingleShotTime: 以上模式都是默认一次 iteration 是 1s，唯有 SingleShotTime 是只运行一次。往往同时把 warmup 次数设为0，用于测试冷启动时的性能。
- All			：上面全部的类型都来一次

### 2.2.@Warmup

进行基准测试前需要进行预热，iterations = 3就是指预热轮数。

一般我们前几次进行程序测试的时候都会比较慢， 所以要让程序进行几轮预热，保证测试的准确性。其中的参数iterations也就非常好理解了，就是预热轮数。 

为什么需要预热？

因为 JVM 的 JIT 机制的存在，如果某个函数被调用多次之后，JVM 会尝试将其编译成为机器码从而提高执行速度。所以为了让 benchmark 的结果更加接近真实情况就需要进行预热。

```java
@Warmup(iterations = 3)
```

### 2.3.@Measurement

正式度量计算的轮数，其实就是一些基本的测试参数，可以根据具体情况调整。一般比较重的东西可以进行大量的测试，放到服务器上运行。

- iterations 进行测试的轮次
- time 每轮进行的时长
- timeUnit 时长单位

```java
@Measurement(iterations = 10, time = 5, timeUnit = TimeUnit.SECONDS)
```

### 2.4.@Threads

每个进程中的测试线程，这个非常好理解，根据具体情况选择，一般为cpu乘以2

```java
@Threads(Threads.MAX)
```

### 2.5.@Fork

进行 fork 的次数。如果 fork 数是2的话，则 JMH 会 fork 出两个进程来进行测试。

### 2.6.@OutputTimeUnit

基准测试结果的时间类型。一般选择秒、毫秒、微秒。

### 2.7.@Benchmark
方法级注解，表示该方法是需要进行 benchmark 的对象，用法和 JUnit 的 @Test 类似。就是执行的入口

### 2.8.@Param
属性级注解，@Param 可以用来指定某项参数的多种情况。特别适合用来测试一个函数在不同的参数输入的情况下的性能。

```java
@Param({"1000", "10000", "100000"})
private int count;
```

### 2.9.@Setup
方法级注解，这个注解的作用就是我们需要在测试之前进行一些准备工作，比如对一些数据的初始化之类的。

### 2.10.@TearDown
方法级注解，这个注解的作用就是我们需要在测试之后进行一些结束工作，比如关闭线程池，数据库连接等的，主要用于资源的回收等。

### 2.11.@State
当使用@Setup参数的时候，必须在类上加这个参数，不然会提示无法运行。

就比如我上面的例子中，就必须设置state。

State 用于声明某个类是一个“状态”，然后接受一个 Scope 参数用来表示该状态的共享范围。因为很多 benchmark 会需要一些表示状态的类，JMH 允许你把这些类以依赖注入的方式注入到 benchmark 函数里。Scope 主要分为三种。

Thread: 该状态为每个线程独享。
Group: 该状态为同一个组里面所有线程共享。
Benchmark: 该状态在所有线程间共享。

### 2.12.启动方法
在启动方法中，可以直接指定上述说到的一些参数，并且能将测试结果输出到指定文件中，

```java
/**
 * 仅限于IDE中运行
 * 命令行模式 则是 build 然后 java -jar 启动
 *
 * 1. 这是benchmark 启动的入口
 * 2. 这里同时还完成了JMH测试的一些配置工作
 * 3. 默认场景下，JMH会去找寻标注了@Benchmark的方法，可以通过include和exclude两个方法来完成包含以及排除的语义
 */
public static void main(String[] args) throws RunnerException {
    Options opt = new OptionsBuilder()
        // 包含语义
        // 可以用方法名，也可以用XXX.class.getSimpleName()
        .include("Helloworld")
        // 排除语义
        .exclude("Pref")
        // 预热10轮
        .warmupIterations(10)
        // 代表正式计量测试做10轮，
        // 而每次都是先执行完预热再执行正式计量，
        // 内容都是调用标注了@Benchmark的代码。
        .measurementIterations(10)
        //  forks(3)指的是做3轮测试，
        // 因为一次测试无法有效的代表结果，
        // 所以通过3轮测试较为全面的测试，
        // 而每一轮都是先预热，再正式计量。
        .forks(3)
        .output("E:/Benchmark.log")
        .build();
    new Runner(opt).run();
}
```

## 3.构建项目

### 3.1.方式1：自己引入依赖

maven依赖

```xml
<dependency>
    <groupId>org.openjdk.jmh</groupId>
    <artifactId>jmh-core</artifactId>
    <version>1.21</version>
</dependency>

<dependency>
    <groupId>org.openjdk.jmh</groupId>
    <artifactId>jmh-generator-annprocess</artifactId>
    <version>1.21</version>
    <scope>provided</scope>
</dependency>
```

maven插件

```xml
<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>exec-maven-plugin</artifactId>
    <executions>
        <execution>
            <id>run-benchmarks</id>
            <phase>integration-test</phase>
            <goals>
                <goal>exec</goal>
            </goals>
            <configuration>
                <classpathScope>test</classpathScope>
                <executable>java</executable>
                <arguments>
                    <argument>-classpath</argument>
                    <classpath/>
                    <argument>org.openjdk.jmh.Main</argument>
                    <argument>.*</argument>
                </arguments>
            </configuration>
        </execution>
    </executions>
</plugin>
```

### 3.2.方式2：maven命令生成项目

```shell
mvn archetype:generate \
    -DinteractiveMode=false \
    -DarchetypeGroupId=org.openjdk.jmh \
    -DarchetypeArtifactId=jmh-java-benchmark-archetype \
    -DgroupId=org.sample \
    -DartifactId=test \
    -Dversion=1.0
```

### 3.3.编写性能测试

```java
@State(Scope.Benchmark)
@OutputTimeUnit(TimeUnit.SECONDS)
@Threads(Threads.MAX)
public class LinkedListIterationBenchMark {

    private static final int SIZE = 10000;

    private List<String> list = new LinkedList<>();

    @Setup
    public void setUp() {
        for (int i = 0; i < SIZE; i++) {
            list.add(String.valueOf(i));
        }
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void forIndexIterate() {
        for (int i = 0; i < list.size(); i++) {
            list.get(i);
            System.out.print("");
        }
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void forEachIterate() {
        for (String s : list) {
            System.out.print("");
        }
    }
}
```

### 3.4.执行测试

运行 JMH 基准测试有两种方式，一个是生产jar文件运行，另一个是直接写main函数或者放在单元测试中执行。

```java
public static void main(String[] args) throws RunnerException {
    Options opt = new OptionsBuilder()
            .include(LinkedListIterationBenchMark.class.getSimpleName())
            .forks(1)
            .warmupIterations(2)
            .measurementIterations(2)
            .output("E:/Benchmark.log")
            .build();
    new Runner(opt).run();
}
```

### 3.5.报告结果

```text
# Detecting actual CPU count: 12 detected
# JMH version: 1.21
# VM version: JDK 1.8.0_131, Java HotSpot(TM) 64-Bit Server VM, 25.131-b11
# VM invoker: C:\Program Files\Java\jdk1.8.0_131\jre\bin\java.exe
# VM options: -javaagent:D:\Program Files\JetBrains\IntelliJ IDEA 2018.2.2\lib\idea_rt.jar=65175:D:\Program Files\JetBrains\IntelliJ IDEA 2018.2.2\bin -Dfile.encoding=UTF-8
# Warmup: 2 iterations, 10 s each
# Measurement: 2 iterations, 10 s each
# Timeout: 10 min per iteration
# Threads: 12 threads, will synchronize iterations
# Benchmark mode: Throughput, ops/time
# Benchmark: org.sample.jmh.LinkedListIterationBenchMark.forEachIterate

# Run progress: 0.00% complete, ETA 00:01:20
# Fork: 1 of 1
# Warmup Iteration   1: 1189.267 ops/s
# Warmup Iteration   2: 1197.321 ops/s
Iteration   1: 1193.062 ops/s
Iteration   2: 1191.698 ops/s


Result "org.sample.jmh.LinkedListIterationBenchMark.forEachIterate":
  1192.380 ops/s


# JMH version: 1.21
# VM version: JDK 1.8.0_131, Java HotSpot(TM) 64-Bit Server VM, 25.131-b11
# VM invoker: C:\Program Files\Java\jdk1.8.0_131\jre\bin\java.exe
# VM options: -javaagent:D:\Program Files\JetBrains\IntelliJ IDEA 2018.2.2\lib\idea_rt.jar=65175:D:\Program Files\JetBrains\IntelliJ IDEA 2018.2.2\bin -Dfile.encoding=UTF-8
# Warmup: 2 iterations, 10 s each
# Measurement: 2 iterations, 10 s each
# Timeout: 10 min per iteration
# Threads: 12 threads, will synchronize iterations
# Benchmark mode: Throughput, ops/time
# Benchmark: org.sample.jmh.LinkedListIterationBenchMark.forIndexIterate

# Run progress: 50.00% complete, ETA 00:00:40
# Fork: 1 of 1
# Warmup Iteration   1: 205.676 ops/s
# Warmup Iteration   2: 206.512 ops/s
Iteration   1: 206.542 ops/s
Iteration   2: 207.189 ops/s


Result "org.sample.jmh.LinkedListIterationBenchMark.forIndexIterate":
  206.866 ops/s


# Run complete. Total time: 00:01:21

REMEMBER: The numbers below are just data. To gain reusable insights, you need to follow up on
why the numbers are the way they are. Use profilers (see -prof, -lprof), design factorial
experiments, perform baseline and negative tests that provide experimental control, make sure
the benchmarking environment is safe on JVM/OS/HW level, ask for reviews from the domain experts.
Do not assume the numbers tell you what you want them to tell.

Benchmark                                      Mode  Cnt     Score   Error  Units
LinkedListIterationBenchMark.forEachIterate   thrpt    2  1192.380          ops/s
LinkedListIterationBenchMark.forIndexIterate  thrpt    2   206.866          ops/s
```
