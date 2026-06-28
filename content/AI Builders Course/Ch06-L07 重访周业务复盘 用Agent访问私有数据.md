---
course: AI Builders：从用户到构建者
chapter: 开源模型与本地化部署（Ollama / Open WebUI）
source: https://www.superlinear.academy/c/ai/sections/443905/lessons/1657499
scraped_at: 2026-06-28
video: false
---

# 重访自动化周业务复盘（WBR）：用 Agent 访问私有数据

## 我的理解

本课将 WBR 从"给实习生的分步指令"升级为"给全职员工的目标描述"：通过 Open WebUI 的 SQLite Agent，仅凭模糊指引即可让 Llama 3.2（仅 3B 参数）自主探索数据库结构、编写 SQL、可视化结果，全程数据不离本地。更进一步的 Model Context Protocol（MCP）让 Claude Desktop 实现了真正的多轮自主决策——无需人工干预，AI 自主规划并逐步调用工具直至完成目标，标志着 AI 从被动工具向主动协作者的跃迁。课程将 AI 使用分为三个层级：纯语言交互、单轮工具调用、多轮自主迭代，每个层级都代表着对人工干预的进一步解放，而工具能力的复合效应远非线性叠加。Agent 接口标准化（MCP）的萌芽也意味着未来 Agent 生态的共享与复用将大幅简化。

## 相关链接

- [[Ch02-L07 案例研究 周度业务回顾 问题分析]] — 原版 WBR 问题分析课，本课正是对其核心思路的 Agent 版重构与大幅升级
- [[Ch02-L08 案例研究 周业务回顾 具体实现]] — 原版 WBR 具体实现课，本课用 Agent 访问私有数据取代了彼时繁琐的手动数据准备流程
- [[Ch02-L06 应用 使用 ChatGPT 的新方式 编辑 而非对话]] — 原版 WBR 依赖"编辑而非对话"技巧构造上下文，本课通过 Agent 多轮决策使这一步骤变得不再必要
- [[Ch06-L05 用 Agent 增强 LLM 能力]] — 本课是上一课 Agent 工具调用概念在完整业务场景中的实战演练，并进一步引入多轮推理

---

## 原文

Lesson 51 of 68
重访自动化周业务复盘（WBR）：用 Agent 访问私有数据 / Revisiting Automated Weekly Business Review (WBR): Using Agents to Access Private Data

在第三模块中，我们以周业务复盘（Weekly Business Review，WBR）为例，演示了上下文窗口管理与“编辑而非聊天”技巧的重要性。其核心思想是把 AI 当作实习生来对待，确保它拥有足够的信息和结构，从而轻松完成任务。相比手动撰写周报，这种方法带来了显著的提升。它让我们能把例行工作交给 AI，把精力聚焦在那些真正需要创造力、能让我们成长并取得成就的任务上。

但这样做一段时间之后，如果你和我一样喜欢琢磨更省事的工作方式，可能仍会觉得这种做法过于繁琐。为什么 AI 只能像实习生一样，机械地完成定义清晰的任务？为什么我们必须替它一步步拆解任务，手动收集并提供所有细节？为什么它不能更聪明、更灵活一些？

就 WBR 这个例子而言，我们需要的所有信息其实都已经在 Excel 文件和 SQLite 数据库里了。与其手动复制粘贴每一列的含义和数据类型，甚至写好现成的 SQL 语句，为什么不能让它自己用工具搞清楚这些细节、自主写查询？如果它能自主检查 SQLite 数据库的数据类型、改写查询、验证结果，并在一切正确时自行决定停止，我们的工作将轻松许多，与 AI 的协作也会更灵活、更轻量。

从更抽象的角度看，这种能力本质上体现在两个方面。

第一，AI 需要能够调用各种工具来独立完成任务。例如，它需要知道如何用 SQLite Browser 或 Python 查看 SQLite 数据库中有哪些表、每张表的字段类型；需要知道如何用 Python 运行程序，并通过命令行输出来定位 bug。

第二，它需要能够独立地做出多步决策，从而有效推进执行。换句话说，它需要能够根据工具输出判断目标是否达成。如果没有，就要决定如何继续——是排查问题继续调试，还是说明信息不足、向人类索取更多信息。

