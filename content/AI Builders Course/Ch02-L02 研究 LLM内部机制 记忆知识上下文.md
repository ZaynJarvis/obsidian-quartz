---
course: AI Builders：从用户到构建者
chapter: 模块二：用 AI 构建的五个阶段
source: https://www.superlinear.academy/c/ai/sections/334453/lessons/1240494
scraped_at: 2026-06-28
video: false
---

# 研究：LLM 的内部运作机制 —— 记忆、知识与上下文窗口

## 我的理解

理解LLM的三个核心概念——记忆、知识与上下文窗口——是规避AI常见陷阱的先决条件。ChatGPT的“记忆”并非真实存储，而是把历史对话拼接进prompt的工程实现，因此跨会话的信息必然丢失。GPT的知识库在训练完成后即冻结，对话中“教给”模型的内容只是临时写入上下文，新会话后立即消失。上下文窗口是最关键的资源限制：即便在到达硬性上限前，模型也可能开始遗漏细节。GPT（原始模型）与ChatGPT（产品封装层）的区别是分析“哪些限制来自模型、哪些来自产品设计”的关键框架，这一区分将贯穿后续所有陷阱分析。

## 相关链接

- [[Ch02-L03 理解常见陷阱 偷懒]] — 偷懒陷阱直接源于输出长度限制，是上下文窗口知识的第一个应用
- [[Ch02-L04 理解常见陷阱 遗忘]] — 遗忘陷阱是上下文窗口动态管理机制的直接体现
- [[Ch07-L02 预训练大语言模型]] — 更深层地解释LLM的知识从何而来以及为何静态
- [[Ch06-L06 重访上下文窗口管理 自动管理]] — 后续模块对上下文窗口管理的进阶自动化探讨

---

## 原文

Lesson 9 of 68
研究：LLM 的内部运作机制 —— 记忆、知识与上下文窗口 / Research: How LLMs work internally - Memory, knowledge, and context window

驾驭生成式 AI 的世界需要把握微妙的平衡，因为这些强大的工具往往带来的误用机会比正确使用更多。要避开常见陷阱，深入理解其内部运作至关重要。所有处理文本的生成式 AI（如 ChatGPT 和 Claude）都由大语言模型（LLM）驱动。对于机器学习领域之外的人来说，这些模型并不总是浅显易懂。本课旨在阐明对 LLM 至关重要的三个相互关联的概念：记忆、知识与上下文窗口。





记忆



乍看之下，ChatGPT 似乎拥有惊人的记忆力。在一次会话中告诉它叫你 John，它在后续交流中就会一直称呼你为 John。这看似展示了 GPT 的能力，但实际情况要更微妙一些。ChatGPT 的基础是 GPT 模型，一种处理文本的神经网络。与其他文本类神经网络一样，它接收文本输入（也称为 prompt）并生成文本输出。这一交互过程被称为推理（inference），即向模型输入信息、执行计算并产生输出，而不会改变模型本身。因此，从严格意义上讲，模型并不会“记住”任何东西。




然而，ChatGPT 确实给人一种拥有记忆的错觉。这是 OpenAI 通过一种巧妙的机制实现的：将历史对话纳入提供给 GPT 模型的输入中。这一技巧赋予了 ChatGPT 短期记忆，使其能够基于先前的对话来生成情境化的响应。但这种能力本身也存在局限——记忆无法跨越独立的会话，也无法支撑过长的对话，我们将在讨论上下文窗口时进一步探讨这一点。




下图展示了一个示例。用户与 ChatGPT 进行了一次对话，ChatGPT 需要回答最后一个问题“你应该怎么称呼我？”：


====================================

User: Call me John in the following conversations.

Assistant: Sure I will call you John.

User: What should you call me?

====================================




一个常见的误解是认为 ChatGPT 有一个用于存储记忆的数据库。人们常常以为，当我们让它叫我们 John 时，它会把这一信息存进某个记忆数据库；当我们之后问它“你应该怎么称呼我？”时，它会从这段记忆中调取并相应作答。



但事实并非如此。底层实际发生的是：ChatGPT 将所有历史对话拼接成一个 prompt，发送给底层的 GPT 模型。GPT 随后理解上下文（例如用户要求被称为 John），并据此作出回应。

