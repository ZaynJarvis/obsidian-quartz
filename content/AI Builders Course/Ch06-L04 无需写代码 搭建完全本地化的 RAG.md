---
course: AI Builders：从用户到构建者
chapter: 开源模型与本地化部署（Ollama / Open WebUI）
source: https://www.superlinear.academy/c/ai/sections/443905/lessons/1657494
scraped_at: 2026-06-28
video: false
---

# 无需写代码，搭建完全本地化的 RAG

## 我的理解

Open WebUI 让搭建企业级 RAG 变得唾手可得：选择 Ollama 作为 Embedding 引擎，拉取 bge-m3 等开源嵌入模型，上传文件或建立知识库，整个流程无需一行代码且数据完全不离开本地，直接解决了公司内部敏感文档无法上传公网服务的合规痛点。在性能调优层面，Open WebUI 支持混合检索与重排序（如 bge-reranker-v2-m3），并提供对召回数量、相关性阈值和 Prompt 模板的精细控制，这是商业 RAG 一锤子买卖式方案难以实现的定制深度。这种可评估、可迭代的本地 RAG 原型，正是技术决策者在正式上线前进行技术可行性验证的理想工具，也为同类场景（语音、图像生成等）的配置逻辑提供了可复用的学习范式。

## 相关链接

- [[Ch07-L07 我们为什么不教 RAG 对其原理与未来的深入思考]] — 本课是 RAG 的无代码实战实现，Ch07 从原理层面深入讨论 RAG 局限性，两者构成完整认知闭环
- [[Ch02-L02 研究 LLM内部机制 记忆知识上下文]] — Embedding 与检索机制建立在 LLM 处理上下文和知识的基本原理之上
- [[Ch04-L06 学习 2 面向 AI 的文档管理]] — 面向 AI 的文档管理是 RAG 知识库建设的前提，两课在工作流上高度互补
- [[Ch04-L05 第二步 探索技术可行性]] — 本课的本地 RAG 快速搭建正是验证 RAG 技术可行性的典型操作路径

---

## 原文

Lesson 48 of 68
无需写代码，搭建完全本地化的 RAG / Implementing a Fully Local RAG Without Coding

在本节课中，我们将探索如何借助 OpenWebUI，仅通过几次点击就构建出一套高级、完全本地化的 RAG。考虑到部分学员可能对 RAG 还不熟悉，我们先从背景介绍说起。很多时候，我们希望 AI 能基于我们自己的文档或知识进行问答，而不是只依赖公开可得的现有知识。例如，如果我们想构建一个客服机器人，可以把产品手册和过往的服务工单提供给 AI，让它基于这些文档进行更个性化、更准确的对话。在加餐模块中，我们会深入剖析 RAG 的优劣。但要真正判断这一具体技术是否适合我们的业务场景，就需要使用真实数据搭建一套 RAG 系统，并进行评估、测试和对比。

然而，许多时候公司内部文档存在保密或合规限制，无法发送到公网版本的 ChatGPT 等服务上，给产品评估带来不便。这意味着我们无法直观地把握 RAG 技术的优势和劣势，也无法明确它对我们的具体收益，从而阻碍了合理的技术决策。

所幸 OpenWebUI 解决了这一痛点。它让你无需编写任何代码，就能搭建一套完整且完全本地化的 RAG 方案，几分钟内就可以构建起来用于测试和评估。本节课我们将以 RAG 为例，讲解 OpenWebUI 的基本配置流程。希望帮助有需要的同学举一反三，更轻松地探索其他应用，如语音识别、网页搜索、图像生成等。

配置

在进入具体配置之前，我们需要了解 RAG 的基本技术流程。RAG 的核心是 Embedding。Embedding 的基本思想是：对于文档的每一块（chunk），例如每 1000 个词，用一个数学向量来描述这一小块的内容。对于任意两个 chunk，如果它们的内容更相关，那么它们的 Embedding 向量之间的距离就更近；反之，如果内容不相关，提取出的 Embedding 之间的距离就更远。因此，通过直接比较 Embedding 向量之间的距离，我们就可以找到与用户问题最相关的文档片段。接着，将这些相关片段在后台加入到 prompt 中，这就是 RAG 的基本工作流程。

RAG 的功能配置同样围绕 Embedding 模型展开。具体设置位置在 Admin Panel → Settings → Documents。下图展示了一个示例配置页面。

