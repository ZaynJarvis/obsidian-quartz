---
course: AI Builders：从用户到构建者
chapter: 用 Cursor 进行 AI 编程
source: https://www.superlinear.academy/c/ai/sections/427052/lessons/1599894
scraped_at: 2026-06-28
video: false
---

# 注释驱动编程：让 AI 来填补空白

## 我的理解

注释驱动编程将代码注释从写给人看的说明转变为写给 AI 的提示词，开发者只需在需要实现的位置写下描述性注释或 docstring，按 Tab 键后 Cursor 便将自然语言转化为可运行代码。这种范式的核心价值在于认知层级的提升：开发者从与语法搏斗的执行者转变为在概念层面塑造程序的设计者，AI 负责处理重复的样板代码，人类心智带宽得以释放给更深层的架构难题。注释与代码之间形成双向循环——调整注释即可重塑输出，迭代轻盈而直觉化，是进入 AI 协作编程最自然的第一步。

## 相关链接

- [[Ch08-L04 面向提示词的编程 通过对话写出更好的代码]] — 从注释驱动进阶到对话式编程的自然延伸
- [[Ch08-L02 Cursor 入门 你的 AI 编程搭档]] — 三种范式的整体框架与工具基础
- [[Ch04-L06 学习 2 面向 AI 的文档管理]] — 结构化文档与注释作为 AI 沟通媒介的同源逻辑
- [[Ch05-L07 可落地的指南 哪些任务该交给 GenAI]] — 判断哪些代码任务适合用注释驱动委托给 AI

---

## 原文

Lesson 61 of 68
注释驱动编程：让 AI 来填补空白 / Comment-Oriented Programming: Let the AI Fill in the Gaps

在 Cursor 出现之前，代码注释主要写给人看。如今，它们已成为巧妙的提示词，帮助你的 AI 伙伴生成逻辑与结构。你只需在该写函数的位置写下一段描述性注释，或为某个类添加概括其用途的 docstring。当你按下 Tab 键时，Cursor 便会立刻响应。它会把你用自然语言写下的说明转译为可运行的代码，由此形成一种新的工作方式：你专注于思考任务本身，由 AI 来处理语法细节。

来看一个简单的例子。你可能写下这样一段注释：“计算两个数值中的最小值并返回较小者。”Cursor 读取后理解你的意图，并给出推断：一个简洁的 min 函数。几乎瞬间，你就得到了实现干净的解决方案。如果你希望采用更高效的写法或不同的命名风格，只需调整注释，Cursor 就会随之适配。这种双向循环意味着，你不再逐行编写代码，而是在概念层面塑造程序，然后看着它逐步成形。

不妨把这种思路延伸到简单函数之外。你的注释可以勾勒出整个类的结构，描述其属性、方法以及预期行为。你写下一段简短的 docstring 作为铺垫，Cursor 便会生成构造函数、初始化器和辅助函数的骨架。寥寥几次按键，一份复杂的蓝图就化为可立即运行的代码。当你看到 AI 替你处理重复的样板代码时，你会意识到，这让你的心智带宽得以解放，可以投入到更深层的架构难题上，而不是与语法搏斗。

再试着把复杂度往上提一档。假设你为一条数据转换流水线写下注释，说明输入数组应当先被过滤、再被映射，最后归约为一个汇总指标。Cursor 会按这一步骤序列，生成它认为你想要的循环结构、lambda 表达式或库函数调用。如果结果不够准确，也无妨——只需微调注释或补上一句澄清说明即可。渐渐地，你会培养出一种直觉，懂得如何表述这些指令，让 AI 的输出更贴近你的真实意图。久而久之，你会越来越善于把注释视为开发过程中的一等公民——一种既写给自己、也写给 AI 的表达媒介。

English Original

Before Cursor, code comments were mostly for human readers. Now, they serve as clever prompts that help your AI partner generate logic and structure. Start by writing a descriptive comment where a function should be, or add a docstring that summarizes the purpose of a class. As you press Tab, watch Cursor spring into action. It translates your plain-language commentary into working code, and the result is a workflow where you think in tasks and the AI handles the syntax.

Consider something straightforward. You might write a comment: “Calculate the minimum of two values and return the smaller.” Cursor reads this, understands it, and forms a guess: a simple min function. You get a cleanly implemented solution almost instantly. If you want a more efficient approach or different naming conventions, just refine your comment and let Cursor adapt. This two-way loop means that instead of thinking line by line, you shape the code at a conceptual level and watch it materialize.

Imagine extending this idea beyond simple functions. Your comment might outline an entire class structure, describing attributes, methods, and expected behaviors. You write a brief docstring to set the stage, and Cursor responds with scaffolding for constructors, initializers, and helper functions. With a few keystrokes, a complex blueprint transforms into ready-to-run code. As you see the AI handle repetitive boilerplate, you’ll realize this frees up your mental bandwidth for solving deeper architectural challenges rather than wrestling with syntax.

Try stepping up the complexity a notch. Suppose you comment on a data transformation pipeline, noting that input arrays should be filtered, mapped, and then reduced to a summary statistic. Cursor will take that sequence of steps and create the loop structures, lambda expressions, or library calls it thinks you mean. If it isn’t quite right, no problem—just tweak the comment or add a clarifying sentence. Slowly, you’ll develop an intuition for how to phrase these instructions so that the AI’s output aligns more closely with your intent. Over time, you’ll become adept at treating comments as a first-class aspect of your development process, a medium for communicating ideas both to yourself and to the AI.