需要明确的是，GPT 与 ChatGPT 是两个不同的实体。GPT 是一个 LLM，是可通过 OpenAI API 访问的原始模型，是 ChatGPT 的技术底座。而 ChatGPT 则是构建在 GPT 之上的面向消费者的产品，可通过网页和移动应用直接使用。它包含了基础 GPT 模型所不具备的额外功能与限制。例如，GPT 本身并没有“记忆”功能，但 ChatGPT 通过将历史对话纳入 prompt 的策略来模拟短期记忆。此外，ChatGPT 还预设了一些 prompt，以提升用户交互体验，使产品更贴近人类预期，并保障使用安全。随着我们深入了解 ChatGPT 与 GPT 的细节，理解会逐步加深，从而能更有效地避开这些技术常见的陷阱。





知识

ChatGPT 经常表现出对世界的博学理解，仿佛具备常识。这种能力来自底层 GPT 模型所基于训练的庞大数据集。然而，GPT 有一个内在局限：其知识库是静态的；一旦训练完成，未发布新版本之前便无法更新或修订其认知。这正是为什么 OpenAI 每次发布新版本 GPT 时都会公布一个知识截止日期——表示模型能够准确反映的最新时间点。




尽管存在这些限制，让 GPT 接入新信息的需求依然旺盛，尤其是在面向特定组织知识库定制问答机器人等应用场景中。看似很直观，但在对话中反复“教”GPT 某些内容，并不会将这些知识吸收进模型。因为正如我们前面所说，与 GPT 进行对话不会以任何方式改变模型本身。一开始它似乎掌握了这些知识，那是因为这些“知识”作为历史对话的一部分被包含在 prompt 中；一旦开启新会话，它就会立即"遗忘"。

关于该话题的详细讲解将放在第 4 模块中，但将知识写入 prompt 确实是一种有效的、临时性“告知”GPT 新数据的方式。此外，OpenAI 还提供了诸如 GPTs 之类的能力，让用户可以上传文档，从而将自定义知识库直接整合进交互之中。这一特性为个性化应用打开了新的可能。





上下文窗口

LLM 虽然能力惊人，但并非毫无边界。一个重要的限制是它们能够处理的输入长度，即（输入）上下文窗口。例如，在商用 LLM 中，GPT-3.5-Turbo 最多可处理 16k tokens，GPT-4-Turbo 扩展到 128k，GPT-5 则达到 400k tokens。一个 token 约等于 0.75 个单词，因此 GPT-5 的最大输入大致相当于 30 万个单词，约 600 页内容。但实际观察发现，模型的表现（或者说“聪明程度”）在达到上限之前就会开始下降，通常在 80k tokens 左右就可能漏掉细节或遗忘前文输入。

这一限制在区分 GPT 模型与其产品形态 ChatGPT 时尤为重要。尽管 GPT-5 模型理论上可支持高达 400k tokens，ChatGPT 在实际使用中却被限制在一个更小的上下文窗口内。这并非源于 GPT 模型本身，而是 OpenAI 为 ChatGPT 做出的设计选择，以确保交互可控且高效。例如，免费版用户拥有 8k 上下文窗口，Plus 用户为 32k，而 Pro 和企业版用户为 128k。换句话说，当某些输入触发下方的错误信息时，直接调用原始 GPT API 可能仍能得到响应。





由于 ChatGPT 会将对话历史纳入当前上下文，而上下文窗口的容量是有限的，这意味着它无法无限“记忆”——无法把最早的对话继续放入 prompt，从而导致较长交互中出现“健忘”现象。需要认识到，这是 ChatGPT 界面的限制，而非底层 GPT 模型的局限。若想充分利用完整的上下文窗口容量，直接使用 OpenAI 的 API 是一种解决方案。对于 ChatGPT 用户而言，有效管理上下文窗口是绕开这些问题的关键，我们将在下一课中介绍相关方法。

English Original

Navigating the landscape of GenAI requires a fine balance, as these powerful tools often present more opportunities for misuse than proper use. To sidestep common pitfalls, a deeper understanding of their inner workings is important. All textual Generative AIs, such as ChatGPT and Claude, are powered by Large Language Models (LLMs). These models are not always straightforward, especially for those outside the machine learning field. This lesson aims to clarify three interconnected concepts vital to LLM: memory, knowledge, and the context window.





Memory





At first glance, ChatGPT seems to possess a remarkable memory. Tell it to call you John during a session, and it will refer to you as John in subsequent exchanges. This might seem like a testament to GPT's capabilities, but the reality is a bit more nuanced. ChatGPT's foundation is the GPT model, a neural network processing texts. Like other textual neural networks, it processes text inputs (also called prompts) and generates text outputs. This interaction, known as the inference process, involves feeding the model input, performing calculations, and producing output, without altering the model itself. Thus, in the strictest sense, the model doesn't "remember" anything.