这种高级智能在 GenAI 的远古时代（2023 年）确实很难甚至不可能实现，但今天的 LLM 已完全能够胜任。这就是使用 Agent 的能力。无论是 GPT-4、Claude 3.5 这类闭源模型，还是 Llama 3、QWen 2.5 这类开源模型，如今的 LLM 都能很好地完成工具调用。

本节课中，我们仍以 WBR 为例，但用两种不同的方式来实现，以对比不同的 AI 策略，看看它们能为我们的生活带来怎样的革命性影响。

方法一：通过 Agent 让 Llama 3.2 3B 访问私有数据

在前面的课程中，我们已经接触了 Open WebUI 的工具使用功能。工具可以弥补 AI 的局限性，而连接私有数据源是 AI 的一项重要能力。借助工具，或者说 Agent，我们可以让 Open WebUI 直接访问公司内部的私有数据，让 AI 获得更全面的背景信息，并按需智能地调用它们。

本章中，我们将演示如何利用 Agent，让 AI 在较为模糊的指令下自行查找信息以完成任务。值得一提的是，当前的 LLM 在工具调用上已经相当成熟，甚至有一些专门为工具调用做过优化的小模型。例如，本例使用的 Llama 3.2 3b 参数量仅 30 亿出头，不到最大 Llama 模型的 1%，却能在笔记本、手机乃至 IoT 边缘设备上提供足够流畅、智能的体验。

要让 Llama 3.2 在 WBR 场景下访问我们的私有数据，我们需要一个用于 SQLite 的 Open WebUI Agent。我们可以直接从 Open WebUI 社区网站下载现成的 SQLite Agent。为了演示，我也借助 Cursor 写了一个并分享在这里：https://openwebui.com/t/grapeot/yage_sqlite，可以一键部署。

需要注意的是，在 Open WebUI 这套通用接口下，针对各类数据源的 Agent 是可复用的。例如以后如果想连接另一个 SQLite 数据库文件，只需修改 Agent 的设置，无需从头编写新 Agent。但如果要连接其他类型的数据库，比如 SQL Server，就需要写一个新的 Agent，不过这同样是可复用的。例如，如果有人写了 SQL Server 的 Agent 并分享到 Open WebUI 社区，我们就可以一键部署。

不过，如前面课程所述，这类 Open WebUI 接口存在显著的安全风险，因为它支持任意代码执行。在运行不是自己写的代码之前，必须做细致的安全检查，以防数据泄露或丢失。

部署好我们的 SQLite 访问 Agent 后，可以在命令行执行 ollama pull llama3.2:3b，然后刷新 Open WebUI 界面。在聊天模式中选择 Llama 3.2，点击左下角的加号按钮启用 SQLite 访问 Agent，就可以访问我们的 WBR 示例数据了。

这里跳过了配置过程，因为我们的 Agent 默认会从课程网站下载示例数据。如果你使用的是第三方 Agent，则需要配置相应的 URL，或手动下载并复制到 Open WebUI 中。

配置好聊天窗口后，我们就可以直接与 AI 对话，针对具体数据库提问。例如上图所示，我们首先询问该数据库中有哪些数据表，AI 正确回答有一个 events 表；继续询问该表有哪些字段及类型时，它也能正确作答。这说明 LLM 已经轻松地与我们的私有数据打通了。

这段对话背后发生的事情是：我们通过 Agent 向 LLM 提供了三个工具。第一个问题调用了列出所有数据表的工具，第二个问题调用了列出指定表数据格式的工具。每次回答的最后一行会显示具体调用了哪个工具。这里我们没有一步步替它收集信息，而是 LLM 自己用工具完成了回答。此外，由于 LLM 部署在本地，所有数据都留在我们自己的机器上。

接下来，我们可以让它编写并执行 SQL 查询。由于我们提供的是只读 SQL 查询接口，LLM 成功地获取到了完全正确的数据。在这个 Agent 中，我们没有提供可写查询接口，因此 LLM 无法修改我们的数据库，这在一定程度上保证了数据安全。当然，在实际的生产环境中，我们会希望做更严格的隔离，比如把数据分析与报表所用的数据库与生产数据库彻底分开，并对 LLM 用户角色实施更细致、更严格的权限控制。

