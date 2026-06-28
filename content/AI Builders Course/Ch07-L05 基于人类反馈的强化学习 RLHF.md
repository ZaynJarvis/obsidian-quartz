---
course: AI Builders：从用户到构建者
chapter: 深入原理：LLM 是如何训练出来的
source: https://www.superlinear.academy/c/ai/sections/336476/lessons/1247926
scraped_at: 2026-06-28
video: false
---

# 基于人类反馈的强化学习（RLHF）

## 我的理解

RLHF 通过引入“裁判 AI”绕开了指令微调的两大瓶颈：开放性问题没有标准答案、人工撰写训练数据成本极高。裁判 AI 学习人类对“哪个回答更好”的偏好判断后，即可自动指导模型向更优质的回答倾斜，无需写出标准答案，大幅提升灵活性和可扩展性。对构建者最重要的认知是：RLHF 是解释“模型为何倾向于讨好用户、给出听起来自信但不一定准确的回答”的关键——人类评审者往往更青睐流畅、自信的表达，这种偏好被 RLHF 系统性地放大。理解这一机制，能帮助你更批判地解读模型的自信程度。

## 相关链接

- [[Ch05-L06 要点 1 与幻觉共处]] — RLHF 对流畅自信表达的优化可能放大幻觉，因为“听起来正确”比“真正正确”更易获得人类好评
- [[Ch07-L04 指令微调 Instruction Fine Tuning]] — RLHF 是在指令微调基础上解决其核心局限的下一步，两节课构成完整的训练链
- [[Ch05-L05 猜想 GenAI 与人类有何不同]] — RLHF 塑造了 GenAI 独特的“讨好”倾向，是理解其与人类认知差异的重要维度
- [[Ch02-L03 理解常见陷阱 偷懒]] — RLHF 优化人类偏好的机制解释了为何模型会给出表面流畅但深度不足的省力回答

---

## 原文

Lesson 56 of 68
基于人类反馈的强化学习（RLHF） / Reinforcement Learning from Human Feedback (RLHF)

指令微调非常有效，但在灵活性和可扩展性上仍有局限。一方面，并非每个请求都像“美国的首都是哪里？”那样定义明确。想想“给我讲个笑话”这样的提示，让大模型每次都给出同一个标准答案的笑话显然没有意义。另一方面，这种人工整理的成本也非常高，与传统的 AI 训练标注任务不同，这类整理需要人类亲自撰写或修订文本，从而限制了训练的可扩展性。

正因如此，研究界提出了另一个巧妙的思路：基于人类反馈的强化学习（Reinforcement Learning with Human Feedback，RLHF）。尽管名字听起来复杂，原理其实非常简单。我们先训练一个“裁判 AI”，让它判断两个回答中哪个更好，然后用这个裁判 AI 来指导微调过程。裁判 AI 让我们在很大程度上绕开了数据整理环节，因为我们只需让大模型生成两个回答，再调整其内部参数，使其倾向于更好的回答、远离更差的回答即可。无需准备标准答案，也不必把自己限制在少量经过整理的选项之中。因此，这种方法更具灵活性和可扩展性。

具体而言，RLHF 的每条训练样本包含针对同一请求的两个回答。这些回答可以来自大模型，也可以来自人类。人类对它们进行评审，标注哪一个更好。随后，我们训练一个裁判 AI 来模拟这一人工评审过程，使用与预训练（这部分可以复用）和微调相同的训练流程。完成这一步之后，由裁判 AI 接手并指导指令微调环节。网上有不少开源的 RLHF 数据集（例如 Anthropic 的 HH-RLHF，以及 Databricks 的 Dolly ）。浏览这些数据集通常很有意思，能帮助你深入理解这一步究竟想要达成什么目标。

English Original

Instruction fine-tuning is very effective but still has limits on flexibility and scalability. On one hand, not every request is as well-defined as "What's the capital city of the US?" Think about the prompt "Tell me a joke." It doesn't make sense to have a standard answer and ask the LLM to provide the same joke every time. On the other hand, this kind of curation is also very expensive, unlike traditional labeling tasks for training AIs. This curation requires humans to actually write or revise texts, which limits the scalability of the training.

That's why the research community developed another clever idea: Reinforcement Learning with Human Feedback (RLHF). Despite its complicated name, it's actually very simple. It means we first train a "judge AI" to determine which of two responses is better, and then use the judge AI to guide the fine-tuning. The judge AI allows us to largely bypass the data curation process because it only needs to ask the LLM to produce two responses, and then adjust its internals to favor the better response and move away from the worse response. There's no need to prepare standard answers or limit ourselves to a few curated options. Therefore, it's much more flexible and scalable.

Specifically, each training example for RLHF consists of two responses to a given request. These responses can come from LLMs or humans. Humans review them and mark which one is better. We then train a Judge AI to mimic this human review process, using the same training process as pre-training (this part is reusable) and fine-tuning. After this step, the Judge AI takes over and guides the instruction fine-tuning steps. There are quite a few open-source RLHF datasets online (e.g., HH-RLHF from Anthropic, and Dolly from Databricks). It's often fun to browse these datasets to get a good understanding of what this step actually aims to achieve.
