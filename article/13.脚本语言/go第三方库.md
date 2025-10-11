---
sort: 3
---
# go第三方库

## Fyne

Fyne 是一个用于 Go 语言的现代化、跨平台的 GUI（图形用户界面）工具包，它让开发者能够轻松地使用 Go 语言创建具有丰富交互性和美观界面的桌面和移动应用程序。

[go桌面框架Fyne最全api文档](https://blog.csdn.net/m0_74823933/article/details/145269826)


### 外部依赖

fyne作为一个可视化界面库，需要使用 OpenGL 来渲染图形界面，而 go-gl/gl 需要系统的 OpenGL开发库。

linux如何安装OpenGL：
```shell
sudo apt update
sudo apt install gcc libgl1-mesa-dev xorg-dev
```

windows如何安装OpenGL：
```shell
MSYS2。MSYS2 是 Windows 上的开发环境，提供了更现代的工具链。
1. 下载：https://www.msys2.org/

2. 安装：在 MSYS2 的终端中，运行以下命令来更新系统并安装必要的包。
pacman -S mingw-w64-x86_64-toolchain
pacman -S mingw-w64-x86_64-glfw

3.将 MSYS2 的 mingw64\bin 目录添加到系统的 PATH 环境变量中

4.设置 CGO 环境变量。Go 的 cgo 工具需要知道如何找到 C 编译器。
在cmd窗口执行以下命令：
set CGO_ENABLED=1

5.验证安装：在cmd窗口执行以下命令：
gcc --version
```

当然fyne也可以不用OpenGL进行渲染。fyne 提供了一个软件渲染模式，不需要 OpenGL 支持。你可以通过设置环境变量来启用它：
```shell
set FYNE_FONT=simsun.ttc
set FYNE_THEME=light
set FYNE_SCALE=1
set FYNE_RENDER=software
```


### 主要特点
1. **跨平台支持**：Fyne 支持多种操作系统，包括 Windows、Linux、macOS 等桌面操作系统，以及 Android 和 iOS 等移动操作系统。这意味着开发者编写的一份代码可以在不同平台上运行，大大提高了开发效率。
2. **易于使用**：它提供了简洁易懂的 API，使得即使是初学者也能快速上手。开发者可以使用声明式的方式来构建用户界面，代码结构清晰，易于维护。
3. **响应式设计**：Fyne 能够自适应不同的屏幕尺寸和分辨率，确保应用在各种设备上都能有良好的显示效果。无论是在大屏幕的桌面电脑上，还是在小屏幕的手机上，应用界面都能自动调整布局。
4. **丰富的组件库**：Fyne 提供了一系列常用的 GUI 组件，如按钮、标签、文本框、列表框、菜单等，开发者可以方便地使用这些组件来构建功能丰富的用户界面。
5. **主题支持**：支持自定义主题，开发者可以根据自己的需求来定制应用的外观，使应用具有独特的风格。
6. **资源管理**：提供了方便的资源管理功能，开发者可以将图片、音频等资源打包到应用中，并且可以轻松地在代码中引用这些资源。

### 应用场景
1. **桌面应用开发**：可以用于开发各种类型的桌面应用程序，如办公软件、工具软件、游戏等。
2. **移动应用开发**：借助 Fyne 的跨平台特性，开发者可以开发适用于 Android 和 iOS 平台的移动应用，减少了开发成本和时间。
3. **嵌入式系统开发**：由于 Go 语言具有高效、简洁的特点，Fyne 也可以用于嵌入式系统的 GUI 开发，如智能家居设备、工业控制设备等。

### 示例代码
以下是一个简单的 Fyne 应用示例，创建一个包含按钮和标签的窗口：
```go
package main

import (
    "fyne.io/fyne/v2/app"
    "fyne.io/fyne/v2/container"
    "fyne.io/fyne/v2/widget"
)

func main() {
    // 创建一个新的 Fyne 应用
    a := app.New()
    // 创建一个新的窗口
    w := a.NewWindow("Hello Fyne")

    // 创建一个标签
    label := widget.NewLabel("Hello, Fyne!")
    // 创建一个按钮
    button := widget.NewButton("Click me", func() {
        label.SetText("Button clicked!")
    })

    // 创建一个垂直布局容器，包含标签和按钮
    content := container.NewVBox(label, button)

    // 设置窗口内容
    w.SetContent(content)
    // 显示窗口并运行应用
    w.ShowAndRun()
}
```
在这个示例中，我们使用 Fyne 创建了一个简单的窗口，窗口中包含一个标签和一个按钮。当点击按钮时，标签的文本会发生变化。

### 常用命令

```shell
//全局安装fyne打包工具[使用命令行进行打包操作]
go install fyne.io/fyne/v2/cmd/fyne@latest

// 项目引入fyne库
go get fyne.io/fyne/v2@latest
go mod tidy

//以窗口形式启动
go run main.go
//以手机模拟器形式启动
go run -tags mobile main.go

//打包
//桌面端
fyne package -os windows -icon icon.png

//移动端
fyne package -os android -appID my.domain.appname
fyne install -os android

fyne package -os ios -appID my.domain.appname
fyne package -os iossimulator -appID my.domain.appname
```