最后，我们可以让 AI 编写 HTML 来对这些数据进行可视化。之所以选择 HTML，是因为它可以直接触发 artifacts 功能，让我们在侧边栏预览，无需另行执行 Python。

与第三模块相比，这次我们没有提供现成的 SQL 语句或 Excel 数据透视表，而是直接从数据源出发，给出相对模糊的指引。如果说之前的方式是告诉 AI 怎么做，那么现在的方式就只是告诉它做什么。我们面对的 AI 已不再是实习生，而真正像一位全职员工。

更进一步，通过 Agent 访问私有数据对数据分析意义重大。这种交互式探索让我们可以专注于高层次的抽象思考，而不必频繁打断思路去复制粘贴具体的数据库信息来支撑 AI 写代码。但需要注意的是，在这种高层次思考的场景中，AI 仍然可能产生幻觉。因此，就像对待人类团队成员一样，我们仍需运用之前模块中介绍的技巧，对 AI 的输出结果进行交叉验证，而不是不加核实地照单全收。这一机制对 AI 和人类同样必要。

练习

你能否让 AI 从零开始写一段 Python 程序，实现整个流程的自动化？

思考

当 AI 拥有这种工具使用能力后，在你自己的场景中，你能想到哪些有趣的应用？

方法二：通过 Model Context Protocol 引入多轮思考

上面演示的方法已经比此前的 WBR 做法强大且便捷得多，但仍有两点不足。

第一，这种 AI 仍然是单轮决策。也就是说，AI 一次只走一步。如果它能更主动一些就更好了。比如，我可以撒手不管，只告诉它要做什么，它就会调用相关工具、理解工具输出，并不断迭代，最终达成目标。

第二，构建 Agent 本身依然相当耗时。这里因为我自己写了 SQLite Agent，或者别人写了，我们才能直接复用。然而复用并不像看上去那么简单，它有一个前提：大家要遵守相同的约定或接口。但目前业内并没有公认的统一协议，因此 Agent 的构建以及复用、共享仍存在很大的不确定性。

下面来看一个例子，看看 Claude 是如何解决这两个问题的。这里使用的是 Claude Desktop App。我们通过类似上一节的机制接入了一个 SQLite 访问 Agent，并基于该 Agent 直接发出一个一步到位的请求：“Can you explore the database, and plot how the number of events change over different dates?”

如上图所示，可以看到 Claude 自主调用了多个工具。和我们在前一个例子中一步步引导的过程一样，它先列出该数据库中的所有数据表，再探查 events 表的格式，编写并执行 SQL 查询，最后通过 React 进行可视化。整个过程没有任何停顿或干预（除了出于安全要求的用户确认）。AI 完全自主地完成了规划与决策，并取得了与上一种方法相同的结果。

坏消息是，开源模型目前还不支持这种多轮决策的 Agent，因此在这个具体例子中，我们只能使用闭源的商业模型，无法保证数据完全留在本地。好消息是，这并非 LLM 的能力限制，而是开源工具的实现暂时还没有覆盖这种多轮决策的 Agent。因此，随着 Claude Desktop 推出该功能，我相信开源社区也会很快跟上。

另一个值得关注的点是，Claude Desktop 使用了一种名为 Model Context Protocol 的开放协议，这是 Anthropic 倡导的、用于 Agent 与 LLM 通信的开放标准。它刚刚发布，因此目前只有部分参考实现。本例中使用的 SQLite Agent 就是 MCP 的一个参考实现。它最终能否成为 AI Agent 领域的事实标准仍存在很大不确定性，但至少表明 Agent 接口标准化的进程已经启动。当未来 Agent 接口统一之后，它们的共享与复用也会更加方便。

