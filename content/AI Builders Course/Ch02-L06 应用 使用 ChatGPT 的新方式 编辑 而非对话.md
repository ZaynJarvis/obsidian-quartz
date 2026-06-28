---
course: AI Builders：从用户到构建者
chapter: 模块二：用 AI 构建的五个阶段
source: https://www.superlinear.academy/c/ai/sections/334453/lessons/1240521
scraped_at: 2026-06-28
video: false
---

# 应用：使用 ChatGPT 的新方式——编辑，而非对话

## 我的理解

ChatGPT的聊天界面通过追加历史对话构建上下文窗口，这一设计虽制造了“有记忆”的错觉，却使上下文充斥无效回答和散乱请求——这才是AI显得又笨又懒的内在原因，而非模型本身的问题。解决方案是放弃被动聊天模式，主动利用“编辑”功能把所有要求整合进同一段prompt：让GPT始终只看到一轮对话，将全部算力集中在核心问题上。这个手动构造的prompt还有额外价值：它天然成为可复用的任务模板，将积累的prompt engineering修复方案永久内嵌，下次直接复用。这是从“用户”向“构建者”转变的重要方法论标志——不再被工具的默认交互模式限制，而是主动设计信息流动方式。

## 相关链接

- [[Ch02-L04 理解常见陷阱 遗忘]] — 遗忘陷阱正是“编辑”方法要解决的核心问题
- [[Ch02-L05 理解常见陷阱 文件与网页]] — 文件陷阱同样需要主动管理上下文中的信息质量
- [[Ch02-L08 案例研究 周业务回顾 具体实现]] — WBR实现中综合运用了编辑与对话的切换判断策略
- [[Ch08-L04 面向提示词的编程 通过对话写出更好的代码]] — Cursor环境中对prompt构造与管理的进阶方法

---

## 原文

Lesson 13 of 68
应用：使用 ChatGPT 的新方式——编辑，而非对话 / Applicaiton: New way to use ChatGPT -- Edit, not chat

既然我们已经理解了上述行为背后的不同成因，那解决方案是什么呢？其实答案非常简单：主动管理我们的上下文窗口（context window）。

我们先来看一个简单的例子，理解使用 ChatGPT 时上下文窗口里会发生什么。

首先，我们向 GPT 提出了一个简单的问题，但得到的回答相当简短且帮助有限。于是我们追加了一个要求：不要使用云存储。GPT 看似一时理解了这一点，但在第三轮对话中，它立刻忘记了我们的要求，又把“云存储（Cloud Storage）”作为第三个选项推荐给了我们。这是一个非常典型的场景：AI 看起来既懒又不聪明，丢失了细节和要求。

如果我们按照之前学到的方法去检查上下文窗口的内容，会发现两个问题。

第一，上下文窗口中的绝大多数内容是 GPT 给出的误导性或错误的回答。这一点显而易见——因为只要我们对答案满意，就会停止追问！所以 ChatGPT 这种巧妙的小把戏，反而让上下文窗口里塞满了具有误导性的信息。这就让 GPT 的处境变得更糟：它需要额外消耗智力或“脑力”，去判断哪些内容仍然适用于最新的需求，哪些内容需要被纠正。





第二，我们的请求也是零散分布的。第一个问题里我们询问复制文件的方法，接着补充说不能上传到云端，最后又额外提供信息说我们要从 Mac 复制到 PC。这同样让 GPT 的处理更困难，因为它会被干扰，难以识别真正的需求究竟在哪里。





所以核心问题就在这里。ChatGPT 用一种非常简单的方式为底层的 GPT 构造上下文窗口：把聊天历史不断追加到上下文窗口里。从产品层面看，这种做法非常巧妙地营造出“有记忆”的错觉，但代价是上下文窗口的质量极差。随着对话的推进，上下文窗口里不可避免地会充满误导性的回答和零散的请求。这就是你看到的 AI 显得又笨又懒的内在原因。





解决方案很简单。既然我们已经理解了底层运作机制，那就别再依赖 ChatGPT 自带的上下文窗口，而是自己来做上下文窗口的管理。让我们亲自构造提示词（prompt），这样就可以剔除误导性的回答，并把请求整合在一起。实际上，这就像我们在带实习生时会做的事：减少干扰，提清楚需求。





