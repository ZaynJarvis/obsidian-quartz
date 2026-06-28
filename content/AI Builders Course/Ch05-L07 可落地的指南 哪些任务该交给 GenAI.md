---
course: AI Builders：从用户到构建者
chapter: 模块四：如何思考与抓住 AI 机会
source: https://www.superlinear.academy/c/ai/sections/334462/lessons/1240560
scraped_at: 2026-06-28
video: false
---

# 可落地的指南：哪些任务该交给 GenAI？

## 我的理解

本课将「GenAI 建立在共识之上」转化为四条可操作的决策框架：是否求共识（是→委托）、是否为转换类任务（是→擅长）、是否为事实型而非推理型（事实型→慎用）、是否为重复而非创造性任务（重复→委托）。反直觉之处在于：大多数「设计」其实是重复性工作，而真正的创造是 GenAI 天然无法产出的反共识解决方案。Yan 的亲身经历揭示了过度依赖 AI 的深层危险——你会不知不觉失去评估质量的能力，进而无法发现问题，并将核心判断也拱手相让。永远不要把岗位中的核心价值交给 AI：委托边界不是当前 GenAI 的技术限制，而是其根本性局限。

## 相关链接

- [[Ch05-L06 要点 1 与幻觉共处]] — 与幻觉共处是理解委托边界的前提认知
- [[Ch05-L04 研究 生成式 AI 建立在共识之上]] — 共识理论在此被直接转化为落地指南
- [[Ch04-L04 学习要点 1 有选择地把任务委托给 AI]] — 模块三的委托框架与此形成双视角互补
- [[Ch04-L08 学习 3 评估机制]] — Yan 故事中失去评估能力的教训与评估机制直接对应

---

## 原文

Lesson 43 of 68
可落地的指南：哪些任务该交给 GenAI？/ Actionable guildline: Which tasks shall I delegate to GenAI?

坏消息是，GenAI 不能也不会解决我们所有的问题。但好消息是，这意味着作为一个整体，人类仍然不可替代。然而，部分具体的工作会被取代，与此同时也会涌现出新的职业。发动机的发明并非仅仅把马车夫变成了司机，而是解锁了陆地上运输大宗货物的能力，让现代文明成为可能。我们今天消费的几乎一切，都与发动机有关。

因此，对于 GenAI 这样具有根本颠覆性的技术，我们不应过度聚焦于眼下的细节，而应当用发展的眼光来看待它。否则，如果你只盯着 GenAI 当前最显眼的不足（上下文窗口短、与现有工具集成有限），等下一代能力大幅提升的 GPT 出现，或者整个生态更加成熟之后，你的工作可能很快就会变得无关紧要。

我们的框架忽略 GenAI 暂时不擅长的方面，转而聚焦于 GenAI 的根本性局限。

这是不是一个寻求共识的任务？

这一点立刻可以转化为一条可落地的指南，帮助你判断哪些任务该交给 GenAI：问问自己，“我想要的是不是共识？”如果答案是肯定的，就用 GenAI。如果不是，就用你自己的大脑去拆解问题，然后把那些可以接受共识答案的子问题交给 GenAI。

我们来看几个例子。

对一份给定材料进行总结：这是网上经常出现的任务，因此可以放心交给 GenAI。

了解关于海鲜的基础知识：这是一个很适合交给 GenAI 的任务，因为这些都是互联网上覆盖度很高的常见资料。

了解某种特殊鱼类的研究级专业知识：这就不是互联网上的共识或主流内容，因此 GenAI 很可能会出现幻觉。解决办法是先在网上搜索，然后让 GenAI 来总结搜索结果。

需要创造力或洞察的任务：从定义上看，这类任务就不是共识。所以我们最好依靠自己的大脑来思考，把可自动化的部分交给 GenAI。

这是不是一个“转换”类任务？

有一类任务是 GenAI 特别擅长的：“转换”类任务（transformation tasks），例如：

自然语言之间的翻译——比如英译法

把你的想法从自然语言转换为编程语言（AI 辅助编程）

把一篇冗长的文章转换为简短的版本（摘要）

把精确的、科学性的描述转换为易于理解的风格（向一个六岁孩子解释量子物理）

只要我们对目标语言有明确的描述，GenAI 就能很好地完成任务。它甚至可以适用于一些非常特殊的场景。回想一下我们在课程开头展示的 JIRA API 案例。本质上，我们是发明了一种只有三个词的“语言”，每个词对应一个 Jira API，然后请 GenAI 把我们的自然语言翻译成这种“语言”，结果它做得非常出色。

