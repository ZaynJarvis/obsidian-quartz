---
course: Agentic AI的原理与实践
chapter: 第二章：深入理解 Cursor 的三大思维模式与高级魔改
source: https://www.superlinear.academy/c/agentic-ai/sections/451912/lessons/1788635
scraped_at: 2026-06-27
---

# 第六课：Cursor手把手配置教程

## 我的理解

本课是一份面向零基础读者的实操指南，从下载安装 Cursor、登录 Cursor Pro 订阅，到切换 Agent 模式与 Claude 模型、开启 Auto-Run 自动执行，再到用第一个 prompt 直接生成 Google/Amazon 股价对比图。最具价值的一步是引入鸭哥的 devin.cursorrules repo（通过 cookiecutter 一行命令初始化），让 Cursor 获得 .cursorrules 自我进化能力与搜索等外部工具，把前几课讲的"Planner + 知识库 + 工具扩展"思路落地为可复制的工程模板。教程强调的核心配置要点是：Agent 模式 + Claude + Auto-Run + .cursorrules，这套组合是让 Cursor 从"高级补全"升级为"Agentic AI 助手"的最短路径。

## 相关链接

- [[Ch02-L04 拓展工具Access Web]]
- [[Ch02-L05 对比Devin]]
- [[Ch02-L00 引言]]

---

## 原文

Lesson 13 of 18
第六课：Cursor手把手配置教程

这个图文教程面向的读者是从来没有接触过 Cursor 的同学。我们会从头开始介绍安装、配置和使用鸭哥的 `devin.cursorrules` repo 来把它变成一个可以自我进化并且调用工具的 AI 智能体（AI Agent）。虽然这个文档是为了初学者设计的，但是有一定经验的 Cursor 用户也可以从中获得助益。对于你已经熟悉的章节，可以直接跳过。

安装和初始配置

Cursor的下载和安装与其他App并没有什么不同，它的下载链接可以在官网https://www.cursor.com/ 上找到。在初次启动Cursor以后，它会让你登录。对于第一次使用的同学，需要点击注册按钮去官网注册一个账号。

要想真的把Cursor用好，需要一个每月20美元的Cursor Pro Plan的订阅。但是对于初次使用的用户，Cursor也提供了一个免费试用的时期。我们可以在试用到期的时候再决定要不要付费订阅。

Cursor是一个代码编辑器，一般来说我们会用它打开一个文件夹，在文件夹中进行编辑。比如，你可以在电脑中新建一个文件夹 ~/Downloads/tmp，然后在Cursor中使用Open Folders打开这个位置。这时候你会看见类似下图的界面：

左边栏是这个文件夹下的内容，因为我们刚刚才把这个文件夹新建出来，所以它的内容是空的。中间是编辑代码的区域，但是因为我们主要使用Cursor的Agentic AI的功能，所以我们不太会使用这个区域。右侧边栏是我们和Cursor聊天、给它指令并且接收反馈的区域，这个对我们来说是最重要的。如果你没有看到这个区域，可以按Command+I来呼出这个边栏。由于我们主要使用Cursor的Agentic AI功能，我建议把这个边栏拖得大一些。

和 VS Code 一样，Cursor 的很多功能是通过直接在指令框中输入命令来完成的。我们可以在编辑代码的时候按 F1 键呼出一个命令框，如下图所示。




在其中，打字输入我们想要做的事情，也可以直接完成一系列的命令。比如说，我们不记得怎么把 Agent chat 框呼出来，那我们就可以直接在里面打 "new chat"。它就会给我们一些选项，我们可以点击相应的选项把 Agent chat 给再次调出来。在相应命令的右边也会有快捷键的提示，只要记住它的快捷键，我们下次就可以直接使用快捷键完成相应的功能。




由于我们会主要使用 Cursor Agentic AI 的功能，在这里我们需要尤其注意两个初始配置：

第一是，在这个聊天框的下方有个按钮可以设置模式，我们可以注意到它有三个模式，分别是 Agent，Ask 和 Manual。在我们的例子里，我们主要使用Agent模式，这里要注意不要切到 Ask 模式上，那是上一代“我说你写”的使用模式。

此外，在聊天框的左下角，我们可以指定想要使用的 AI 模型。我们一般推荐使用 Claude，因为它在各种场景下的表现最好。但是如果你想尝试其他模型的话，也不妨进行尝试。

总的来说你的配置应当像上图展示的那样。注意，左下角切在Agent模式，模型切在Claude。

在我们开始第一个例子之前，我们还需要对最后一个设置进行一些改动。在整个Cursor界面的右上角有一个齿轮图标。点击它会进入Cursor的设置界面。在设置界面的左方有多个tab。我们点入Features tab，并将右边的内容向下滚动，直到Enable Auto-Run Mode。

