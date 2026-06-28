---
course: AI Builders：从用户到构建者
chapter: 开源模型与本地化部署（Ollama / Open WebUI）
source: https://www.superlinear.academy/c/ai/sections/443905/lessons/1657493
scraped_at: 2026-06-28
video: false
---

# Open WebUI 的配置与功能

## 我的理解

Open WebUI 不仅仅是开源模型的前端——它同样可以接入 GPT 和 Claude 的商业 API，相比直接使用 ChatGPT 网页版，在合规性（API 输入不用于模型训练）和成本（自动享受 API 持续降价红利）上均有显著优势。它还支持多模型并排对比、历史会话全文检索、语音识别与文本转语音（可选纯本地模型），以及类似 Claude Artifacts 的代码侧边栏渲染，功能丰富程度超过大多数商业产品。这种"一站式 AI 入口"思路让所有数据可选择性地留在本地或内网，为企业级部署提供了可行的合规路径，即便不使用任何开源模型也具有独立价值。

## 相关链接

- [[Ch01-L05 技术洞察 2 GUI 与 API]] — 本课详细说明了通过 API 接入商业模型相比网页版 GUI 在合规与成本上的具体优势
- [[Ch02-L02 研究 LLM内部机制 记忆知识上下文]] — 理解 LLM 内部机制有助于判断 Open WebUI 多模型配置时各模型的能力边界
- [[Ch06-L04 无需写代码 搭建完全本地化的 RAG]] — 下一课以 RAG 为例深入演示 Open WebUI 灵活配置在实际场景中的价值
- [[Ch08-L08 把 Cursor 作为通用 AI 入口]] — Cursor 与 Open WebUI 都尝试成为统一的 AI 入口，两者定位与思路可相互印证

---

## 原文

Lesson 47 of 68
Open WebUI 的配置与功能 / Configuration and Features of Open WebUI

在上一节课中，我们完成了 Open WebUI 的配置。它的基本界面与 ChatGPT 或 Claude 类似，可以让你与 AI 进行对话并获得回复。然而，经过多年的发展，像 ChatGPT 这样的产品早已超越了简单的聊天功能。例如，你可以进行语音对话、上传文件做 RAG、联网搜索等等。Open WebUI 是否也提供类似的全面功能？答案是肯定的。它不仅涵盖了 ChatGPT 和 claude.ai 中常见的功能，还提供了更加丰富、灵活且高度可定制的扩展能力。

由于篇幅有限，我们无法在本节课中覆盖所有功能。我们将通过几个典型示例，演示一些常用功能的配置与使用方式。如果你需要针对自己的应用场景探索具体用法，无论是分享 Open WebUI 的使用经验，还是排查问题，动手实践通常都是最高效的方法。当然，与其他模块一样，如果你在阅读和学习本节课时遇到任何问题，欢迎在社区中讨论。

使用商业模型

虽然我们配置和使用 Open WebUI 的初衷是为了利用开源模型，但该工具本身并不限制只能使用开源模型。事实上，我们仍然可以将 GPT 和 Claude 接入 Open WebUI。在 Admin Panel 的设置部分（Admin Panel => Connections），你会看到与 OpenAI API 相关的选项。由于 OpenAI 的 API 格式已成为业内事实上的标准，许多本地推理工具也实现了相同的 API 接口，例如 llama.cpp 和 vLLM。因此，它们也可以通过这些接口与 Open WebUI 对接。





在上面的截图中，我们提供了两个示例。在“Manage OpenAI API Connections”部分，第一行是 OpenAI 的官方 API 端点，你只需在此粘贴自己的 OpenAI API Key 即可。第二行是本地 vLLM 服务器的配置示例，你可以调用运行在本地网络中的 vLLM 服务进行推理。

需要注意的是，OpenAI API 与 ChatGPT 的账号是分开的。你不需要付费版的 ChatGPT 也可以使用 OpenAI 的 GPT API；反过来，即便你已经订阅了付费版的 ChatGPT，也并不会自动获得 GPT API 的访问权限，仍需单独申请。关于如何申请该 API，请参考我们第二模块练习课中的相关视频。

配置好 OpenAI 连接后，就可以开始使用了。在聊天界面左上角的模型下拉列表中，你会看到 GPT 相关的模型。如果你还使用了其他本地模型，也会在该列表中看到自己的私有模型。

接入 Claude 稍微复杂一些，主要因为 Claude 的 API 格式与 OpenAI 不兼容。不过配置同样很简单。你只需从以下地址下载一个插件即可：https://openwebui.com/f/justinrahb/anthropic。如下图所示，启用该插件，点击齿轮图标后输入你的 Claude API Key，刷新页面后，你就会在模型列表中看到 Claude 相关的模型。



一个有趣的用法如下面的截图所示：我们可以混合使用多种私有或开源模型。与 ChatGPT 类似，在使用 Open WebUI 进行对话时，你可以使用 @ 符号召唤当前未在列表中的 AI；或者在选择模型时点击加号以选中多个模型。如图所示，这样可以方便地比较不同模型对同一问题的回答。






