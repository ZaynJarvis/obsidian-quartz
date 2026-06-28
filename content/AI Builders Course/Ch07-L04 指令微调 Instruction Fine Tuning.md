---
course: AI Builders：从用户到构建者
chapter: 深入原理：LLM 是如何训练出来的
source: https://www.superlinear.academy/c/ai/sections/336476/lessons/1247924
scraped_at: 2026-06-28
video: false
---

# 指令微调（Instruction Fine Tuning）

## 我的理解

指令微调的本质是一个巧妙的“格式技巧”：通过 User/Assistant 格式的精心整理数据，让预训练模型学会遵循指令的行为模式，而不是注入任何新知识。微调改变的是交互风格与行为（如输出 Markdown、拒绝有害请求），知识和能力的上限已在预训练时划定，微调只是“激活”而非“创造”。正因如此，指令微调可以用相对少量的数据完成，但也正因为此，它无法弥补预训练能力的短板。构建者理解这一点，就能避免对微调寄予不切实际的期望，并懂得何时需要更根本性的解决方案。

## 相关链接

- [[Ch07-L05 基于人类反馈的强化学习 RLHF]] — RLHF 是对指令微调在灵活性与可扩展性上局限性的直接回应与升级
- [[Ch05-L05 猜想 GenAI 与人类有何不同]] — 微调激活行为而非注入知识，体现了 GenAI 与人类学习方式的根本差异
- [[Ch04-L11 技术洞察 像管理者一样思考]] — 理解微调机制有助于像管理者一样合理划定任务边界，知道 AI 能做什么、不能做什么
- [[Ch02-L04 理解常见陷阱 遗忘]] — 微调数据量有限，模型仍容易在长对话中遗忘指令，两者共同勾勒出上下文管理的重要性

---

## 原文

Lesson 55 of 68
指令微调（Instruction Fine Tuning）

作为大语言模型（LLM）基础技术的 Transformer 早在五年多以前就已经问世，但 ChatGPT 直到 2023 年前后才横空出世。这其中有许多值得探究的原因与经验，但最关键的缺失环节就是微调（fine-tuning）步骤。本课将介绍这一关键步骤如何影响 LLM 的风格、语气和行为。它既保障了 AI 的有用性和安全性，但也带来了我们在上节课中提到的那些问题。

微调这一步其实非常简单：它通过精心准备的训练数据，教会一个预训练好的 LLM 如何遵循指令。仅此而已。它并不会改变底层模型本身的任何机制。本质上，LLM 依然是在预测下一个词。唯一的区别在于，我们不再用小说、维基百科和网络帖子来训练 LLM，而是改用经过精心整理的训练数据，让它遵循某种特定格式，例如：

====================================

User: <request>

Assistant:

====================================

请注意，“User:”和“Assistant:”是字面文本。“Assistant:”后面刻意留空，因为接下来我们要让 LLM 预测后续的词。其训练机制完全相同。例如，训练数据的输入可能是这样：

====================================

User: What's the capital city of the US?

Assistant:

====================================

我们让 LLM 预测后续的词，并将其与预期输出（“Washington DC.”）进行比对。如果二者不同，就会调整 LLM 的内部参数，使其更有可能输出预期结果。

这一步教会了 LLM 回答问题和遵循指令，因此被称为指令微调（Instruction Fine Tuning）。经过这一步后，LLM 变得更易于使用。设想我们有一个简单的翻译器程序：当我们向它提问时，它会将输入构造成“User: <Question> Assistant:”这样的形式，让 LLM 预测后续的词，再把 LLM 的结果返回给我们。这就让我们可以直接向 LLM 提问。如果我们想知道美国的首都，不必让 LLM 去续写“The capital city of the US is”，而是可以直接对翻译器程序问“What's the capital city of the US?”。程序会按 User/Assistant 格式构造提示词（即 LLM 的输入），调用 LLM 进行预测，并返回结果“Washington DC.”。所有这些灵活性都源于一个巧妙的小技巧：让提示词遵循特定格式。这正是 ChatGPT 内部的运作方式。ChatGPT 还进一步支持多轮对话，这也很容易实现，只需在微调中加入多轮对话的数据即可。