归根结底，大语言模型本质上就是 Transformer。

我们已经讨论了很多关于在哪里以及如何使用 AI 的内容。经过这两周的时间，相信很多人已经习惯了 AI，并且面对项目时形成了这样的思维方式：“我要不要做点东西来解决这个问题？”这非常好，相信你也会逐渐体会到其中的好处。但有一点需要提醒：恰恰在这个阶段，另一个常见的陷阱也会出现，那就是过度使用 AI 来做所有事情。

这是事实型任务还是推理型任务？

与传统方式——Google、Wiki，甚至 Siri——相比，GenAI 在推理型任务上要强得多，但由于幻觉问题，它在事实型任务上表现并不好。

事实型任务是指那些需要 AI 对某些知识或事实有准确记忆的任务。例如：美国的首都是哪座城市？而推理型任务则更依赖于在给定信息上的推理能力。例如：给定下面这 10 行文本，只保留与地理相关的内容。

需要说明的是，这并不是一个非常科学或严格的划分。许多任务，甚至大多数任务，都同时需要 AI 具备知识和推理或推断能力。但只有部分任务高度依赖对知识的精确回忆。例如，我们不确定 SQL 中表示相等用的是 = 还是 ==，于是去问 AI。要给出正确答案，AI 必须从它的知识里精确地回忆出来，这就是一个事实型任务。而总结一段给定文本的任务，虽然也需要一些关于如何有效总结的知识，但完成这一任务的关键并不在于对某些事实的精确回忆，所以它属于推理型任务。

这是重复性任务还是创造性任务？

一个常见的误解，是把“设计”视为创造性任务，而事实上，大多数“设计”工作都是重复性的——它们是在满足某种特定的客户需求，使用模板或遵循某种既定的工作流程。这类工作的要求不是表达你的艺术，也不是为了创新，而是高效、低成本地完成任务。

所以请认真思考“创造”究竟意味着什么——创新、原创、跳出框框思考、连接看似无关的点、依靠直觉等等。它要求你创造出一个全新的解决方案，而正如我们之前所解释的那样，这样的解决方案是 GenAI 想不出来的。

大多数工作都是重复性任务和创造性任务的混合体。我们在第二模块中提到的 WBR 案例就是一个很好的例子。WBR 中的某些部分——也就是我们自动化的那些环节——是重复性的，而从数据中提炼洞察则是创造性的。把重复性任务交给 GenAI，把你的注意力、精力和时间集中在创造性任务上，你将会得到回报。

陷阱：尊重并发展你的核心竞争力

我（这里是 Yan）想分享一个真实的故事。在密集使用 AI 几周之后，我感觉自己已经是一个高级用户，并且大力提倡用 AI 来做一切事情。写东西的时候，我不再敲键盘，而是对着手机口述：让 AI 先做语音识别，再以条理清晰的方式把核心要点重新组织出来。我用 ChatGPT 起草邮件，当然也用 ChatGPT 写程序，然后不知不觉中陷入了一种奇怪的状态。最先发现问题的是 Yuzhen，他指出我的写作正在退化，有一股“AI 味”。更重要的是，文字比以前更难懂了，因为我用了一些复杂却晦涩难懂的词。我的妻子也抱怨说，我发的邮件，以及那些我可能用 AI 替她起草的邮件，读起来都很怪。她说：“收起你的 AI，我自己写邮件。”“它写出来的东西根本不像人话。”而当我重新审视自己业余项目里的代码时，从表面看它质量很高，注释和文档字符串都很完善，但从专业角度来看，扩展性和可维护性都很差。

于是我突然意识到，我喜欢用 AI，是因为它让我自我感觉良好。即使作为一个非母语者，我也能写出辞藻华丽的文章和邮件；我也能轻松写出严格遵循注释和变量命名规范的程序。我把事情做得又好又轻松，一切看起来都不错，甚至越来越好。

但这其实是一种假象。我的写作其实更难懂，没有真正起到沟通的作用。我的代码也变得更糟，因为更难维护。尤其糟糕的是，我已经失去了自行发现这些问题的能力。因为我已经习惯了让 AI 来做重活、然后复制粘贴结果的生活，已经不熟悉真正的思考了。这让我被 AI 所呈现的“表象”所迷惑——华丽的辞藻、漂亮的注释。这些慢慢地把我的注意力，从真正重要的事情上移开——文字中的情感、代码的质量。更糟糕的是，这种分心进一步降低了我的标准，让我渐渐习惯于把那些 AI 并不擅长的任务也交给它，并在不知不觉中接受了低质量的结果。这其实正是我之所以会成为 AI 的拥护者、心安理得地把一切都交给它的原因——因为我已经失去了评估质量这一关键能力。