如果公司允许将数据发送到外网，我们可以为 Embedding Model Engine 选择 OpenAI。它的配置和上一节课所讲相同，只需粘贴 OpenAI API Key 即可使用。

如果你希望配置完全本地化的 RAG 工作流，则需要在这里选择 Ollama。默认的 API 路径指向本地运行的 Ollama。如果你使用的是非本地的 Ollama 后端，可以在这里粘贴具体地址。

这里我们使用的 Embedding 模型可以直接在线下载。例如，一个非常流行的 Embedding 模型是 bge-m3：https://huggingface.co/BAAI/bge-m3。根据基准测试，它在检索方面的表现优于 OpenAI 的 Embedding 模型。在 Ollama 上，它也有自己的模型页：https://ollama.com/library/bge-m3。在本地运行 ollama pull bge-m3，即可将模型下载到本机。再结合本地运行的 LLM，就能确保数据始终不离开本地环境。

我们可以在 Embedding model 选项中输入 bge-m3:latest，并点击页面底部的 Save 应用更改。如果你只想在本地测试默认配置，到这一步配置就完成了。接下来，我们先看一下如何使用 RAG 功能进行问答。然后，对感兴趣的同学，我们会再回过头来看如何进行更细致的配置和性能调优。

使用

调用 RAG 功能非常简单。完成配置后，在聊天界面中点击加号按钮上传一个或多个文件，并直接通过 prompt 针对文件内容进行提问。按下回车后，OpenWebUI 会执行三个动作：

1. 调用 Embedding 模型：调用已下载的 Embedding 模型来提取 Embedding。

2. 比较 Embedding 向量：通过比较用户问题的 Embedding 与文档库及上传文件中各个 chunk 的 Embedding，识别出与用户问题相关的文档片段。

3. 构造 Prompt：将这些片段与用户问题组合在一起，按一定模板重新构造 prompt，从而让 RAG 能够基于用户上传的文档给出有针对性的回答。

在这一过程中，RAG 生成回答之后，如上图所示，OpenWebUI 还会在页面底部提供具体的来源（sources）。我们可以点击具体的来源以了解更多信息，例如该文档与用户问题的相关程度，查看文档内容，或在该页面下载文档进行进一步检查。

不过，这种用法存在一个问题：每次生成回答时都需要先提取 Embedding，再检索相关文档片段，最后生成回答。在许多场景下，我们的文档是静态的、不会变化，因此每次提取出的 Embedding 都是相同的，这就是一种浪费。在这种情况下，我们希望复用已上传的文档，把提取出的 Embedding 存储下来，未来生成时就不必重新计算。

这一思路对应的就是 OpenWebUI 中的知识库（knowledge base）概念。它可以在聊天界面左上角的 Workspace → Knowledge 中进行管理。在知识库管理界面，我们可以点击加号按钮新建一个知识库，然后将文件拖入其中。系统会自动导入这些文件，批量提取 Embedding 并建立索引。

例如在上面的截图中，我们演示了新建一个名为“blog”的知识库，其内容是从 https://yage.ai/ 导入而来的。在聊天过程中，我们可以使用 # 调出一个对话框，在其中引用某个具体文件或直接引用整个知识库。引用之后，所提问题就会基于这个知识库来回答。

如果你不想每次都用快捷键来调出该对话框，也可以使用 Workspace 的 Model 功能。它仍然使用与上面相同的配置界面，但我们要进入 Models 选项卡而不是 Knowledge 选项卡。其配置界面如下图所示。这是一个非常灵活的工具，我们可以自定义一个个性化模型，为它预设一些背景知识和能力。对于我们当前的具体应用，最关键的部分是图中红框标出的配置项，即知识库的选择。在选择我们之前配置好的知识库后，使用该模型聊天时就会默认引用所选知识库，这在客服机器人等场景中非常有用。

性能调优

如果你对 RAG 生成的质量不满意，OpenWebUI 提供了强大的自定义能力，可进行更细致、更灵活的调整。这里我们回到之前的配置界面，如下图所示。其中，Hybrid Search 是一种针对大规模数据的优化方法。

一些背景知识：现代搜索引擎通常将搜索过程分为两个步骤，一个称为 Retrieval（召回），一个称为 Ranking（排序）。Retrieval 步骤主要在大规模文档库上执行较粗粒度的检索操作。例如整个文档库可能有几十万甚至上百万篇文档，这一步会过滤掉所有不相关的内容，只留下几千或几百篇文档。

