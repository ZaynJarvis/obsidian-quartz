---
course: AI Builders：从用户到构建者
chapter: 模块二：用 AI 构建的五个阶段
source: https://www.superlinear.academy/c/ai/sections/334453/lessons/1240526
scraped_at: 2026-06-28
video: false
---

# 自动化的力量，以及生成式 AI 的角色

## 我的理解

自动化带来的价值远超表面节省的时间，分为三层：消除人为错误（程序不会因疲劳出错）、实现无人值守的定时执行（心安和可靠性本身极有价值）、减轻认知负担（不必“记住去做某件事”就是对注意力最大的节省）。认知负担这一概念尤为值得关注：必须记住执行某个重复任务本身就在消耗有限的脑力，而自动化使这种消耗归零。在 AI 辅助编程出现之前，这种系统性自动化对非开发者几乎不可及；如今普通知识工作者也能将重复操作委托给计算机，腾出精力专注于真正需要专业判断的创造性工作。自动化心态、构建者心态与审慎评估共同构成本模块的思维三角，是从被动用户向主动构建者转变的完整认知框架。

## 相关链接

- [[Ch02-L08 案例研究 周业务回顾 具体实现]] — 本课是 WBR 实现案例的思维升华与价值总结
- [[Ch04-L04 学习要点 1 有选择地把任务委托给 AI]] — 选择性委托是“审慎评估”心态在管理维度的延伸
- [[Ch05-L07 可落地的指南 哪些任务该交给 GenAI]] — 对“哪些任务值得自动化”这一判断的系统化指南
- [[Ch01-L06 技术洞察 3 从用户到构建者]] — 本模块所有内容最终指向这一核心身份转变

---

## 原文

Lesson 16 of 68
自动化的力量，以及生成式 AI 的角色 / The power of automation, and the role of GenAI

在这个例子中，我们运用了本模块所学的几项能力：

建造者心态（Builder Mindset）：面对一个并不完美的工作流，我们没有被动接受，而是考虑了通过“建造”来改变现状的可能性。即使我们并不是专家，也借助 ChatGPT 作为盟友。

审慎评估（Thoughtful Evaluation）：我们没有因为手里握着 GenAI 这把锤子，就把所有问题都当成钉子。相反，我们先通过分析痛点、判断 AI-Assisted Programming 能否解决这些问题，来评估 GenAI 是否是一个好的解决方案。为了更好地回答这个问题，我们做了一次机会规模评估（opportunity sizing），快速探测这些任务对 GenAI 来说是否可行且容易完成。

带着觉察去实现（Implementation with Awareness）：在收到积极信号之后，我们才进入实现阶段。在整个过程中，我们始终对 ChatGPT 的局限保持觉察。例如，我们知道 LLM 的智能可能会随着输出变长而下降。因此，我们一开始就抛出一个较复杂的问题，去试探它的能力边界；同时也做好准备：一旦表现不佳，就把问题拆解开来。我们有意识地管理上下文窗口，有时选择继续对话，有时选择直接修改提示词。

在 AI 的帮助下写完代码之后，我们就拥有了一个可以替我们干活的程序。这个程序并不承担最繁重的部分——核心分析仍由 SQL 查询和 Excel 完成，被高亮的单元格我们也仍需要手动核查。但这个程序起到了“胶水”的作用，而这件事的意义远比看上去更根本：

表面上看，这个程序只是替我们省了一点时间，大约相当于薪水的 1/40。但它做的远不止于此。我们是人，会犯错，尤其是在疲惫或情绪不佳的时候。而程序不会因为疲劳或情绪而出错。即使它 7×24 小时连轴转，每一位数字的计算依然能保证 100% 正确。这是只有编程才能带来的巨大优势。通过减少人为错误，它为我们节省的时间，很可能远不止每周一个小时。

另一个好处是，你现在可以灵活地自动运行或触发这个程序。比如，那条 SQL 查询可能比较复杂，需要跑一个小时。在手动流程下，我们可能得在家里登录电脑，周一早上 8 点启动 SQL 查询，然后再去上班。等 9 点到公司时，查询正好跑完，我们就可以继续复制粘贴。但如果出了岔子——起晚了、早上被孩子折腾得鸡飞狗跳，或者干脆忘了这回事——我们就只能在办公室里干等那一个小时。

而现在，一切都可以自动化。我们可以设定程序每周一上午 8 点自动启动（练习：自己想想该怎么做），然后就把它彻底抛在脑后。每周早上 9 点到办公室时，无论刮风下雨，我们都会看到一份准备好的邮件草稿。这种可靠感和心安，本身就极有价值，甚至比那 1/40 的薪水更有价值。