这也是我为什么做了一次彻底的反思，并尝试在这里分享我学到的东西。事先定义好成功标准。始终评估 AI 输出的结果。如果注定要失败，就快速失败，而不是接受一个低质量的结果并自我宣告“胜利”。如果你能遵循这些做法，就不太可能落入我曾经掉进去的那些陷阱。

但还有一件事我想额外分享。那就是：我们必须始终清楚自己在岗位中的核心价值是什么，并且永远不要把它交给 AI。原因有两点。一方面，如果 AI 已经能很好地完成你工作中最核心的部分，那么你大概率应该去学点新东西、换一份工作。所以可以合理地假设：AI 还做不好你的核心工作。所幸目前来看仍然如此，因为在大多数情况下，那部分工作需要批判性思维和洞察力，而当前的 AI 仍然欠缺。另一方面，正如我自己的经历所示，人很容易在使用 AI 的便利中迷失，而这种迷失常常会影响（虽然不是完全剥夺）你思考和完成工作的能力。我们不能冒这样的险。

因此，如今对于不重要的邮件，我仍然会让 AI 来代劳。但当我需要表达某种观点、或者影响某个人时，我仍然会亲自敲键盘，或者用我的钢笔来写。但这并不意味着 AI 不再有用。我仍然会用语音识别来加快输入，用 GPT 来纠正语法错误。这相比于 AI 出现之前的我，效率仍然要高得多。

English Original

The bad thing is, GenAI cannot and will not solve all our problems. But the good thing is, it means we humans, as a whole, are still irreplaceable. However, individual jobs will get replaced, and other jobs will emerge. The invention of engines did not just turn coachman to drivers, but unlocked the capacity of lifting tons of cargo across land, and made modern civilization possible. Almost everything we consume today is related to engines.

Therefore, for a fundamentally disruptive technology like GenAI, we shouldn’t be too zoomed in and should take a developing perspective. Otherwise, if you are focused on the most seemingly shortcomes of GenAI (short context window, limited integration with existing tools), after the development of the next generation of GPT that is much more capable, or after the ecosystem becomes more mature, your work can be irrelevant soon.

Our framework ignores what GenAI is temporarily bad at and focus on the fundamental limitation of GenAI.

Is it a consensus?

That immediately translates to an actionable guideline on which task to delegate to GenAI: ask yourself, "is consensus what I want?" If the answer is yes, use GenAI. If not, use your own brain to decompose the problem, and delegate subproblems that accept consensus to GenAI.

Let's take a look at a few examples.

Summarizing a given material: this is a task that appears often online. So OK to delegate to GenAI.

Learn about basic facts about seafood: that's a good task to delegate to GenAI. Because these are common materials that have good coverage on the Internet.

Learn about research level knowledge on a specialized species of fish: this is not the consensus or majority of the Internet. So GenAI is likely to hallucinate. The solution is to first search online, and then ask GenAI to summarize the results.

Tasks that require creativity or insights: this by definition is not consensus. So we'd better rely on our brain and delegate automatable tasks to GenAI.

Is it a transformation task?

There is one specific category of tasks that GenAI is especially good at: the “transformation” tasks, such as

Translating natural languages – English to French

Transform your idea from natural language to a programming language (AI-assisted programming)

Transform from a lengthy article to a brief style (summarization)

Transform a precise and scientific description to an easy-to-digest style (explain quantum physics to a six-year-old)

As long as we have a specific description of the target language, GenAI will do the job well. It even applies to some very specific cases. Think about the JIRA API example we showed at the beginning of the course. Essentially, what happened is we invented a language with only three words, one for each Jira API, and then we asked the GenAI to translate our natural language to that language, and it did the job really well.

After all, large language models are fundamentally transformers.

We've talked a lot about where and how to use AI, and after the two weeks' time, many people must have gotten used to AI and now possess a mindset of asking, "Shall I build something to solve this issue?" to the project they face. This is great, and I'm sure you gradually find out the benefit, but one warning is, it's actually a time when another common pitfall appears, that is overusing AI to do everything.

Is it a factual task or a reasoning task?

Compared to traditional ways – Google, Wiki, or even Siri – GenAI is way better at reasoning tasks, but due to its hallucination, does not do factual tasks well.