However, ChatGPT does give the illusion of having memory. This is achieved through a clever mechanism by OpenAI, where the historical conversations are included in the input given to the GPT model. This technique gives ChatGPT a short-term memory, contextualizing its responses based on earlier exchanges. This capability, however, has its own limitation -- memory does not extend across separate sessions or through prolonged dialogues, which we'll explore further in our discussion on the context window.





The following figure shows an example. The user and ChatGPT had a conversation. And ChatGPT needs to answer the last question of "what should you call me?":


====================================

User: Call me John in the following conversations.

Assistant: Sure I will call you John.

User: What should you call me?

====================================





A common misconception is that ChatGPT has a database storing its memory. People often think that when we ask it to call us John, it stores this information in a memory database. Later, when we ask, "What should you call me?" it recalls this memory and answers accordingly.





This isn't the case. What happens under the hood is that ChatGPT constructs a prompt with all the historical conversations and sends it to the underlying GPT model. GPT then understands the context, such as the user asking to be called John, and responds accordingly.

It's important to understand that GPT and ChatGPT are two distinct entities. GPT is an LLM, a raw model accessible through OpenAI's API, serving as the technological backbone for ChatGPT. ChatGPT, in contrast, is a consumer-facing product built upon GPT, designed to be directly accessible via web and mobile apps. It comes with additional features and restrictions not present in the base GPT model. For example, while GPT itself lacks a "memory" function, ChatGPT uses the strategy of including historical conversations in prompts to simulate short-term memory. Additionally, ChatGPT includes predetermined prompts to enhance user interaction, aligning the product closer to human expectations and ensuring a safer user experience. As we dive deeper into the details of ChatGPT and GPT, our understanding will deepen, enabling us to navigate around the common pitfalls associated with these technologies more effectively.





Knowledge





 ChatGPT often displays what seems like a knowledgeable understanding of the world, mimicking common sense. This ability is derived from the extensive dataset the underlying GPT model was trained on. However, an inherent limitation of GPT is its static knowledge base; once trained, it cannot update or revise its understanding without a new model version. This is why with each iteration of GPT, OpenAI announces a knowledge cutoff date -- marking the latest point in time it can accurately reflect.





Despite these constraints, there is a significant demand for GPT to incorporate new information, especially for applications like tailored Q&A bots for specific organizational knowledge bases. While seemingly intuitive, "teaching" GPT something repeatedly in a conversation won't ingest the knowledge into the model. Because as we explained, having conversation with GPT won't alter the model in any way. It may appear to have the knowledge at first, because this "knowledge" is included in the prompt as part of historical conversations, but will immediately lose it when a new conversation starts. 

While a detailed explanation of this topic is reserved for the 4th module, including the knowledge in the prompt is indeed an effective way to temporarily "inform" GPT of new data. Furthermore, OpenAI offers capabilities, such as with GPTs, for users to upload documents, thereby integrating a custom knowledge base directly into the interaction. This feature opens up new possibilities for personalized application.





Context Window

The power of LLMs, despite their impressive capabilities, is not without bounds. An important limitation is the length of the input they can process, known as the (input) context window. For instance, in the infantry of commercial LLMs, GPT-3.5-Turbo can handle up to 16k tokens. GPT-4-Turbo extends to 128k, and GPT-5 to 400k tokens. Given that a token approximates 0.75 words, GPT-5's maximum input spans roughly 300k words, or about 600 pages. However, it's observed that the model's performance (or "smartness") starts to decline before reaching its maximum limit, often around 80k tokens, where it might miss details or forget earlier input.

This constraint is particularly relevant when distinguishing between the GPT model and its product form ChatGPT. Although the GPT-5 model theoretically could support up to 400k tokens, ChatGPT's practical use case is limited by a smaller context window. This limitation isn't due to the GPT's model itself, but a design choice for ChatGPT by OpenAI to ensure manageable and effective interaction. For example, free tier users get 8k context window, Plus tier users get 32k, while the Pro and Enterprise users get 128k. In other words, when a certain input triggers the error message below, invoking the raw GPT's capability using raw API may still produce a response.





As ChatGPT incorporates conversation history into its current context, the finite size of the context window means it cannot remember indefinitely, preventing ChatGPT from including the earliest conversations in the prompt, leading to forgetfulness in longer interactions. It's important to recognize this as a limitation of the ChatGPT interface rather than the underlying GPT model. For those looking to leverage the full context window capacity, directly utilizing OpenAI's API is a solution. For ChatGPT users, effective context window management is the key to get around these problems, which we will introduce in the next lesson.
