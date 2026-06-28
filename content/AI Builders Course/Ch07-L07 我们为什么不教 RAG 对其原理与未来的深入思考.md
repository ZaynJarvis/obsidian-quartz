---
course: AI Builders：从用户到构建者
chapter: 深入原理：LLM 是如何训练出来的
source: https://www.superlinear.academy/c/ai/sections/336476/lessons/1247928
scraped_at: 2026-06-28
video: false
---

# 我们为什么不教 RAG：对其原理与未来的深入思考

## 我的理解

课程不教流行版 RAG 的核心判断是：它重造了粗糙的轮子（忽视了搜索引擎数十年积累）、静态两步流程为智能设置了硬天花板、而其基础假设（上下文窗口瓶颈）正被迅速突破。但课程认可 RAG 的核心思想——高效检索稀疏相关知识以提升生成质量，并指向两个更深层的机会：LLM 与搜索引擎的联合优化，以及 Agentic 的动态检索工作流。这一课最本质的教导是第一性原理思维：评估任何技术范式时，要区分“核心思想是否正确”与“当前流行实现是否值得投资”——两者可以完全不同。

## 相关链接

- [[Ch06-L04 无需写代码 搭建完全本地化的 RAG]] — 本地 RAG 的实践案例与本课的原理批判形成对照，帮助理解技术的使用场景与内在局限
- [[Ch06-L05 用 Agent 增强 LLM 能力]] — Agentic 动态检索工作流是课程倡导的替代方向，本节与该课在理念上直接呼应
- [[Ch05-L07 可落地的指南 哪些任务该交给 GenAI]] — 选择合适工具而非盲从流行范式，两课在判断框架和取舍逻辑上相互补充
- [[Ch02-L02 研究 LLM内部机制 记忆知识上下文]] — RAG 兴起的直接原因是上下文窗口限制，理解 LLM 内部机制是批判性评估 RAG 价值的前提

---

## 原文

Lesson 58 of 68
我们为什么不教 RAG：对其原理与未来的深入思考 / Why We Don’t Teach RAG: A Deeper Dive into Its Principles and Future

你可能已经注意到，我们的课程中存在一个明显的“缺席”。尽管 RAG（检索增强生成，Retrieval-Augmented Generation）在业界声名鹊起，我们却有意选择不将其作为重点。这是一个经过深思熟虑的决定，根植于我们对技术本质的理解，以及我们为你迎接未来所应承担的责任。

在深入展开之前，我们先明确一下，当我们说 RAG 时，究竟指的是什么。

在当前的行业语境中，RAG 通常指代一种特定的、在我们看来属于过渡性的技术范式。它有两个显著特征。第一，其检索环节往往相当粗糙，依赖于一个朴素的框架：简单的文本切分、向量嵌入提取与相似度检索。第二，其工作流是静态的，僵硬地遵循“先检索信息，再将结果塞入上下文窗口进行生成”的两步流程。

我们课程不教的，正是这种特定版本的 RAG。原因有三。

第一，它是在重新发明轮子，而且发明得并不好。信息检索是搜索引擎技术的核心，这是一个已发展数十年、在解析、索引和排序方面积累了无数成熟方案的领域。然而，当前流行的 RAG 实现似乎忽视了这些丰厚的积累，选择从一个非常初级的起点重新开始，重走老路。一些所谓的 RAG 优化技术，例如语义切分，不过是在追赶十年前搜索技术就已达到的水平。让你把精力投入到学习造一个简陋的轮子上，而高级引擎其实早已唾手可得，我们认为这是一种不负责任。

第二，它的工作流是静态且割裂的，这为智能水平设置了一个硬性天花板。在这种范式中，搜索引擎与大语言模型之间是一条单行道：搜索仅仅是为 LLM 喂送原料的工具。这并非真正的智能运作方式。设想一位专家在解决复杂问题：他会动态调整方法，追问深挖，反复地探查、验证与反思。相比之下，静态的 RAG 流程更像一个只会照本宣科的初级助理：先找文档，再写总结。我们在本课程中所强调的 Agentic（智能体式）思维，正是要打破这种僵硬的束缚。

第三，RAG 的许多基础假设都建立在流沙之上。RAG 最初的兴起，很大程度上是为了绕开 LLM 上下文窗口的限制。但技术格局正在飞速变化。不到两年时间，上下文窗口已从数千 token 暴涨到数百万；API 价格降至原先的极小一部分（约 1%）；推理速度也呈指数级提升。成本和效率固然始终是需要考量的因素，但为一个正在迅速消失的瓶颈构建一套复杂系统，绝非稳健的长期策略。

那么，我们是要全盘否定 RAG 吗？恰恰相反。

我们批评的是那些朴素而被误用的实现方式，但我们坚信其背后的核心思想不仅正确，而且意义深远：从浩瀚的信息海洋中高效地检索出稀疏而相关的知识，是提升生成质量的根本所在。