Factual tasks are those that require the AI to have an accurate memory of some knowledge or facts. For example, what city is the capital of the US? And reasoning tasks rely more on reasoning capabilities, on the given information. For example, given the following 10 lines of text, only keep the ones that are relevant to geography.

Note, this is not a very scientific or rigorous division. Many or actually most tasks require the AI to have both knowledge and reasoning or deduction capabilities. But only some of them heavily depend on accurate recall of knowledge. For example, we are not sure about whether SQL uses = or == to indicate equivalence. So we ask AI. And to get this right, AI is expected to recall exactly from its knowledge. This is a factual task. For the task of summarizing given texts, it does require some knowledge of how to effectively summarize something. But the key to accomplishing this task doesn't lie in a precise recall of some facts. So it's a reasoning task.

Is it a repetitive task or a creative task?

A common misconception is to consider “design” as a creative task, when in fact, most “design” jobs are repetitive – they fulfill a certain customer demand, using templates or follow a certain workflow. The requirement of the job is not to express your art, or to be innovative, but to complete the task efficiently with low cost.

So think hard on what “creative” means – innovative, original, think outside of the box, connecting the dots, intuitive, and so on. It requires you to create a new solution, and as we explained before, such a solution won’t be thought of by GenAI.

Most work is a blend of repetitive tasks and creative tasks. Our case of WBR from Module 2 is a good example. There are certain parts of WBR – the things that we automated – are repetitive, but drawing insights from the data, is creative. Use GenAI for the repetitive tasks and focus your attention, effort, and time on creative tasks. You will be rewarded.

Pitfall: Respect and Develop Your Core Competency

I (Yan here) want to share a true story here. After a few weeks of extensive use of AI, I felt I'm a power user now, and a big advocate of doing everything using AI. Instead of striking the keyboard, I dictate to the phone when writing, for writing, so the AI first does speech recognition, and then paraphrases the core points in an organized way. I draft emails using ChatGPT. I also write programs using ChatGPT, of course, and then I gradually fall into a weird state without knowing it. Yuzhen first found my writing is degrading; it smells like AI. More importantly, it becomes harder to understand than before because I was using some sophisticated but hard-to-understand words. My wife is complaining that my emails, and the emails I probably drafted for her using AI, read weird. "Put away your AI, and I will write my own emails." "The thing it wrote just doesn't sound like humans," she said. And when I took another look at the code I wrote on my hobby projects, it appeared in high quality with great comments and doc strings, but it lacks extensibility and maintainability from a professional perspective.

So I suddenly realized, I like using AI because it makes me feel good. I can also write articles or emails with sophisticated words even as a non-native speaker. I can easily write programs with strict adherence to the standard practice of comments and variable naming. I'm doing things well and easy. Everything appears fine, only gets better.

But it's actually deceiving. My writing is actually harder to understand and didn't serve the purpose of communication. My coding is also worse because it's harder to maintain. What's especially bad is I lost the ability to discover this by myself. Because I am used to the life of asking AI to do the heavy lifting and copy-pasting the results. I am not familiar with thinking anymore. This makes me distracted by the appearance AI provides. Sophisticated words, beautiful comments. And this gradually dragged my attention from the things that really matter. Affection in the text, quality of the code. What's worse is this distraction further lowered my bar and made me gradually get used to delegating the tests that AI isn't good at to it and got okay on the low-quality results without knowing it. That's actually why I become an advocate of AI and delegate everything to it happily because I lost the key ability of assessing the quality.

That's why I did a thorough reflection and tried to share what I learned here. Defining the success criteria beforehand. Assessing AI's results all the time. If we must fail, fail fast instead of accepting a low-quality result and claiming a victory. If you follow these practices, you're unlikely to fall into the same pitfalls I fell into.

But there is still one extra thing I wanted to share. That is, we need to always be clear about what our core value is in the role in our job and never delegate it to AI. There are two reasons. On one hand, if AI can do your core job well, you probably would want to learn something new and change your job. So it's reasonable to assume AI cannot do your core job well, which is still fortunately true because in most cases, that will require critical thinking and insights, which the current AI still lacks. On the other hand, as shown in my example, it's actually easier to get lost in the ease of using AI, and this loss will often impact (although not completely remove) your capabilities of thinking and doing the job. We don't want to risk that.

Therefore, nowadays, I still delegate email writing to AI for unimportant emails. But when I need to make some point or impact someone, I will still strike the keyboard or use my fountain pen. But that doesn't mean AI is not useful anymore. I still use speech recognition to accelerate typing and GPT to correct any grammar mistakes. And it's still much more efficient than myself in the pre-AI era.