另一项有趣的技术是 Computer Use。它仍然基于多轮决策 Agent 的基本思想，但有一项相当重要的变化：它提供了用于截屏和鼠标点击操作的 Agent。这类 Agent 与可理解图像的多模态 LLM 结合，使 AI 能够理解图像内容并与图形界面交互。虽然在我们这个具体例子中并不特别重要，但对于其他 GUI 应用的自动化具有深远意义。感兴趣的同学可以在这里阅读更多内容：https://docs.anthropic.com/en/docs/build-with-claude/computer-use。

总结与思考

Agent 是 LLM 一项独特而强大的特性。基于不同的 Agent 能力，LLM 的使用可以分为三个层级。

第一个层级是无法使用 Agent 的传统 AI。在使用这类 AI 时，我们的大部分精力都花在沟通“怎么做”、对问题进行拆解和细化上。但即便如此，我们已经可以通过 Builder's Mindset 和自动化思维显著提升生产力。

当 AI 可以使用工具时，便进入了第二个层级。这意味着许多 AI 自身无法克服的本质性缺陷都能轻松被解决。例如，它可以访问互联网和私有数据。更重要的是，这种工具使用具有复合效应：拥有三种技能的 AI，其生产力远不止单技能 AI 的三倍，三种技能之间的组合往往会在深度和广度上带来指数级的潜力提升。

多轮思考与迭代能力则把 AI 的能力提升到了第三个层级。一方面，它极大地扩展了 AI 的能力边界，让以往需要复杂流程才能完成的事情变得轻而易举。另一项非常重要的影响在于，它显著降低了我们与 AI 之间的交互成本和门槛。过去有些任务可能本就在 AI 的能力范围之内，但因为需要提供复杂的背景知识，我们仍会觉得麻烦，最终选择手动完成。但现在，我们可以只用一句话粗略地说明想让 AI 做什么，它就能自主迭代思考、理解背景知识，最终把任务完成。

因此，Agent 代表着 AI 一次革命性的跃迁。这也是各家公司竞相争夺的焦点。让我们拭目以待，看看 Agent 与 AI 的结合将如何让我们的生活变得更美好。

English Original

In Module 3, we used the Weekly Business Review (WBR) example to demonstrate the importance of context window management and the "edit, not chat" technique. The core idea was to treat AI as an intern, ensuring it has sufficient information and structure to easily complete tasks. Compared to manually generating weekly reports, this method brought significant improvements. It allowed us to delegate routine work to AI while focusing on tasks that truly require our creativity and contribute to our growth and achievements.

However, after doing this for a while, if you're like me and enjoy finding easier ways to work, you might still find this method too cumbersome. Why should AI only function like an intern, mechanically completing clearly defined tasks? Why must we help AI break down tasks step by step and manually collect and provide all the details? Why can't it be smarter and more adaptable?

For the WBR example, all the information we need is already available in Excel files and SQLite databases. Rather than manually copying and pasting the meaning and data type of each column, or even writing a ready-made SQL statement, why can't it use tools to figure out these details and write queries independently? If it could autonomously check SQLite database data types, rewrite queries, verify results, and decide when to stop when everything is correct, this would make our work much easier and make our collaboration with AI more flexible and lightweight.

From a more abstract perspective, this capability is essentially manifested in two aspects.

First, AI needs to be able to call various tools to complete tasks independently. For example, it needs to know how to use SQLite Browser or Python to check what tables exist in the SQLite database, and what the data types are for each table; it needs to know how to run programs using Python and check command line output to identify bugs.

Second, it needs to be able to make multi-step decisions independently to effectively advance execution. In other words, it needs to be able to determine whether goals have been achieved based on tool outputs. If not, it should decide how to proceed—whether to look for issues and continue debugging, or indicate that information is insufficient and request more information from humans.

This advanced intelligence was indeed difficult or even impossible in the ancient times of GenAI (2023), but today's LLMs are fully capable of this. This is the ability to use agents. Whether it's closed-source models like GPT-4 and Claude 3.5, or open-source models like Llama 3 and QWen 2.5, LLMs can now handle tool calls very well.

In this lesson, we'll still use WBR as an example but implement it in two different ways to compare different AI strategies and see what revolutionary impacts they can bring to our lives.

Method 1: Accessing Private Data through Agents with Llama 3.2 3B

