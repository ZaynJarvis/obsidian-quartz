---
course: AI Builders：从用户到构建者
chapter: 模块一：理解生成式 AI 的力量及其驾驭之道
source: https://www.superlinear.academy/c/ai/sections/334452/lessons/1240492
scraped_at: 2026-06-28
video: false
---

# 技术洞察 2：GUI 与 API

## 我的理解

本课阐明了一个根本性区分：GUI 是为人类眼睛和双手设计的，易于使用但难以委托给机器；API 是为计算机精确、可扩展地协作而设计的，功能强大但需要记忆大量细节。GenAI 的出现带来了第三种范式——自然语言——它将 API 的使用门槛降至近乎于零，使批处理、自动化和委托执行对所有人敞开大门。然而这并不意味着自动享有全部收益：移除了编程和记忆的门槛之后，真正的关键仍在于心态与技能的双重升级，这正是后续课程的核心主题。

## 相关链接

- [[Ch01-L04 技术洞察 1 批处理]] — 批处理是 API 能力的第一个具体案例
- [[Ch01-L06 技术洞察 3 从用户到构建者]] — 去除 API 门槛之后，心态转变才是真正的关键
- [[Ch02-L09 自动化的力量 以及生成式 AI 的角色]] — 自然语言调度算力如何驱动自动化，是本课论述的自然延伸

---

## 原文

Lesson 5 of 68
技术洞察 2：GUI 与 API / Technical Insight 2: GUI and API

正如我们刚才所演示的，我们现在拥有了批量处理的超能力。我们可以一次性在 5 个 JIRA 工单上添加评论、创建 10 份电子表格、通知 15 个人，而无需逐个反复、谨慎地点击。这个例子用的是 JIRA，但将其扩展到其他软件也很容易，只要那个软件有 API（应用程序接口，Application Programming Interface）即可。这里正在发生一个根本性的转变。在本节课之前，我们主要依靠软件提供的图形用户界面（GUI，Graphical User Interface）来操作电脑；而我们刚才所做的，则是使用 API 来操作电脑。

这是一个重大的转变，其意义可能比我们意识到的还要深远。让我们花点时间来思考一下。传统上，我们用键盘和鼠标来操作电脑，依赖菜单、按钮和文本框来告诉电脑该做什么。这就是 GUI。它易于使用、对人类友好，因此主导着我们与电脑交互的方式。

但还有其他选择。在一个应用内部，或在不同应用之间，存在着另一种接口，叫做应用程序接口（API）。API 才是电脑之间本应使用的交互方式。它们是为精确性、可扩展性和效率而设计的。开发者使用 API 来让不同的软件系统协同工作。一个例子是你可能听说过的 Microsoft Office 中的宏。宏让我们可以在 Excel 表格中编写简单的程序，从而实现我们刚才那样的批量处理。

所以一句话总结：GUI 是给人用的，API 是给电脑用的。然而，二者之间还有一个更深层的差别：把你的操作委托出去的难易程度。GUI 是为眼睛理解、为双手操作而设计的，因此把 GUI 操作委托给别人，意味着这个“别人”必须是人。相反，API 是为电脑设计的，实际上正是为委托给电脑而设计的，这赋予了它更大的灵活性。举个例子，一个 for 循环加上一个 API 就能完成批量处理。

换句话说，API 是直接发挥电脑全部能力的途径，代价是易用性的下降。API 难用不仅因为它需要编程，还因为有太多东西要记。再看看 ChatGPT 写的那段在 JIRA 工单上添加评论的 Python 程序：我们需要记住或者去查那个核心的 Python 函数 jira.add_comment，它有两个参数，第一个是 issue，第二个是要添加的 comment。细节实在太多，很容易出错。这就是为什么即使是专业开发者，在需要使用 API 时也会犹豫，更不用说非开发者了。

但有了 GenAI，我们可以依靠它来替我们写程序。正如我们之前所看到的，它在记忆所有细节、写出可运行的程序方面做得非常出色。这是一个根本性的变化。除了 GUI 和 API 之外，我们现在拥有了第三种渠道、第三种范式来与电脑交互——使用自然语言。GenAI 把我们用自然语言下达的指令翻译成 API 和程序，也就是电脑的语言。

这一下子向我们所有人敞开了 API 的大门，连带着它所带来的所有好处：批量处理、自动化、委托执行等等。然而，这并不意味着我们就能自动享受到所有这些好处、释放电脑的全部潜能。对于非开发者来说，编程和记忆方面的门槛确实被移除了，但故事并未就此结束。归根结底，我们仍需学习如何在心态和技能两方面有效地运用这一新范式，来增强我们的工作。接下来的课程将帮助你为此做好准备。

English Original

As we just demonstrated, we now have the superpower of batch processing. We can comment on 5 JIRA tickets, create 10 spreadsheets, and notify 15 people without repetitive and careful clicks. The example involved JIRA, but extending this to other software is easy, as long as it has APIs, or Application Programming Interfaces. There is a fundamental change happening here. Before this lesson, we mostly relied on Graphical User Interfaces, or GUIs, provided by the software to operate our computers. But what we just did was use APIs to operate our computers.

This is a significant change, probably bigger than we realize. Let's reflect on that for a moment. Traditionally, we use a keyboard and mouse to operate computers. We rely on menus, buttons, and text boxes to tell computers what to do. This is GUI. It's easy to use, human-friendly, and that's why it dominates the way we interact with computers.

But there are alternatives. Within an app, or between different apps, there's another interface called Application Programming Interface (API). APIs are how computers are supposed to interact. They are designed for precision, extendability, and efficiency. Developers use APIs to make different software systems work together. One example is macros in Microsoft Office, which you might have heard of. Macros allow us to write simple programs in an Excel sheet and perform batch processing like we just did.

So in one sentence: GUI is for humans, API is for computers. However, there's a deeper difference: how difficult it is to delegate your operations. GUI is designed for eyes to understand and hands to operate, so delegating GUI operations to someone else means it has to be a human. On the contrary, API is designed for computers and actually designed for delegation to computers, which gives it greater flexibility. For example, a for loop plus an API can handle batch processing.

In other words, API is a direct way to tap into computers' full capabilities, at the cost of ease of use. APIs are hard to use not only because they require programming, but also because there are many things to memorize. Just take another look at the Python program ChatGPT wrote to add comments on JIRA tickets. We need to remember or look up the core Python function called jira.add_comment. It has two parameters: the first one is an issue, and the second one is the comment to add. There are simply too many details, and it's very easy to get something wrong. That's why even professional developers hesitate when they need to use APIs, not to mention non-developers.

But with GenAI, we can rely on it to write programs for us. As we saw before, it does an excellent job in memorizing all the details and writing a functional program. This is a fundamental change. In addition to GUI and API, we now have a third channel, a third paradigm, for interacting with computers—using natural language. GenAI translates our natural language instructions into APIs and programs, the computer's language.

This suddenly opens the door of API to all of us, along with all its benefits: batch processing, automation, delegation, and more. However, it doesn't mean we can automatically enjoy all the benefits and unlock the full potential of our computers. For non-developers, the barrier of programming and memorizing is indeed removed, but that's not the end of the story. Ultimately, we still need to learn how to use this new paradigm effectively to enhance our work, in terms of both mindset and skill set. The next lessons will help you get prepared for that.