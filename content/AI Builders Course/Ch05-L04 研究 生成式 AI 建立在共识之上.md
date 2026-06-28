---
course: AI Builders：从用户到构建者
chapter: 模块四：如何思考与抓住 AI 机会
source: https://www.superlinear.academy/c/ai/sections/334462/lessons/1240556
scraped_at: 2026-06-28
video: false
---

# 研究：生成式 AI 建立在共识之上

## 我的理解

GenAI 的底层机制是下一个 token 的概率预测，因此它天然擅长训练数据中的共识知识——越常见越准确，越冷门越容易幻觉。这揭示了一个反直觉的现象：对于冷门任务，GenAI 不只是「编造错误」，还会输出「正确但无用」的废话，因为共识性建议永远是正确的，但极少包含真正的洞见。能赚钱的营销邮件属于互联网顶端 1%，而 GenAI 被训练成输出平均水平，因此永远无法直接提供这类卓越内容。幻觉可以通过外部手段控制（RAG、文档约束），但改变不了其概率性本质。

## 相关链接

- [[Ch07-L02 预训练大语言模型]] — 预训练机制直接解释了共识偏向的技术根源
- [[Ch07-L01 训练机器学习模型]] — 更基础的机器学习训练视角
- [[Ch05-L07 可落地的指南 哪些任务该交给 GenAI]] — 共识理解直接推导出任务委托的决策框架
- [[Ch05-L06 要点 1 与幻觉共处]] — 从共识机制到与幻觉共处的实践应用

---

## 原文

Lesson 40 of 68
研究：生成式 AI 建立在共识之上 / Research: GenAI is built on consensus

在进入我们的决策框架之前，我们需要先理解生成式 AI 是什么、不是什么。面对新事物时，人们常常会基于已有技术进行类比和外推，但这种做法在建立第一性原理的理解时往往适得其反。




我们将在加餐模块中讨论从训练机器学习模型到训练大语言模型的演变过程。这里我们总结了该模块的关键洞察，以便评估我们应该把哪些任务交给生成式 AI 来完成。

生成式 AI 擅长处理训练数据中的共识，因为它的训练方式是——基于海量训练文本预测下一个 token 的概率。因此，某条知识在训练数据（主要是互联网上的文本）中出现得越多，GPT 就越能准确地回忆并使用它。GPT 之所以擅长编程，一方面是因为代码结构化且具有可预测性，另一方面是因为有大量代码作为训练数据被喂给了 GPT。但对于较冷门的编程语言（例如 Rust），GPT 就更容易出错。

对于较冷门的事实，生成式 AI 会出现幻觉，也就是自信地说出错误的内容。这一现象的根源在于其底层机制——下一个 token 预测。模型永远会给出它最有把握的答案。对模型而言，它无法分辨正确答案与错误答案的区别。换句话说，事实是否为真，在训练过程中从来不是一个被明确优化的目标。正确性只能通过共识来保证。如果某条信息频繁出现，生成式 AI 就能答对；如果没有，它就只能凭空编造。

幻觉可以通过模型外部的变通方法加以控制。例如，New Bing（Copilot）利用搜索引擎告诉模型围绕搜索结果来组织答案。提供文档作为上下文，并基于该文档约束生成式 AI 的回答，也能起到帮助作用。


对于较冷门的任务，生成式 AI 会说出正确但无用的内容。例如，没有什么能阻止我们去问 GPT 如何变得富有，它会给出看似有用的建议。这些建议是正确的，但大多数都没什么用。这同样是因为 GPT 被训练成输出训练数据中的共识。如果我们期望 GPT 生成一封读起来通顺自然的邮件草稿，这是合理的期望，因为这就是书籍和互联网文章的平均水平。但如果我们期望 GPT 写出一封能为我们赚钱的高效营销邮件，那就不合理了，因为这属于卓越的内容。能赚钱的邮件在质量上很可能位于互联网的前 1%，而不属于多数或平均水平。

English Original

Before getting to our decision framework, we need to understand what GenAI is and is not. When encountering something new, it’s common for humans to try to draw analogies and extrapolations based on existing technologies, which may be counterproductive in building an understanding based on first principles.




We will discuss the evolution from training a machine learning model to training a large language model in the bonus module. Here we summarized the key insights from that module. So we can assess which tasks we shall give to GenAI.

GenAI is good at dealing with consensus in the training data because the way it is trained – assigning probability of the next token based on a huge amount of training text. So the more a particular piece of knowledge appears in the training data – mostly text from the internet – the better GPT is about recalling it, and using it. So GPT is good at programming partially because code is structured and predictable, and partially because there is a lot of code as training data fed into GPT. But for less common programming languages, e.g. Rust, GPT is more likely to make mistakes.

For less common facts, GenAI hallucinates, i.e. confidently says something wrong. This is rooted in the underlying mechanism, next token prediction. The model always gives the answer that it is most confident with. To the model, there is no way of knowing the difference between a right answer vs. a wrong answer. In other words, whether a fact is true is never an explicit goal to optimize during training. The correctness is only ensured by the consensus. If it appears often, GenAI will get it right. If not, GenAI just hallucinates.

Hallucination can be controlled by walkarounds outside of the model. For example, New Bing (Copilot) uses search engines to tell the model to construct its answers around the search results. Providing a document as context and constraining the responses of GenAI based on the docs, can also help.


For less common tasks, GenAI says something correct but useless. For example, nothing prevents us from asking GPT how to get rich. It will provide seemingly helpful suggestions. They are correct, but mostly useless. This is again because GPT is trained to output the consensus of the training data. If we expect GPT outputs an email draft that reads smooth and natural, that's a reasonable expectation. Because it's the average level of the books and Internet posts. But if we expect GPT to write an effective marketing email that can make money for us, that's not reasonable. Because this is exceptional content. Emails that can make money are probably among the top 1% of the Internet in terms of quality, rather than the majority or the average.