Previous lessons introduced us to Open WebUI's tool use functionality. Tools can compensate for AI's limitations, and connecting to private data sources is an important AI capability. Through the use of tools, or what can be called agents, we can let Open WebUI directly access company private data, allowing AI to obtain more comprehensive background information and intelligently call upon it as needed.

In this chapter, we'll demonstrate how to use agents to let AI find information under some vague guidance to complete tasks. It's worth noting that current LLMs are quite advanced in tool calling, and there are even some small models specifically optimized for tool calling. For example, the model used here is Llama 3.2 3b, which has a very small number of parameters of just over 3 billion, less than 1% of the largest Llama model. It can provide sufficiently smooth and intelligent experiences on laptops, phones, and even IoT edge devices.

To let Llama 3.2 access our private data in the WBR context, we need an Open WebUI agent for SQLite. We can directly download an agent for SQLite from the Open WebUI community website. For demonstration purposes, I also wrote one with Cursor's help and shared it here: https://openwebui.com/t/grapeot/yage_sqlite, which you can deploy with one click.

Note that under Open WebUI's universal interface, agents for each data source are reusable. For example, if we want to connect to another SQLite database file in the future, we only need to change the agent's settings without writing a new agent from scratch. However, if we need to connect to other types of databases, such as SQL Server, we would need to write a new agent, but this is also reusable. For instance, if someone has written a SQL Server agent and shared it in the Open WebUI community, we can deploy it with one click.

However, as mentioned in previous lessons, this type of Open WebUI interface has significant security risks because it supports arbitrary code execution. Before running code that you haven't written yourself, detailed security checks are necessary to prevent data leaks or loss.

After deploying our SQLite access agent, we can run ollama pull llama3.2:3b in the command line, then refresh the Open WebUI interface. Select Llama 3.2 in the chat mode and click the plus button in the bottom left corner to enable the SQLite access agent, and you can access our WBR example data.

We've skipped the configuration process here because our agent will download example data from our course website by default. If you're using a third-party agent, you'll need to configure the URL or manually download and copy it into Open WebUI.

After configuring the chat window, we can directly converse with AI and ask questions about specific databases. For example, as shown above, when we first ask what data tables are in this database, AI correctly answers that there's an events table. When asked about what columns and types are in this table, it can also answer correctly. This shows that LLM has easily connected with our private data.

What's happening behind the scenes in this chat is that we provided three tools to LLM through the agent. Here, the first question calls the tool that lists all data tables, while the second question calls the tool that lists the data format of a specific data table. Which tool was called is shown in the last line of each answer. Here, we didn't help it collect information step by step; instead, LLM used tools to answer independently. Additionally, since LLM is deployed locally, all our data stays on our own machine.

Next, we can have it write and execute an SQL query. Because we provided a read-only SQL query interface, LLM successfully obtained the exact correct data. In this agent, we didn't provide a writable query interface, so LLM can't modify our database. This ensures data security to some extent. Of course, in actual production environments, we would want more strict isolation, such as completely separating the database for data analysis and reporting from the production database, and implementing more detailed and strict permission controls for LLM user roles.

Finally, we can have AI write HTML to visualize this data. We chose HTML because it can directly trigger the artifacts feature, allowing us to preview in the sidebar without separately executing Python.

Compared to Module 3, we didn't provide ready-made SQL statements or Excel pivot tables, but rather started directly from the data source with relatively vague guidance. If the previous approach was telling AI how to do something, the current approach is just telling it what to do. The AI we're dealing with is no longer an intern but truly like a full-time employee.

Furthermore, accessing private data through agents is very meaningful for data analysis. This interactive exploration allows us to focus on high-level abstract thinking rather than frequently interrupting our thought process to copy and paste specific database information to support AI's code writing. However, it's worth noting that in this high-level thinking scenario, AI can still have hallucinations. Therefore, like with human team members, we still need to implement the techniques mentioned in previous modules to cross-validate AI's output results rather than adopting them without verification. This mechanism is necessary for both AI and humans.

Exercise

Can you have AI write a Python program from scratch that implements all the functionality for automation?

Reflection