而 Ranking 步骤则使用更昂贵的机器学习模型和更复杂的特征，对这些文档做进一步处理，最终筛选出几十篇真正相关的文档。通过两者的结合，现代搜索引擎能够在大规模数据上既快速又精准地完成处理。

对于 RAG 中的具体应用而言，由于我们前面已经配置好了 Embedding 模型，这里可以直接使用一些已有的重排序（re-ranking）模型，例如 baai/bge-re-ranker-v2-m3。输入该模型名称后，只需点击右侧的下载按钮，OpenWebUI 就会自动下载模型。下载时间取决于网速，可能需要几分钟。下载完成后会弹出提示框，告知模型已可使用。此时即可保存设置并进行更多测试。

页面底部还有其他相关参数，包括：

- 在 Retrieval + Reranking 阶段需要检索多少文档；

- 是否需要满足一定的相关性分数；

- 使用什么样的模板来生成 prompt 等。

这里不再详细展开，感兴趣的同学可以自行探索。

最后需要指出的是，OpenWebUI 的 RAG 功能不仅有图形界面，还提供了 API。这对于自动化评估 RAG 的效果、进行性能调优，或在评估之后将其集成到实际产品中都非常有用。当然，这部分涉及 API 的使用，需要写代码。感兴趣的同学可以参考其技术文档 https://docs.openwebui.com/getting-started/api-endpoints/，并借助 AI 加速开发。

English Original

In this lesson, we will explore how to create an advanced, entirely local RAG using OpenWebUI with just a few clicks. Considering that some students may not be familiar with RAG, we'll begin with a background introduction. Often, we want AI to perform Q&A based on our own documents or knowledge, rather than relying solely on publicly available, existing knowledge. For example, if we want to create a customer service robot, we can provide the product manuals and past service tickets to the AI, allowing it to engage in more personalized and accurate conversations based on these documents. In the bonus module, we will thoroughly analyze the pros and cons of RAG. However, to truly understand whether this specific technology is suitable for our business scenarios, we need to use actual data to build a RAG system, and conduct evaluations, tests, and comparisons.

However, many times, internal company documents have confidentiality or policy restrictions that prevent them from being sent to public versions of ChatGPT and similar services, making product evaluations inconvenient. This means we cannot intuitively grasp the strengths and weaknesses of RAG technology or understand its exact benefits for us, thereby hindering reasonable technical decision-making.

Fortunately, OpenWebUI addresses this pain point. It allows you to set up a complete and entirely local RAG solution without writing any code, making it easy to build within minutes for testing and evaluation. In this lesson, we will use RAG as an example to explain the basic configuration process of OpenWebUI. We hope to help those in need draw analogies and more easily explore other applications, such as voice recognition, web search, image generation, and more.

Configuration

Before diving into specific configurations, we need to understand the basic technical workflow of RAG. The core of RAG is Embedding. The fundamental idea of Embedding is that for each chunk of a document, such as every 1,000 words, a mathematical vector is used to describe the content of that small chunk. For any two chunks, if their content is more related, the distance between their Embedding vectors will be closer; conversely, if their content is unrelated, the distance between their extracted Embeddings will be farther apart. Therefore, by directly comparing the distances between Embedding vectors, we can find the document chunks most relevant to the user's question. Next, these relevant chunks are added to the prompt in the background, which is the basic workflow of RAG.

The functional configuration of RAG also revolves around the Embedding model. The specific location for settings is in Admin Panel → Settings → Documents. The image below demonstrates an example configuration page.

If the company allows data to be sent to external networks, we can choose OpenAI for the Embedding Model Engine. Its configuration is the same as explained in the previous lesson; simply paste the OpenAI API Key to use it.

If you wish to configure a fully local RAG workflow, you need to select Ollama here. The default API path points to the locally running Ollama. If you are using a non-local Ollama backend, you can paste the specific address here.

Here, the Embedding model we use can be directly downloaded online. For example, a very popular Embedding model is bge-m3: https://huggingface.co/BAAI/bge-m3. According to benchmarks, it performs better in retrieval than OpenAI's Embedding models. On Ollama, it also has its own model page: https://ollama.com/library/bge-m3. By running ollama pull bge-m3 locally, you can download the model to your machine. Combined with a locally running LLM, this ensures that the data never leaves the local environment.

We can enter bge-m3:latest into the Embedding model option and click Save at the bottom of the page to apply the changes. If you just want to test the default configuration locally, the configuration is complete at this step. Next, we'll first look at how to use the RAG feature for Q&A. Then, for those interested, we will revisit how to perform more detailed configurations and performance tuning.