不过，有一点需要澄清：微调过程使用的训练数据，相比预训练阶段要少得多。预训练阶段无需任何人工标注（称为自监督学习，因为监督信号来自下一个词），因此具备极强的可扩展性——我们可以直接把每本书、每个网页都喂进训练流程。但微调过程就没有这种便利。问答格式或“请求—响应”格式的数据要少见得多，往往需要人工整理。因此，在这一步使用大规模数据并不现实，这也正是它被称作“微调”的原因。

这也限制了微调的潜力。微调无法为 LLM 带来任何新的能力或知识。LLM 的所有演绎、推理能力以及常识，都来自预训练。微调改变的主要是 LLM 与我们交互的方式——它的风格、语气或行为模式。例如，经过微调后，LLM 可能在被要求时知道用 Markdown 来组织输出，或懂得不应回应有害请求。然而，关于 Markdown 的知识以及对“有害”的界定，并不是来自微调本身——它们本就存在于 LLM 内部，只是被微调“激活”而已。也正因为微调无需向 LLM 注入新的知识或能力，它可以仅凭相对少量的训练数据完成。我们将在最后一个模块中再触及这一点。眼下，重要的是记住微调的好处与局限。

English Original

The Transformer, the foundational technology of LLMs, appeared more than half a decade ago, but ChatGPT only emerged around 2023. There are many reasons and lessons to explore, but the core missing piece is the fine-tuning step. In this lesson, we will introduce how this critical step impacts the style, tone, and behavior of the LLM. It ensures the helpfulness and safety of the AI but also causes the issues we mentioned in the last lesson.

The fine-tuning step is actually quite simple. It teaches a pre-trained LLM how to follow instructions using curated training data. That's it. It doesn't change anything in the underlying model. Essentially, the LLM still predicts the next word. The only difference is that instead of training the LLM using novels, Wikipedia, and online posts, we use curated training data so it follows a certain format, which looks like:

====================================

User: <request>

Assistant:

====================================

Note that "User:" and "Assistant:" are literal texts. There is nothing after "Assistant:" intentionally because we then ask the LLM to predict the next words. The same training mechanism applies. For example, the input of training data may look like:

====================================

User: What's the capital city of the US?

Assistant:

====================================

We ask the LLM to predict the next words, and compare it with the expected output ("Washington DC."). If they are different, we will tweak the internals of the LLM to make it more likely to produce the expected output.

This step teaches the LLM to answer questions and follow instructions, and is thus named Instruction Fine Tuning. After this step, the LLM becomes much easier to use. Imagine we have a simple translator program. When we ask it a question, it constructs an input like "User: <Question> Assistant:" and asks the LLM to predict the next words. It then returns the LLM's result to us. This allows us to ask the LLM questions directly. If we want to know the capital city of the US, instead of asking the LLM to predict the next words of "The capital city of the US is," we could directly ask the translator program, "What's the capital city of the US?". The program constructs the prompt (the input to the LLM) using the User/Assistant format, invokes the LLM for prediction, and returns the result "Washington DC." All this flexibility starts from the clever trick of using a certain format for prompts. This is exactly what happens in ChatGPT. ChatGPT further supports multi-round conversations, which is also easy to add by including multi-round data for fine-tuning.

There is a clarification, though. The training data used in the fine-tuning process is much less compared with the pre-training stage. The pre-training stage doesn't require any human annotation (called self-supervised learning, because the supervision comes from the next word), making it very scalable. We can simply feed every book and web page into the training process. But this fine-tuning process doesn't have that luxury. The Q&A format or request-response format is much less common and often requires human curation. Therefore, it's not practical to use large-scale data for this step, which is why it's called fine-tuning.

This also limits fine-tuning's potential. Fine-tuning cannot give the LLM any new capabilities or knowledge. All the deduction, inference capabilities, and common sense of LLMs result from pre-training. What fine-tuning changes is mainly how the LLM interacts with us—its style, tone, or behaviors. For example, after fine-tuning, the LLM may know to organize its output in Markdown when asked or understand not to respond to harmful requests. However, this knowledge of Markdown and the definition of harmfulness are not from fine-tuning. They were already in the LLM and are just activated by fine-tuning. And because fine-tuning doesn't need to ingest new knowledge or capabilities into the LLM, it can rely on a relatively small amount of training data. We will touch on this in the last module. For now, it's important to remember the benefits and limitations of fine-tuning.