这种心安带来了第三个好处：减轻认知负担。人对压力很敏感，在没有压力时表现最好。压力不仅仅来自截止日期，需要“记住某件事”同样是一种重要的压力来源。更精确的说法是认知负担（cognitive burden）。和 GPT 一样，我们的大脑算力是有限的。把它消耗在“记得每周一早上 8 点去启动那个任务”上，意味着我们就没法把它用在别的事情上了。

当然，也有一些减轻认知负担的办法，比如把它变成习惯，或者依赖闹钟。但还有什么能比“根本不需要去做”更省心呢？通过自动化，我们节省了脑力。其他自动化能节省更多脑力。当我们逐步用 AI-Assisted Programming 消除这些繁琐、手动、易出错的任务时，我们就可以把注意力集中在真正重要的事情上，在工作中表现得更好。这种生产力的提升，远远超出 1/40 的量级，甚至会影响长期的职业发展。

这就是另一个重要的心态：自动化心态（the automation mindset）。把重复性或操作性的工作交给计算机——哪怕一开始需要投入一些编程精力——其意义远不止节省时间。它让工作变得更可信、更可靠，让我们可以专注于那些真正需要我们专业能力的项目。在前 AI 时代，对大多数非开发者来说，这并不是一个可选项。但有了 AI-Assisted Programming，这一切收益都变得触手可及。我们需要充分利用这一点。

English Original

In this example, we used a few skills we learned in this module:

The Builder Mindset: When facing an imperfect workflow, we didn't just accept it but considered the possibility of changing the situation by building something. Even without expertise, we leveraged ChatGPT as our ally.

Thoughtful Evaluation: We didn't blindly treat this as a nail while holding the hammer of GenAI. Instead, we first evaluated whether GenAI was a good solution by analyzing the pain points and determining if AI-Assisted Programming could resolve them. To better answer this, we conducted an opportunity sizing to quickly probe whether these tasks were feasible and easy for GenAI.

Implementation with Awareness: Once we received positive signals, we proceeded to the implementation stage. Throughout the process, we remained aware of ChatGPT's limitations. For example, we knew that the LLM's intelligence might degrade with longer outputs. Thus, we started with a complicated problem to explore its envelope, while also being prepared to decompose the problem if we encountered suboptimal performance. We intentionally maintained the context window, sometimes choosing to converse, and sometimes choosing to edit the prompts.

After writing the code with the help of AI, we then have a program to delegate our work to. The program doesn't do the heavy lifting; the core analysis is still done by the SQL query and Excel. We also need to manually investigate the highlighted cells. However, the program acts as a glue, and this is a more fundamental change than it appears:

On the surface, the program just saves us some time, which is about 1/40 of our salary. But it does far more than that. We are humans and we make mistakes, especially when we are tired or emotional. Programs, however, don't make mistakes due to fatigue or emotions. Even if they work 24x7, they will still get every digit of calculation 100% correct. This is a significant advantage that only programming can offer. By reducing human errors, it likely saves us more time than just an hour a week.

Another benefit is now you have the flexibility of running or triggering this program automatically. For example, the SQL query might be complicated and take an hour to complete. In the manual workflow, we would probably log in to the computer at home, launch the SQL query at 8 AM on Monday, and then come to work. At 9 AM, it will finish running so we can continue the copy-pasting. If anything goes wrong—like getting up late, dealing with a crazy morning with kids not cooperating, or simply forgetting about it—we will have to wait that hour in the office.

But now, everything can be automatic. We can set the program to start every Monday at 8 AM (exercise: figure out how to do that), and forget about it. When we arrive at the office at 9 AM, every week, rain or shine, we will see an email draft ready. That reliability and peace of mind is also very valuable, probably even more valuable than 1/40 of the salary.

This peace of mind leads to the third benefit: reduction of cognitive burden. Humans are sensitive to pressure and perform best when there is none. Pressure includes more than just deadlines; having to remember tasks is also a significant source of pressure. A more precise term for this is cognitive burden. Like GPT, our brain power is limited. Spending it remembering to launch the job every Monday at 8 AM means we can't focus on something else.

There are ways to reduce cognitive burden, such as making it a habit or relying on an alarm. But what could be better than not needing to do it at all? Through automation, we save brain power. Other automations save even more brain power. As we gradually eliminate these tedious, manual, error-prone tasks using AI-Assisted Programming, we can focus on the things that actually matter and perform much better in our jobs. This improvement in productivity is likely much greater than the 1/40 scale and can even impact long-term career growth.

That's another important mindset: the automation mindset. Delegating repetitive or operational work to computers, even if it might require some initial programming effort, is far more than just saving time. It makes the work more trustworthy and reliable, allowing us to focus on projects that truly need our expertise. In the pre-AI era, this was not an option for most non-devs. But with AI-Assisted Programming, all these benefits become accessible. We need to take advantage of that.