除了带来更便捷的使用体验外，通过 Open WebUI 接入 GPT 或 Claude 还有两点额外的好处：

1. 法律与合规优势：ChatGPT 和 claude.ai 等面向普通用户的产品，其用户协议通常允许厂商收集用户数据用于模型训练，且数据保留期限通常更倾向于厂商一方，这可能带来合规方面的挑战。而 API 的使用条款和数据保留政策更接近 ChatGPT Enterprise 等企业级产品：API 的输入不会被用于模型训练，数据保留期限也更为严格。因此从合规角度看，这种方式非常有价值。

2. 成本优势：自 OpenAI 发布 GPT 以来，随着技术进步，成本已大幅下降。根据 OpenAI 自己的统计，在 GPT-4 发布后的一年内，最新模型的 API 成本已降至最初价格的 1%。因此，通过 API 接入模型可以自动享受这些成本红利。而如果你使用 ChatGPT 这样的产品，无论是标准版还是企业版，价格始终维持不变。

因此，无论是从合规还是成本角度看，即便我们使用 Open WebUI 的目的并非接入开源模型，而仅仅是为了集成商业模型，使用这一 Web GUI 仍然是一个非常有吸引力的选择。

搜索、语音与代码

Open WebUI 的另一个非常实用的功能是搜索。使用 ChatGPT 或 Claude 时的一大痛点是缺乏搜索功能：如果你之前问过某个问题，现在想分享给朋友或重新回顾，要再找到这条对话往往相当麻烦。而如下面的截图所示，Open WebUI 提供了一个非常实用的搜索功能。你可以直接在左侧的搜索框中输入关键词，相关的对话就会出现在搜索结果中。虽然目前的搜索还不是基于语义的，而只是简单的文本匹配，但相比商业产品，已经非常有帮助。





此外，Open WebUI 还支持语音交互功能，包括语音识别、文本转语音，以及类似 ChatGPT 移动版的对话模式。除了功能多样之外，更重要的是它支持灵活的自定义。如下面的截图所示，在语音相关的控制面板中，你可以选择使用哪些模型来进行语音识别和文本转语音。除了传统的 OpenAI API，你还可以选择使用本地模型来完成这些任务。这些模型的表现相当出色：速度快、识别准确，语音输出的自然度也尤为出色，尤其是英文。



因此，在语音能力方面，Open WebUI 不仅可以与 ChatGPT 的功能相媲美，还能支持完全使用本地模型的对话模式，让我们直接以语音方式与 AI 交互。当然，这种体验是否足够流畅，取决于本地的计算资源。整体而言，Open WebUI 的语音能力与 ChatGPT 相当，并且允许我们完全使用本地模型进行处理。

在代码编写方面，Open WebUI 也提供了类似 ChatGPT 的 GPT Canvas 和 Claude Artifacts 的功能。当 AI 生成 Python 或前端 HTML 代码时，会自动弹出一个侧边栏对代码进行渲染。用户可以在该侧边栏中编辑、保存并运行代码。这一功能特别适合数据分析和前端开发等任务，方便我们进行迭代式的代码工作。

以上对 Open WebUI 中一些常用功能进行了简要介绍。现代 AI 产品早已不再是简单的聊天工具，而是提供了高度复杂的能力。然而，Open WebUI 的功能丰富程度无疑使其在同类产品中脱颖而出。除了功能丰富之外，Open WebUI 还提供灵活的自定义能力，可以让所有数据完全保留在你的本地机器或本地网络中。这对企业级应用而言至关重要。

在下一节课中，我们将以 RAG（检索增强生成）为例，详细探讨这种灵活性能够为我们带来哪些价值。

English Original

In the last lesson, we configured Open WebUI. Its basic interface looks similar to ChatGPT or Claude, allowing you to chat and receive AI responses. However, after years of development, products like ChatGPT have evolved far beyond simple chat functions. For example, you can engage in voice conversations, upload files for RAG, search the web, and more. Does Open WebUI offer similar comprehensive features? The short answer is yes. It not only covers the common features found in ChatGPT and claude.ai, but also provides even richer, more flexible, and highly customizable additional features. 

Due to space limitations, we cannot cover all the features in this lesson. Instead, we will demonstrate a few typical examples of configuring and using some commonly used features. If you need to explore specific use cases for your own application, whether it's sharing experiences with Open WebUI or troubleshooting issues, hands-on practice is often the most efficient method. However, same as other modules, if you encounter any problems while reading and learning this lesson, feel free to discuss them in the community.

Using Commercial Models

While our purpose in configuring and using Open WebUI is to leverage open-source models, the tool itself does not restrict its use to only those models. In fact, we can still integrate GPT and Claude into Open WebUI. In the settings section of the Admin Panel (Admin Panel => Connections), you will see options related to the OpenAI API. Since the API format from OpenAI has become a de facto standard in the industry, many local inference tools have also implemented the same API interface, such as llama.cpp and vLLM. Therefore, they can also connect with Open WebUI through these interfaces.





