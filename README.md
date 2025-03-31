# 声明

只是一个示例，不是包装好的工具，最终可以帮助实现在app类方法的任意位置插入代码，且支持app热启动和冷启动两种方式

由于frida不支持java层的任意位置插入代码，只能在方法执行前后插入代码，遂提出此方法

# 使用教程

UnCrackable-Level1是apk目录文件夹

UnCrackable-Level1.apk修改后缀为.zip/rar/tar....，解压后得到UnCrackable-Level1文件夹

`UnCrackable-Level1\classes.dex`为apk源dex文件

## dex转smali

```shell
java -jar .\baksmali-2.5.2.jar d [dex文件] -o [输出文件夹]
```

会在**[输出文件夹]**下生成smali代码，如：

```shell
java -jar .\baksmali-2.5.2.jar d .\UnCrackable-Level1\classes.dex -o .\UnCrackable-Level1\out
```

## smali转dex

```shell
java -jar .\smali-2.5.2.jar a [smali代码文件夹] -o [dex文件]
```

会在**[dex文件]**路径生成dex文件，如：

```shell
java -jar .\smali-2.5.2.jar a .\UnCrackable-Level1\out\ -o .\UnCrackable-Level1\out.dex
```

## 动态替换dex中的class

### 安装frida

frida是一个动态插桩工具，涉及语言js和python

用于修改和监控app的行为

**服务器**：android手机设备（被控制端） 安装`frida-server` 

[下载地址](https://github.com/frida/frida/releases)

需要先查看android的cpu架构

```shell
adb shell getprop ro.product.cpu.abi
```

需要保证下载的`frida-server`和手机设备cpu架构匹配



**客户端**：PC（控制端）安装`frida`，`frida-tools`

需要安装python3.x环境

```shell
pip install frida==16.6.6
pip install frida-tools==13.6.1
```

客户端编写的 `Python` 代码，用于连接远程设备，提交要注入的 `JS` 代码到服务端，接受服务端发来的消息。

服务端中需要用 `JS` 代码注入到目标进程，操作内存数据，给客户端发送消息。

### android端启动frida（需要root）

```
#如果使用的是模拟器可以使用:
adb connect [ip:port]
#以mumu模拟器12为例:adb connect localhost:7555

#如果列出设备就表示连接成功
adb devices

# 把下载好的frida-server 放到 安卓的/data/local/tmp/目录
adb push ./frida-server /data/local/tmp/

# 进入 手机命令
adb shell
 
# 超级管理
su
 
# 进入 frida-server 目录
cd /data/local/tmp
 
# 修改 文件 权限
chmod 755 frida-server
 
# 运行文件
./frida-server

#在pc端运行frida-ps，如果列出app应用则表示连接到frida-server了
frida-ps -U
```

### 修改dex

#### 问题分析

`UnCrackable-Level1` APP点击`OK`会按钮会直接终止app

<img src=".\pic\image-20240922193100961.png" style="zoom:50%;" />

**`jadx-gui`**查看发现UnCrackable-Level1的相应事件如下

<img src=".\pic\image-20240922194306973.png" alt="image-20240922194306973"  />

我们直接把`system.exit(0)`给删去就可以使app不退出

#### dex转smali

```shell
java -jar .\baksmali-2.5.2.jar d .\UnCrackable-Level1\classes.dex -o .\UnCrackable-Level1\out
```

#### 修改smali代码

这是一个匿名的内部类MainActivity$1，找到对应的MainActivity$1.smali修改，如下：

```smalltalk
# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 3

    const/4 p1, 0x0

    #invoke-static {p1}, Ljava/lang/System;->exit(I)V

    return-void
.end method
```

注释掉系统退出的代码逻辑

#### smali转dex

```shell
java -jar .\smali-2.5.2.jar a .\UnCrackable-Level1\out\ -o .\UnCrackable-Level1\out.dex
```

### 应用新dex

#### dex导入手机

可以使用**`jadx-gui`**查看逻辑是否更改：

<img src=".\pic\image-20250331185113923.png" alt="image-20250331185113923"  />

可以发现，`system.exit(0)`确实被我们注释掉了

导入手机：

```shell
adb push .\UnCrackable-Level1\out.dex /data/local/tmp
```

#### 动态替换class

查看应用名称，这里是uncrackable1

```shell
frida-ps -U
```

注入脚本test.js，注意此时使用的是frida attach方法，需要保证app正在运行

```shell
frida -U  -n uncrackable1 -l .\test.js
```

注意：如果修改的是MainActivity类的话，就需要使用frida spawn，注入脚本命令就要改为：

```shell
frida -U -f owasp.mstg.uncrackable1 -l test.js 
```

#### 查看结果

可以发现，点击按钮后app不再终止

<img src=".\pic\image-20240922202346430.png" alt="image-20240922202346430"  />

## 替换原理说明

### 核心思路

①dex→smali和smali →dex精确翻译，不会有类似反编译的失真问题

②在app原dex文件已经被Pathclassloader加载的前提下，虽然android类加载机制下每个类只会被加载一次且不可卸载，但不同类加载器的隔离机制使得内存中可以有多个同名的类，这使得我们修改后的dex中的类也能同时由DexClassloader加载。

③frida可以指定类加载器，使用和修改其中的类，且其可以直接替换某个方法的内部逻辑、返回值、参数列表等。

④使用frida直接将Pathclassloader中加载的原方法逻辑替换为DexClassloader加载的我们修改后的方法逻辑

如：

```javascript
var targetClassName = "sg.vantagepoint.uncrackable1.MainActivity$1"
//Pathclassloader加载的目标类
var orgfuc = Java.use(targetClassName)
var DexClassLoader = Java.use('dalvik.system.DexClassLoader');
var customDexPath = "/data/local/tmp/out.dex";  // android端你的修改后 DEX文件 的路径
var optimizedDir = "/data/local/tmp/cache";

// 使用 DexClassLoader 加载新的 dex
var customClassLoader = DexClassLoader.$new(customDexPath, optimizedDir, null, null);

//Dexclassloader加载的目标类
var myfuc = Java.ClassFactory.get(customClassLoader).use(targetClassName);
orgfuc.onClick.overload('android.content.DialogInterface', 'int').implementation = function (arg1, arg2) {
	return myfuc.onClick(arg1, arg2);//替换为myfuc的实现
}
```

### 优点

1. 无需重新打包、签名、安装
2. 除了修改MainActivity需重新启动app，其余类修改无需重启app，即时生效
3. 在动态分析工作流程中只有插入log语句需要人工修改smali代码，其余步骤均可自动化
