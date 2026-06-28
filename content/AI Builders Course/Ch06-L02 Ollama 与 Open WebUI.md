---
course: AI Builders：从用户到构建者
chapter: 开源模型与本地化部署（Ollama / Open WebUI）
source: https://www.superlinear.academy/c/ai/sections/443905/lessons/1657491
scraped_at: 2026-06-28
video: false
---

# Ollama 与 Open WebUI

## 我的理解

Ollama 彻底消除了运行开源模型的技术门槛——无需编译、无需写代码，一行命令即可在 Mac/Windows/Linux 上拉取并运行视觉、语言等各类开源模型，同时提供与 OpenAI API 完全兼容的接口，使现有代码只需修改一个参数即可切换至本地推理。Open WebUI 则为 Ollama 提供了媲美 ChatGPT 的图形界面，支持多模型对比、智能自动补全、语音交互和附件上传，让非技术用户也能轻松使用本地 AI。两者的组合标志着开源 AI 工具从"极客专属"走向了普通构建者可以直接上手的实用阶段，在成本与吞吐量敏感的场景（如视频流持续监控）中尤其具有商业价值。

## 相关链接

- [[Ch01-L05 技术洞察 2 GUI 与 API]] — Ollama 提供 API 层、Open WebUI 提供 GUI 层，正是本课所述 GUI/API 双层架构的具体实例
- [[Ch02-L09 自动化的力量 以及生成式 AI 的角色]] — 本地 LLM 无限额调用使高频自动化场景成为可能，与自动化价值主张直接呼应
- [[Ch06-L03 Open WebUI 的配置与功能]] — 下一课详细展开 Open WebUI 的配置选项与商业模型接入等高级功能

---

## 原文

Lesson 46 of 68
Ollama 与 Open WebUI / Ollama and Open WebUI

提到开源工具，我们的第一印象往往是 Linux，甚至是黑客。开源工具似乎要在黑色的终端里运行，由一位光头大叔敲入炫酷的代码才能使用。某种程度上，这种刻板印象是对的。比如 Hugging Face 上的许多开源模型都需要相对复杂的 Python 代码，以及各种依赖的安装。能够在树莓派和 Apple Silicon 上高效进行 LLM 推理的 Llama.cpp，也需要在每个平台上先编译才能使用。这类工具并不是为普通用户设计的，它们需要大量专业操作才能跑起来。即便有 AI 辅助，仅仅让这些工具运行起来也并非易事。

当然，如果所有开源工具都是这样，我们也不会专门用一个模块来介绍它们。本模块介绍两款非常易用而又强大的工具：Ollama 和 Open WebUI。

后端服务：Ollama

Ollama 是一款用于运行开源模型的后端工具。和 llama.cpp 不同，它无需编写代码或编译，可以直接运行。它支持多个平台，包括 Mac、Windows 和 Linux，并能通过 metal 调用 Apple Silicon 的算力。它就像一个普通的应用程序，可以从官方网站下载：https://ollama.com/。

Ollama 主要作为后端服务来支撑前端，我们一般使用 Open WebUI 来提供美观的界面。因此，使用 Ollama 的主要方式是通过命令行和 API 调用。不过，由于它的用法非常简单，这里我们也简要介绍一些基础用法。

在 Ollama 的网站上，你可以直接搜索模型。比如，如果我们想看看 llama 在本地是如何理解图像内容的，可以直接搜索“llama”这样的关键词，进入搜索结果页面 https://ollama.com/search?q=llama。如果我们点击 Llama3.2-Vision，就会进入该模型的主页 https://ollama.com/library/llama3.2-vision，在那里可以看到它的基本信息，包括参数量和许可证。

该页面还提供了一行非常简洁的命令：ollama run llama3.2-vision。安装 Ollama 之后，在终端中运行这条命令，就会自动下载相关的模型文件并加载它们。加载完成后，我们会看到一个聊天提示符，可以直接输入内容，与模型进行对话。