In the screenshot above, we provide two examples. In the "Manage OpenAI API Connections" section, the first row is the official API endpoint of OpenAI. Here, you just need to paste your OpenAI API Key. The second row is a local configuration for a vLLM server. You can call the vLLM service running on your local network for inference.

It's important to note that the accounts for the OpenAI API and ChatGPT are separate. You can use the OpenAI GPT API without having a paid version of ChatGPT, or even if you have a paid subscription to ChatGPT, it does not automatically grant you access to the GPT API; you still need to apply for it separately. For information on how to apply for this API, please refer to the related video in our Module 2 exercise sessions. 

After configuring the OpenAI connection, you can start using it. In the model dropdown list at the top left corner of the chat panel, you will find models related to GPT. If you are using other local models, you can also find your private models there.

Connecting to Claude is a bit more complex, primarily because Claude's API format is not compatible with OpenAI's. However, this configuration is also quite straightforward. You just need to download a plugin from this URL: https://openwebui.com/f/justinrahb/anthropic. As shown in the screenshot below, enable this plugin and enter your Claude API Key after clicking on the gear icon. After refreshing the page, you will see models related to Claude appear in the list.



One interesting use case, as shown in the screenshot below, is that we can mix multiple private or open-source models. Similar to ChatGPT, during the conversation using OpenWeb UI, you can use the @ symbol to summon AIs that are not currently in the list. Alternatively, when selecting a model, you can click the plus sign to choose multiple models. As shown in the figure, this allows for easy comparison of different models' responses to the same question.






In addition to a more convenient user experience, there are two additional benefits to using OpenWeb UI to connect to GPT or Claude:

1. Legal and Compliance Benefits: Products like ChatGPT and claude.ai, which are designed for general users, typically have user agreements that allow companies to collect user data for training purposes. Additionally, the data retention period is often more favorable to the company, which can pose compliance challenges. However, the terms of use and data retention policies for APIs are similar to those of enterprise-level products like ChatGPT Enterprise: inputs to the API are not used for model training, and the data retention period is more stringent. Therefore, this approach is very valuable from a compliance perspective.

2. Cost Benefits: Since OpenAI released GPT, with advancements in technology, the cost has dropped significantly. According to OpenAI's own statistics, within one year of the release of GPT-4, the API costs for the latest model have decreased to just 1% of the initial price. Therefore, connecting to models via API allows you to automatically benefit from these cost reductions. However, if you use products like ChatGPT, whether in the standard or enterprise version, the prices remain unchanged. 

Thus, from both a compliance and cost perspective, even if our purpose in using Open WebUI is not to connect with open-source models but rather to integrate commercial models, using this Web GUI remains a very attractive option.

Search, Voice, and Code

Another very useful feature of OpenWebUI is its search. One significant pain point when using ChatGPT or Claude is the lack of a search feature. If you previously asked a question and now want to share it with a friend or just revisit it, it can be quite challenging to find it again. However, as demonstrated in the screenshot below, OpenWebUI provides a quite useful search feature. You can directly enter keywords into the search box on the left, and relevant conversations will appear in the search results. While this search is currently not semantic-based but rather a simple text match, it is still very helpful compared to commercial tools.





Additionally, OpenWebUI supports voice interaction features. It includes speech recognition, text-to-speech, and a chat mode similar to the mobile version of ChatGPT. Beyond its diverse featrues, what's more important is its support for flexible customization. As shown in the screenshot below, in the voice-related control panel, you can choose which models to use for speech recognition and text-to-speech. Besides the traditional OpenAI API, you can also opt to use local models for these tasks. The performance of these models is quite impressive: they are fast, accurate, and the naturalness of the spoken output is particularly noteworthy, especially for English.



Therefore, in terms of voice capabilities, Open WebUI not only matches the functionality of ChatGPT but can also support chat modes using entirely local models, allowing us to directly engage in voice conversations with AI. Of course, whether this experience is sufficiently smooth depends on the local computing resources. Overall, OpenWebUI's voice features are on par with those of ChatGPT, and it allows us to use entirely local models for processing.

In terms of code writing, Open WebUI also offers functionalities similar to those found in ChatGPT, such as GPT Canvas and Claude Artifacts. When AI generates Python or front-end HTML code, a sidebar automatically pops up where the code is rendered. Users can edit, save, and run the code within this sidebar. This makes it particularly suitable for data analysis and front-end development tasks, facilitating iterative code work.

These introductions provide a brief overview of some of the more commonly used features in Open WebUI. Modern AI products have long moved beyond being simple chat tools; they offer highly complex functionalities. However, the richness of OpenWebUI's features undoubtedly sets it apart from similar products. Beyond its extensive feature set, OpenWebUI also offers flexible customization, providing an option where all data remains on your local machine or within your local network. This is crucial for enterprise-level applications.

In the next lesson, we will use RAG (Retrieval-Augmented Generation) as an example to explore in detail how this flexibility can benefit us.