真正的机会，并不在于简单地用 LLM 给老旧的搜索模型打补丁，而在于追问两个更深层的问题：

我们如何才能实现 LLM 与搜索引擎的真正联合优化？未来不是一条简单的流水线，而是一个共生系统。LLM 深度的语义理解能力，有潜力从根本上重塑搜索的内在机理；与此同时，一个为 LLM 原生设计的搜索引擎，也能以远超今日的精度与效率提供知识。

我们如何构建 Agentic、动态的检索工作流？与其依赖静态流程，不如赋予 AI Agent 自主决策的能力——由它自己决定何时检索、用什么关键词、如何综合多轮检索的结果。这才是通往更强大、更通用智能的道路。

总而言之，我们选择不教常见版本的 RAG，是因为我们不希望你把宝贵的时间花在一项很可能只是过渡性的技术上，更不希望它锚定你对 AI 能力边界的认知。我们的课程将聚焦于那些更基础、更经得起时间考验的能力：构建 Agentic 系统的原则、实现联合优化的思维方式，以及从第一性原理出发思考问题的能力。

我们坚信，掌握了这些核心理念之后，无论新范式被命名为 RAG 2.0 还是其他什么，你都能洞察其本质，从容而娴熟地驾驭未来。

English Original

You might have noticed an absence in our curriculum. Despite its immense popularity in the industry, we have intentionally decided not to focus on Retrieval-Augmented Generation, or RAG. This was a deliberate choice, rooted in our perspective on the nature of technology and our responsibility to prepare you for the future.

Before we dive deeper, let’s first define what we mean when we say RAG.

In the current industry context, RAG typically refers to a specific, and in our view, transitional technical paradigm. It has two characteristics. First, its retrieval component is often quite rudimentary, relying on a simple framework of naive text chunking, embedding extraction, and similarity search. Second, its workflow is static; it rigidly follows a two-step process of first retrieving information, then stuffing the results into a context window for generation.

It is this specific version of RAG that our course does not teach. Here are three reasons why.

First, it is reinventing the wheel, and not very well. Information retrieval is the core of search engine technology, a field that has evolved over decades and has developed countless sophisticated solutions for parsing, indexing, and ranking. Yet, the current popular RAG implementations seem to ignore this wealth of knowledge, choosing instead to restart from a very basic point and retread the same path. Some RAG optimization techniques, like semantic chunking, are merely catching up to where search technology was a decade ago. We believe it is a disservice to have you invest your energy in learning to build a simple wheel when advanced engines are already at your disposal.

Second, its workflow is static and disconnected, which places a hard ceiling on intelligence. In this paradigm, the relationship between the search engine and the large language model is a one-way street; search is simply a tool to feed raw materials to the LLM. This is not how true intelligence works. Imagine an expert solving a complex problem. They dynamically adjust their approach, ask follow-up questions, and iteratively probe, verify, and reflect. The static RAG process, in contrast, is like a junior assistant who can only follow a two-step script: find documents, then write a summary. The Agentic thinking we emphasize in this course is precisely about breaking free from such rigid constraints.

Finally, many of the foundational assumptions for RAG are built on shifting sands. RAG initially gained traction largely as a workaround for the context window limitations of LLMs. But the technological landscape is shifting rapidly. In less than two years, context windows have exploded from a few thousand tokens to millions, API prices have decreased to a fraction (~1%) of their original cost, and inference speeds have increased exponentially. While cost and efficiency will always be factors, building a complex system to solve for a bottleneck that is quickly disappearing is not a sound long-term strategy.

So, are we dismissing RAG entirely? Quite the opposite.

We are critical of the naive and misused implementation, but we believe the core idea behind it is both correct and profoundly important: the ability to efficiently retrieve sparse, relevant knowledge from a vast sea of information is fundamental to enhancing the quality of generation.

The real opportunity lies not in simply patching up an old search model with an LLM, but in asking two deeper questions:

How can we achieve a true joint optimization of LLMs and search engines? The future is not a simple pipeline but a symbiotic system. An LLM's deep semantic understanding has the potential to fundamentally reshape the internal mechanics of search. Likewise, a search engine designed natively for LLMs could provide knowledge with far greater precision and efficiency than what is possible today.

How can we build Agentic, dynamic retrieval workflows? Instead of a static process, we should empower an AI agent with the autonomy to decide for itself when to search, what keywords to use, and how to synthesize the results of multiple retrieval rounds. This is the path toward more powerful and general intelligence.

To sum up, we choose not to teach the common implementation of RAG because we do not want you to spend precious time on a technique that is likely transitional, nor do we want it to anchor your understanding of what AI can do. Our course focuses instead on the more fundamental and future-proof capabilities that will endure: the principles of building Agentic systems, the mindset for achieving joint optimization, and the ability to think from first principles.

We are confident that by mastering these core concepts, you will be able to see the essence of any new paradigm, whether it is called RAG 2.0 or something else entirely, and navigate the future with clarity and skill.