有意思的是，由于我们下载的是一个具备视觉理解能力的模型，它甚至可以非常简单地解读图像。比如在下面的截图中，有一张名为 cat.jpg 的图片，里面其实是一只狗。为什么把一张狗的图片命名为 cat.jpg？这主要是为了防止 LLM 根据文件名来推测图片内容，否则它可能看似理解了图像，实际只是在根据文件名做猜测。

我们的提示词是：“Can you tell me what's in this image?”输入图片的方式也很简单，直接把图片拖拽到命令行窗口里即可。这个动作相当于把图片的路径输入到命令行中。当然，手动复制粘贴路径也可以。按下回车后，Ollama 会调用 Llama 3.2 来分析图片内容并给出回答。在这个例子中，它识别出图片里是一只巧克力色的拉布拉多犬。

这种理解图像的能力在我们的日常工作和生活中会非常有用。比如在我们的 office hours 中提到，它可以基于视频流持续监控并发出告警。然而出于成本考虑，使用商用 LLM 时，我们可能只能做到每分钟一次请求；而使用本地 LLM，如果算力足够，每秒一次请求也是完全可以接受的。

此外，Ollama 提供了与 OpenAI API 完全兼容的 API。因此，所有调用 GPT API 的代码，只需修改一行代码就可以切换为调用 Ollama。具体来说，在创建 OpenAI 对象时，加上参数 base_url='http://localhost:11434/v1' 即可。其他代码无需任何改动。

前端界面：Open WebUI

当然，Ollama 仅仅是一个用于 LLM 推理的后端工具，通过命令行使用并不能带来良好的用户体验。这里我们推荐使用一个图形界面——Open WebUI。它是一个基于网页的用户界面，与 ChatGPT 类似，在某些方面甚至更胜一筹。

Open WebUI 的安装配置非常简单，这里我们推荐使用 Docker 进行安装。Docker 应用可以从官方网站下载：https://www.docker.com/。安装好 Docker 之后，运行一行命令基本就能启动一个本地的 OpenWebUI 实例。该命令可以在 Open WebUI 的官方文档页面找到：https://docs.openwebui.com/getting-started/quick-start。在实验性安装中，我们建议使用“Single-User Mode (Disabling Login)”模式。Docker 容器启动后，访问 http://localhost:3000/ 就能看到其图形界面。

下面的截图展示了一个使用 Open WebUI 进行对话的实例。可以看到，它的界面与 ChatGPT 非常相似。在网页的左上角可以选择模型，展开会话管理子菜单后，我们可以像在 ChatGPT 中一样查看历史会话和标题。此外，它还支持图片和附件，我们可以通过点击左下角的加号按钮，或者直接拖拽来上传图片或其他文件；右下角可以看到一个麦克风图标，这说明它也支持语音识别、文本转语音以及语音对话模式。



仔细观察截图底部的对话输入框，我们可以发现它有一个独特的功能——智能自动补全。这一功能在 ChatGPT 中是没有的，它会根据你输入的内容建议后续文本。Open WebUI 还有许多类似的实用功能，我们将在下一节课中详细介绍。

English Original

When it comes to open-source tools, our first impression is often Linux or even hacking. Open-source tools might work on a black terminal with a bald-headed guy typing cool code to use them. To some extent, this stereotype is correct. For example, many open-source models on Hugging Face require relatively complex Python code, and the installation of various dependencies. Llama.cpp, which can efficiently perform LLM reasoning on Raspberry Pi and Apple Silicon, also needs to be compiled on each platform before use. Such tools are not designed for ordinary users. They require a lot of specialized operations to get them running. Even with AI assistance, just getting these tools up and running is no easy task.

Of course, if all open-source tools were like this, we wouldn't have dedicated a module to introducing them. This module introduces two very user-friendly yet powerful tools: Ollama and Open WebUI.

Backend Service: Ollama