Usage

Invoking the RAG feature is very simple. After completing the configuration, in the chat interface, we can click the plus button to upload one or more files and directly use prompts to ask questions about the file content. Upon pressing Enter, OpenWebUI will perform three actions:

1. Invoke the Embedding Model: it calls the downloaded Embedding model to extract Embeddings.

2. Compare Embedding Vectors: By comparing the Embedding of the user's question with the Embeddings of different chunks in the document library and uploaded files, we identify the document chunks associated with the user's question.

3. Construct the Prompt: These chunks and the user's question are combined together, following a certain template to reconstruct the prompt, thereby enabling RAG to provide targeted answers based on the user's uploaded documents.

In this process, after RAG generates a response, as shown above, OpenWebUI will also provide specific sources at the bottom of the page. We can click on a specific source to learn more information, such as how relevant this document is to the user's question, view the document's content, or download the document from this page for further inspection.

However, this usage has a problem: each time an answer is generated, it requires extracting Embeddings first, then retrieving relevant document fragments, and finally generating the response. In many scenarios, our documents are static and do not change, so the extracted Embeddings are always the same each time, which is a waste of time. In such cases, we want to reuse the uploaded documents by storing the extracted Embeddings, so that they do not need to be recalculated during generation in the future.

This idea is the concept of a knowledge base within Open WebUI. It can be managed in the chat interface at the top left corner under Workspace → Knowledge. In the knowledge base management interface, we can click the plus button to create a new knowledge base, and then drag files into it. It will automatically import these files, perform batch Embedding extraction, and index them.

For example, in the screenshot above, we demonstrated creating a new knowledge base named "blog," which was generated by importing content from https://yage.ai/. During a chat, we can use # to bring up a dialog box, where you can reference a specific file or directly reference the entire knowledge base. After referencing, the questions we ask will be answered based on this knowledge base.

If you don’t want to use the shortcut key to bring up this dialog box every time, you can also use the Workspace’s Model feature. It still uses the same configuration interface as above, but we will enter the Models tab instead of the Knowledge tab. Its configuration interface is shown in the figure below. This is a very flexible tool where we can customize a personalized model, giving it some pre-set background knowledge and capabilities. For our specific application, the most critical part is the configuration option highlighted in the red rectangle, which is the selection of the knowledge base. After selecting the knowledge base we configured earlier, when chatting with this model, it will by default reference the selected knowledge base, which is very useful in scenarios such as customer service robots.

Performance Tuning

If you are not satisfied with the quality of the RAG generation, Open WebUI provides powerful customization for more detailed and flexible adjustments. Here we come back to the previous configuration interface, as shown in the figure below. Among them, Hybrid Search is a method for optimizing large-scale data.

Some background knowledge: modern search engines often divide the search process into two steps: one called Retrieval, and one called Ranking. The Retrieval step mainly performs a rough retrieval operation on a large-scale document library. For example, the entire document library may have hundreds of thousands or even millions of documents. It will filter out all irrelevant content, leaving only a few thousand or a few hundred documents.

The Ranking step, on the other hand, uses more expensive machine learning models and more complex features to further process these documents, and finally select a few dozen truly relevant documents. Through the combination of these two, modern search engines can perform both fast and accurate processing on large-scale data.

For specific applications in RAG, since we have already configured the Embedding model earlier, we can directly use some existing re-ranking models here, such as baai/bge-re-ranker-v2-m3. After entering this model name, simply click the download button on the right, and OpenWebUI will automatically download the model. The download time depends on the internet speed and may take a few minutes. Once the download is complete, a notification box will pop up, informing us that the model is ready to use. At this point, you can save the settings and conduct more tests.

At the bottom of the page, there are other related parameters, including:

- How many documents we need to retrieve during the Retrieval + Reranking phase;

- Whether a certain level of relevance score needs to be met;

- What kind of template should be used to generate the prompt, etc.

These will not be elaborated here; interested students can explore further.

Finally, it is important to note that OpenWebUI's RAG feature not only has a graphical interface but also provides an API. This is very useful for automating the evaluation of RAG's effectiveness, performance tuning, or integrating into actual products after evaluation. Of course, this part involves using APIs, so coding is required. Students who have interest can refer to its technical documentation https://docs.openwebui.com/getting-started/api-endpoints/ and use AI to accelerate development.