这里有一个 UI 上的小技巧可以做到这一点：我们可以利用 ChatGPT 的编辑功能进行迭代。在前面那个补充“不能上传到云端”的例子中，我们可以直接点击下图中的铅笔按钮，编辑发给 ChatGPT 的提示词。





然后在那里编辑提示词，并点击“Save and Submit”按钮，就能获得一个新的回答，如下图所示。注意我们只是把第二轮的提示直接追加到末尾。这就是我们对 ChatGPT 回答的“回应”——与其通过对话来回交流、冒着上下文窗口越来越乱的风险，不如直接把这个新需求并入最初的指令/提示词中。这样我们就拥有了一个干净、完整反映我们意图的上下文窗口。





类似地，我们可以继续迭代，最终得到这样一段提示词：



它相当于把我们对 ChatGPT 的所有要求做了一份汇总。这种做法可以有效缓解“遗忘/笨/懒”等问题，因为此时 ChatGPT 看到的只有一轮对话，可以把全部智力都集中到核心问题的解决上。同时我们仍然保留了渐进式迭代的自由。它还有另一个重要好处：这实际上变成了一个可复用的模板，把我们针对 ChatGPT 常见问题积累的提示工程修复方案都嵌入其中。下次再做同类任务时，直接复制粘贴这段提示词即可。而如果你只是用对话方式使用 ChatGPT，这一点是无法做到的。

English Original

While we understand the different causes to the observed behavior, what is the solution to that? The solution is actually pretty simple: manage our context window proactively.

Let's first take a look at a simple example to understand what happens to the context window when we use ChatGPT.

First, we asked GPT a simple question, and got quite short and unhelpful answers. So we added an extra requirement of not using cloud storage. GPT seemed to understand that for a moment, but in the third conversation, it immediately forgot about what we asked, and suggested "Cloud Storage" as the third option. It's a typical case where the AI appears lazy and not smart. It lost track of details and requirements.

If we follow what we learned and check the content of the context window, we will find two problems.

First, the majority of the context window is misleading or wrong answers from GPT. That's obvious because if we are satisfied with the answer, we will stop there and not ask questions! So the clever trick ChatGPT uses actually makes the context window full of misleading information. And this makes GPT's life harder. It needs to spend extra intelligence or "brain power" to figure out which part is applicable to the latest requirement, and which part needs to be corrected. 





Second, our requests are also scattered around. We ask ways to copy files in the first question, and then add that we cannot upload to the cloud. In the final question, we then provide extra information that we try to copy from a Mac to a PC. This again, makes GPT's life harder. Because it gets distracted to recognize where the actual requests are.





So here is the core problem. ChatGPT uses a simple way to construct the context window for the underlying GPT: appending the chat history to the context window. It's very clever in terms of giving an illusion of memory on the product level, but results in very poor quality in the context window. When the conversation progresses, it's inevitable to result in a context window full of misleading answers and scattered requests. That's an intrinsic reason why you see a dumb and lazy AI.





The solution is simple. Instead of relying on ChatGPT's context window, let's do the context window management given we now understand how it works under the hood. Let's construct the prompt by ourselves, so the misleading answers can be removed, and the requests can be consolidated. Actually this is what we will do for our intern: reduce distractions, and make clear requests.





And there is a UI trick to do this: we could use ChatGPT's editing feature to iterate. In the previous example of adding an extra information of we cannot upload to the cloud, we could simply edit the prompt of ChatGPT by clicking the pencil button in the following screenshot. 





Then we can edit the prompt there and click the "Save and Submit" button to get a new answer, as the following screenshot shows. Note how we simply append the second round's prompt to the end. That's our response to ChatGPT's answer. Instead of having a conversation to it and risking a messy context window, we simply add the request in our initial instruction / prompt. So we have a clean context window exactly reflecting our intention.





Similarly, we could further iterate and end up with this prompt:



This acts as a summary of our requirements to ChatGPT. It could effectively alleviate the forgetting / dumb / lazy issues, because ChatGPT only sees one round conversation here, and can spend all its intelligence on the core problem solving. Yet we still have the freedom of iteration progressively. It has another important benefit that this effectively becomes a reusable template, embedding our prompt engineering fixes to all the common problems we got from ChatGPT. So next time when we need to do the same task, we can just copy paste this prompt. And this is not possible if we use ChatGPT with conversations.