在这里，你可以根据自身情况进行配置。如果你希望在AI执行每一个命令前都对它进行审核并且手动确认，这里可以不勾选。如果你比较相信AI不会对你的系统造成什么损害，想要让它全自动执行命令的话，你可以在这里把它勾选。

第一个例子

在这个时候，我们就可以使用课程的Agentic模式来直接帮助我们完成一些事情了。比如说，我们可以在聊天框里面输入"plot the stock price of Google and Amazon in 2024 and show them in one figure"。

此时，Cursor 就会使用 Agent 的模式对整个任务进行分析、理解，并且决定使用 Python 来完成这些任务。

在Cursor自动化地执行完所有的代码撰写、环境配置、脚本执行之后，我们就可以看见当前文件夹下生成了一个图像文件。当我们单击左侧边栏中这个图像文件的时候，就可以看见我们希望的股价曲线。

Devin.cursorrules的配置

到这一步为止，我们使用的都是 Cursor 自己的功能。这个 AI agent 已经很强大，但仍然有几个严重的缺陷：它不能自我进化，不能记住自己学到的经验教训，也不能调用一些常见的外部工具。为了给 Cursor 加入这些功能，我们可以使用鸭哥的repo：https://github.com/grapeot/devin.cursorrules。

下面这一章我们主要介绍怎么配置、怎么使用这个 repo 来新建一个文件夹，让 Cursor 拥有这些功能。具体来说，我们需要用以下步骤进行配置：

1. 如果你还没有安装 Python 的话，需要去官网 https://www.python.org/downloads/ 或者使用你喜欢的包管理器来安装和配置 Python。

2. 我们需要安装 Cookiecutter 这个依赖库，来方便地初始化我们的 Cursor project。在系统的命令行（Cursor自己的命令行窗口也可以）中执行：

pip3 install cookiecutter

3. 我们需要去你想放置这个 Cursor project 的地方，并且在命令行中执行这个命令。

cookiecutter gh:grapeot/devin.cursorrules --checkout template

如果系统报错command not found: cookiecutter，可以试试这个命令：

python3 -m cookiecutter gh:grapeot/devin.cursorrules --checkout template

这个命令会启动一个向导来引导你完成配置，类似这样：



```

➜  Downloads python3 -m cookiecutter gh:grapeot/devin.cursorrules --checkout template

/Users/grapeot/Library/Python/3.9/lib/python/site-packages/urllib3/__init__.py:35: NotOpenSSLWarning: urllib3 v2 only supports OpenSSL 1.1.1+, currently the 'ssl' module is compiled with 'LibreSSL 2.8.3'. See: https://github.com/urllib3/urllib3/issues/3020

  warnings.warn(

You've downloaded /Users/grapeot/.cookiecutters/devin.cursorrules before. Is it okay to delete and re-download it? [y/n] (y):

  [1/3] project_name (my-project): my-cursor-project

  [2/3] Select project_type

1 - cursor

2 - windsurf

Choose from [1/2] (1):

  [3/3] Select llm_provider [Optional. Press Enter to use None]

1 - None

2 - OpenAI

3 - Anthropic

4 - DeepSeek

5 - Google

6 - Azure OpenAI

Choose from [1/2/3/4/5/6] (1):

Creating virtual environment...

Installing dependencies...

```

配置分为三步：

第一步是输入你要新建的工程的名字。你输入什么名字，它就会在当前文件夹新建一个这个名字的子文件夹，并且在里面进行配置。

第二个是你要选择你的工程类型。目前我们支持Cursor和Windsurf两种编辑器。在这里，因为我们用的是Cursor，所以直接回车选择默认值1就可以了。

第三个是选择LLM Provider。这个是完全可选的一个配置。我们在刚开始使用的时候，可以直接按回车选择None。它只有在使用一些高级功能的时候才需要。我们可以先选择None，等后来使用更熟练，需要使用一些高级功能的时候再回头更改。

接下来，这个脚本就会自动帮我们新建文件夹，配置Python环境。

下面我们可以在命令行中使用cursor my-cursor-project打开我们刚刚新建的工程，就可以正常使用了。

使用工具的例子

从下图所示，这个工具对这个新的Composer工程的使用和一般的Composer工程没有什么差别，只是我们可以直接调用一些额外的工具来让它更好地完成我们的任务。比如说，我们在这里可以在prompt内说 "search recent news on OpenAI"。

另外，再提醒一下，我们要保证我们在Agent模式下，然后点击"submit"。

在这个新配置的文件夹下面，你会发现Cursor开始有了一些额外的能力。比如，它会首先编辑我们的.cursorrules文件进行规划，然后再调用我们的系统引擎文件进行搜索，最终浏览更多的网页并获取最新的信息。