With AI having this tool-using capability, what interesting applications do you see in your scenario?

Method 2: Introducing Multi-Round Thinking through Model Context Protocol

The method demonstrated above is much more powerful and convenient than our previous WBR approach, but it still has two deficiencies.

First, this AI still makes single-round decisions. In other words, AI only moves one step at a time. It would be better if it could be more proactive. For example, I could be hands-off, just tell it what needs to be done, and it would call relevant tools, understand tool outputs, and iterate repeatedly to ultimately achieve the goal.

Second, building agents itself is still quite time-consuming. Here, because I wrote the SQLite agent, or someone else wrote it, we could directly reuse it. However, reuse isn't as simple as it looks; it has a prerequisite that everyone follows the same conventions or interfaces. But currently, there isn't an industry-standard protocol, so the construction and reuse sharing of agents still face great uncertainty.

Let's look at an example here to see how Claude solves these two problems. Here we're using the Claude Desktop App. We connected a SQLite Access Agent through a mechanism similar to the previous section. Based on the agent, we directly make a one-step request: "Can you explore the database, and plot how the number of events change over different dates?"

As shown above, we can see Claude independently called multiple tools. Like we guided in the previous example, it first listed all data tables in this database, then explored the format of the events table, wrote and executed SQL queries, and finally visualized through React. The entire process had no pauses or interventions (except for user confirmations required for security). AI completely conducted autonomous planning, autonomous decision-making, and achieved the same results as our previous method.

The bad news is that open-source models currently don't support this kind of multi-round decision-making agent, so in this specific example, we can only use closed-source commercial models and cannot guarantee data stays local. The good news is that this isn't a limitation of LLMs, but rather that open-source tools' implementation temporarily doesn't include this kind of multi-round decision-making agent. Therefore, with Claude Desktop adding this functionality, I believe the open-source community will quickly catch up.

Another noteworthy point is that Claude Desktop uses an open protocol called Model Context Protocol. This is an open standard advocated by Anthropic for agent-LLM communication. It was just released, so there are only some reference implementations. The SQLite agent we used in this example is a reference implementation of MCP. Whether it will become the de facto standard in the AI agent field still has great uncertainty, but this at least indicates that the process of agent interface standardization has begun. When agent interfaces are unified in the future, their sharing and reuse will become more convenient.

Another interesting technology is Computer Use. It's still based on the basic idea of multi-round decision-making agents, but has a quite important change in that it provides agents for screenshot and mouse click operations. Such agents, combined with multimodal LLMs that can understand images, enable AI to understand image content and interact with GUIs. Although not particularly important in our specific example, it still has profound implications for automating other GUI applications. Interested students can read more about it here: https://docs.anthropic.com/en/docs/build-with-claude/computer-use.

Summary and Reflection

Agents are a unique, powerful special element of LLMs. Based on different agent capabilities, LLM usage can be divided into three levels.

The first level is traditional AI that cannot use agents. In using these AIs, most of our energy is spent communicating how to do something, breaking down and refining problems. But even with such AI, we can already significantly enhance productivity through the Builder's Mindset and the automation mindset.

When AI can use tools, it enters the second level. This means many essential deficiencies that AI alone cannot overcome can be easily solved. For example, it can access the internet and private data. And importantly, this tool usage has a compound effect. For instance, an AI with three skills isn't just three times more productive than a single-skill AI; the combination between these three skills often brings exponential potential growth in depth and breadth.

Multi-round thinking and iteration capability further elevate AI's abilities to the third level. On one hand, it greatly expands AI's capability boundaries, making things that previously required complicated processes easy to achieve. Another very important impact is that it significantly reduces the interaction cost and barriers between us and AI. Previously, some tasks might have been within AI's capabilities, but because they required providing complex background knowledge, we would still find it troublesome and ultimately choose to do it manually. But now, we can just say one sentence broadly stating what we want AI to do, and it can iterate thoughts independently, understand background knowledge, and ultimately complete the task.

Therefore, Agents represent a revolutionary advancement for AI. This is also a focus of competition among various companies. Let's wait and see how the combination of Agents and AI will make our lives better.