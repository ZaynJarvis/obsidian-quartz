---
course: AI Builders：从用户到构建者
chapter: 实战项目：五个真实项目
source: https://www.superlinear.academy/c/ai/sections/334458/lessons/1240532
scraped_at: 2026-06-28
video: false
---

# 项目 3：用 Bookmarklet 增强网页搜索

## 我的理解

Bookmarklet 是以书签形式保存的 JavaScript 代码，点击即可在当前页面上下文中执行，无需安装任何扩展或软件。本项目构建了一个「一键重定向搜索引擎」的 bookmarklet：从当前 URL 提取查询参数 q，构造目标搜索引擎的新 URL 后跳转，仅需数行 JavaScript。这个项目轻量却深刻——它说明浏览器本身就是功能完备的自动化平台，不依赖重型框架也能解决真实痛点。它是「从用户到构建者」最直观的案例之一：你把一个重复手动操作变成了一个可复用的小工具，提升了自己的日常工作流效率。

## 相关链接

- [[Ch01-L05 技术洞察 2 GUI 与 API]] — 利用浏览器内置能力实现自动化，无需依赖外部 API
- [[Ch01-L06 技术洞察 3 从用户到构建者]] — 将重复手动操作变成可复用工具，典型的用户到构建者转变
- [[Ch02-L09 自动化的力量 以及生成式 AI 的角色]] — 自动化日常重复搜索操作，体现自动化力量
- [[Ch08-L04 面向提示词的编程 通过对话写出更好的代码]] — 借助 AI 对话生成 bookmarklet 代码的方式

---

## 原文

Lesson 20 of 68
项目 3：用 Bookmarklet 增强网页搜索 / Project 3: Enhancing Web Search with Bookmarklets

目标

构建一个工具，在搜索结果不满意时，将当前搜索查询一键重定向到其他搜索引擎，从而提升网页搜索体验。例如，当你对 Google 的结果不满意时，可以迅速用同样的关键词在 DuckDuckGo 或其他搜索引擎上重新搜索。

背景与情境

在前面的模块中，我们反复强调效率与自动化的重要性。本项目将引入 bookmarklet（小书签）的概念——它是一种以书签形式保存的小型 JavaScript 程序，可以直接修改网页或在浏览器中自动执行任务。

本项目延续了我们在此前课程中讨论过的观点：浏览器是自动化的强力盟友。理解并善用 bookmarklet，你无需复杂的扩展或软件，就能定制自己的浏览体验、提升生产力。

为什么这个项目很重要

我们常常会对搜索结果不满意，然后手动切换到其他搜索引擎，重新输入相同的查询。把这个过程自动化能节省时间，让工作流更顺畅。本项目展示了一个简单的小工具如何对日常任务产生显著影响。

预期成果

完成本项目后，你将拥有一个 bookmarklet：点击它即可将当前的搜索查询重定向，或在新标签页中用另一个搜索引擎打开同样的查询。这个工具会增强你的浏览体验，并展现简单 JavaScript 自动化的威力。

学习目标

获得使用 JavaScript 进行客户端脚本编写的实战经验。

学习如何创建并使用 bookmarklet。

理解如何通过代码与网页交互并对其进行操作。

通过自动化日常任务提升解决问题的能力。

提示与指引

首先，了解 bookmarklet 的工作原理。bookmarklet 本质上就是一个书签，只是其中保存的不是普通 URL，而是 JavaScript 代码。当你点击它时，这段 JavaScript 会在当前页面的上下文中执行。

编写一个 JavaScript 函数，从搜索引擎的 URL 中获取当前的搜索查询。例如，Google 的搜索 URL 中包含查询参数 q，形如 https://www.google.com/search?q=your+search+terms。你的代码应当提取 q 的值，并据此构造一个指向目标搜索引擎、携带相同查询的新 URL。

写好 JavaScript 代码后，在浏览器中新建一个书签。在 URL 字段中，先加上前缀 javascript:，然后把代码粘贴在它之后。这样，这个书签就变成了一个 bookmarklet，你可以在搜索结果页上随时点击它来触发。

English Original

Objective

Create a tool that enhances your web search experience by redirecting search queries to alternative search engines when the results are unsatisfactory. For instance, if you are not satisfied with Google's results, you can quickly perform the same search on DuckDuckGo or another search engine.

Background and Context

In previous modules, we emphasized the importance of efficiency and automation. This project introduces the concept of bookmarklets—small JavaScript programs stored as bookmarks—that can modify web pages or automate tasks directly from your browser.

This project reinforces the idea that browsers are powerful allies in automation, as discussed in earlier lessons. By understanding and utilizing bookmarklets, you can customize your browsing experience and improve productivity without the need for complex extensions or software.

Why This Project Matters

Often, we find ourselves dissatisfied with search results and manually navigating to other search engines to repeat our queries. Automating this process saves time and streamlines your workflow. This project demonstrates how a simple tool can have a significant impact on daily tasks.

Expected Outcome

By the end of this project, you will have a bookmarklet that, when clicked, redirects or opens a new tab with your current search query on an alternative search engine. This tool enhances your browsing experience and demonstrates the power of simple JavaScript automation.

Learning Objectives

Gain practical experience in client-side scripting with JavaScript.

Learn how to create and utilize bookmarklets.

Understand how to interact with and manipulate web pages using code.

Improve problem-solving skills by automating routine tasks.

Hints and Guidance

To start, familiarize yourself with how bookmarklets work. A bookmarklet is essentially a bookmark that contains JavaScript code instead of a traditional URL. When you click the bookmarklet, the JavaScript code executes in the context of the current page.

Write a JavaScript function that captures the current search query from the URL of your search engine. For example, Google's search URL includes the query parameter q, such as https://www.google.com/search?q=your+search+terms. Your code should extract the value of q and construct a new URL for the alternative search engine with the same query.

Once you have the JavaScript code, create a new bookmark in your browser. In the URL field, prefix your code with javascript: and paste the code after it. This turns the bookmark into a bookmarklet that you can click while on a search results page.