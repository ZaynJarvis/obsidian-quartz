---
course: AI Architects
chapter: Phase A — 构建最小化 Agentic AI 系统
source: https://www.superlinear.academy/c/aa/sections/812393/lessons/3089121
scraped_at: 2026-06-27
video: false
---

# 用 Agentic 工具扩展能力

## 我的理解

这是 Phase A 的核心课程，实现从 Chatbot 到 Agent 的跨越。关键概念是 Agentic Loop：LLM 自身不能执行工具，它只生成 Tool Call 请求，由你的代码检测并执行，再把结果喂回 LLM，LLM 据此决定是输出最终答案还是继续探索。实践分三步走——先定义搜索工具的 Function Schema 让 LLM 学会"请求"搜索，再实现完整的执行循环（max_turns=3 带详细日志），最后可选地添加 Page Reader 工具突破搜索只能返回 snippets 的局限。日志记录是理解"看不见的对话"的关键。

## 相关链接

- [[Ch02-L04 集成核心智能引擎]] — 本课在其 /chat 端点之上添加 Agentic Loop
- [[Ch02-L06 手动调试Agent的思维]] — 用日志侦探方法调试本课构建的 Agent
- [[Ch02-L01 视频4 阶段A演示与讲解]] — 总览视频中第三章的概念概要

---

## 原文

Lesson 14 of 46
用 Agentic 工具扩展能力 / Extending Capabilities with Agentic Tools

你已经成功将一个强大的语言模型集成到了应用中。然而，LLM 本身存在根本性的局限。它是一台出色的语言处理器，但其知识是静态的，仅限于训练时所用的数据。它无法获取实时信息、与其他系统交互，也无法在现实世界中执行操作。

这就是 Agentic 架构（Agentic Architecture） 概念变得重要的地方。我们不再只让 LLM 基于其内部知识回答问题，而是赋予它一组外部能力，即工具（tools）。然后，我们让 LLM 充当一个推理引擎——一个智能体（agent）——它可以自主决定何时以及如何使用这些工具来完成给定的任务。

核心概念：Agentic 循环

在编写任何代码之前，理解交互流程非常重要。Agentic AI 的工作方式与标准聊天机器人不同。

当用户发送一个请求时（例如："东京的天气怎么样？"），LLM 会对其进行分析并做出决策：

答案是否在我的训练数据中？如果是，则输出标准的文本回复。

我是否需要外部信息？如果是，则输出一个结构化的工具调用（Tool Call）（例如：{"tool": "search", "query": "weather Tokyo"}）。

关键在于，LLM 自己无法执行该工具。它只是生成一个请求，让你的代码去执行该工具。你的系统必须：

检测到工具调用。

执行对应的 Python 函数（例如，网页搜索）。

将结果作为新消息反馈给 LLM。

LLM 随后处理这一新信息并再次做出决策。这个循环就是 Agentic 循环（Agentic Loop）。

图 1：你的代码与 LLM 之间"看不见"的对话。蓝色方框代表远程 LLM API，橙色方框代表你的应用代码。

实现策略

为了清晰起见，我们将分两步来构建。

第 1 步：定义搜索工具

首先，我们需要给 AI 一个工具。我们将使用平台提供的 AI Builder's Search API。在这一步，我们只希望 LLM 理解如何发起一次搜索请求。

Command Cursor（提示词 1）：

I need to add a web search tool to my FastAPI application.
We will use the internal search API at `https://space.ai-builders.com/backend/v1/search/`.
It requires a POST request with `{'keywords': ['query_string'], 'max_results': 3}` and the same Authorization header as our chat API (using `SUPER_MIND_API_KEY`).

Please define a Python function `web_search(query: str)` that calls this API.
Then, define a function schema (JSON format) for this tool that the LLM can understand.

For now, just verify that the LLM can output a valid 'Tool Call' when asked a question like 'Who won the Super Bowl?'. Don't implement the full execution loop yet.

第 2 步：实现 Agentic 循环

既然 LLM 已经知道这个工具的存在，我们就需要处理执行循环。这正是"魔法"发生的地方。

Command Cursor（提示词 2）：

Now, implement the full Agentic Loop in my `/chat` endpoint.
1. When the LLM returns a Tool Call, your code must execute the `web_search` function.
2. Feed the search results back to the LLM as a system/tool message.
3. Allow this process to loop up to 3 times (max_turns = 3) to handle complex queries or follow-ups.
4. Add detailed logging to the console. I want to see:
   - [Agent] Decided to call tool: 'search'
   - [System] Tool Output: '...'
   - [Agent] Final Answer: '...'
This logging is crucial for me to understand the invisible steps.

第 3 步：扩展工具集（可选）

你可能会注意到一个局限：搜索只能返回内容片段（snippets）。如果你问"第三条搜索结果具体说了什么？"，AI 无法回答，因为它无法访问网页。

为了解决这个问题，我们可以添加第二个工具：Page Reader（页面阅读器）。

Command Cursor（提示词 3）：

Now, let's add a second tool called `read_page(url: str)`.
1. Fetch the URL.
2. Extract the main text from the HTML (strip tags, scripts, and styles).
3. Add this tool to the LLM's definition.
4. Update the execution loop to handle both web_search and read_page calls.

Test it with: 'Search for the latest release of Python, then read the official changelog page to tell me the new features.'

测试这个 Agent

重启你的应用并打开 Swagger UI。尝试以下查询：

"查找 Python 库'LangChain'的最新发布版本，并查看其官方发行说明或 PyPI 页面，告诉我该版本中引入的某个具体的'破坏性变更'或新特性。"

"NVIDIA 今天的当前股价是多少？再查找过去 24 小时内的一篇近期新闻文章，解释其股价波动的原因，并总结这一原因。"（需要推理 + 搜索）

观察控制台：你应该能在日志中看到对话中那些"看不见"的轮次正在发生。这证明你的 Agentic 循环正在"呼吸"。