Ollama is a backend tool for serving open-source models. Unlike llama.cpp, it doesn't require coding or compiling and can run directly. It supports multiple platforms, including Mac, Windows, and Linux, and can invoke Apple Silicon's computing power through metal. It's like a normal app that you can download from the official website https://ollama.com/.

Ollama is primarily used as a backend service to support the frontend, and we generally use Open WebUI to provide a visually appealing interface. Therefore, the main way to use Ollama is through command-line and API calls. However, because its usage is very simple, we also briefly introduce some basic uses here.

On Ollama's website, you can directly search for models. For example, if we want to see how llama understands image content locally, we can directly search for a keyword like "llama", which will take us to a search result page https://ollama.com/search?q=llama. If we click on Llama3.2-Vision, we'll enter the model's homepage https://ollama.com/library/llama3.2-vision, where we can see basic information about it, including the number of parameters and licenses.

On this page, it also provides a very simple command line: ollama run llama3.2-vision. After installing Ollama, running this command in the terminal will automatically download the related model files and load them. After loading is complete, we'll see a chat prompt, and we can directly input to converse with the model.

One interesting aspect is that since we are downloading a model with visual understanding capabilities, it can even interpret images in a very simple way. For example, in the screenshot below, there is an image named cat.jpg, which actually contains a dog. Why do we name a picture of a dog as cat.jpg? This is mainly to prevent the LLM from speculating about the content of the image based on the file name, which might make it appear as if it understands the content when it's actually just making guesses based on the file name.

Our prompt is: "Can you tell me what’s in this image?" The method for inputting the image is also very simple; you can just drag and drop the image into the command-line window. This action is equivalent to typing the path of the image into the command line. Of course, manually copying and pasting the path will work as well. After pressing Enter, Ollama will call Llama 3.2 to analyze the content of the image and provide a response. In this case, it identified that the image shows a chocolate Labrador.

This ability to understand images can be very helpful in our daily work and life. For example, as mentioned during our office hours, it can continuously monitor and alert based on video feeds. However, due to cost considerations, when using commercial LLMs, we might only be able to make one request per minute; but with a local LLM, if the computational power is sufficient, making a request once every second is also quite acceptable.

Additionally, Ollama provides APIs that are fully compatible with OpenAI’s API. Therefore, all code that calls the GPT API can switch to calling Ollama by simply changing one line of code. Specifically, when creating an OpenAI object, add the parameter base_url='http://localhost:11434/v1'. No other changes to the code are necessary.

Frontend Interface: Open WebUI

Of course, Ollama is just a backend tool for LLM reasoning, and using it through the command line doesn't provide a good user experience. Here, we recommend using a graphical interface - Open WebUI. It's a web-based user interface similar to ChatGPT, even exceeding it in some aspects.

The installation configuration of Open WebUI is very simple, and here we recommend using Docker for installation. The Docker app can be downloaded from the official website https://www.docker.com/, and after installing Docker, running one line of command can basically run a local OpenWebUI instance. This command can be found on Open WebUI's official documentation page https://docs.openwebui.com/getting-started/quick-start. For experimental installations, we suggest the "Single-User Mode (Disabling Login)" mode. After starting the Docker container, accessing http://localhost:3000/ will show its graphical interface.

The following screenshot shows an instance of chatting with Open WebUI. We can see that its interface is very similar to ChatGPT. In the upper left corner of the web page, you can choose models, and after expanding the conversation management submenu, we can view historical conversations and titles like ChatGPT. Additionally, it also supports images and attachments; we can upload images or other files by clicking on the plus sign in the lower left corner or drag and drop; and in the lower right corner, we can see a microphone icon, which means it also supports voice recognition, text-to-speech, and chat mode.



Inspecting the chat dialogue box in the bottom of the screenshot closely, we can see that there is a unique feature which is intelligent auto-completion. This function is not available in ChatGPT and suggests subsequent content for your input words. Open WebUI has many more practical features like this, which will be introduced in detail in the next lesson.
