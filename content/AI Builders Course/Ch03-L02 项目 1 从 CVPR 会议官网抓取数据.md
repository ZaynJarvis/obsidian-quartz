---
course: AI Builders：从用户到构建者
chapter: 实战项目：五个真实项目
source: https://www.superlinear.academy/c/ai/sections/334458/lessons/1240530
scraped_at: 2026-06-28
video: false
---

# 项目 1：从 CVPR 会议官网抓取数据

## 我的理解

本项目以 CVPR 2024 会议官网为目标，通过解析 HTML 批量抓取论文标题、作者、摘要及 PDF 链接，生成可直接用于搜索引擎或问答机器人的结构化数据集。它揭示了 HTML 在 GUI 与 API 之间充当桥梁的本质——网页以图形界面呈现，但底层纯文本完全可被程序解析和处理。传统数据抓取需要大量编程工作，而借助 AI 辅助生成爬虫代码，只需向 AI 提供少量 HTML 片段，即可显著降低门槛。这正是「批处理」思维的典型体现：先批量采集数据，再对数据进行二次分析和应用，把最耗时的数据准备步骤自动化。

## 相关链接

- [[Ch01-L05 技术洞察 2 GUI 与 API]] — HTML 是 GUI 与 API 之间的桥梁，是本项目的核心概念
- [[Ch01-L04 技术洞察 1 批处理]] — 批量抓取数据后集中处理，是典型的批处理场景
- [[Ch02-L05 理解常见陷阱 文件与网页]] — 网页内容读取与结构化处理的相关陷阱
- [[Ch08-L03 注释驱动编程 让 AI 来填补空白]] — 用 AI 辅助生成爬虫代码的思路与注释驱动编程高度契合

---

## 原文

Lesson 18 of 68
项目 1：从 CVPR 会议官网抓取数据 / Project 1: Extracting Data from the CVPR Conference Website

目标

你的任务是从 CVPR 2024 会议官网抓取并整理数据，网址为 https://openaccess.thecvf.com/CVPR2024?day=all。具体而言，你需要收集论文标题、作者列表、摘要，以及 PDF 或补充材料的链接等信息。

背景与上下文

在模块 1 中，我们讨论了从 GUI 转向 API 的重要性，强调 API 如何实现精确且可扩展的自动化。然而，并非所有网站都提供易于访问的 API。我们所需的数据往往被锁在 GUI 背后，需要我们寻找创造性的方法来获取。

HTML——这门组织网页内容的语言——是 GUI 与 API 之间的桥梁。虽然网站通过图形界面呈现信息，但其底层的 HTML 是可解析、可处理的纯文本。通过理解 HTML 并借助 AI 辅助编程，我们能够高效地从网页中提取数据。

为什么这个项目很重要

在许多 GenAI 应用中，集成数据源至关重要。最耗时的部分往往不是把 GenAI 后端与数据连接起来，而是构建或抓取数据本身。传统上，解析或抓取数据需要大量编程工作，常常涉及繁琐的细节并容易出错。AI 辅助编程简化了这一过程，让即使编程经验有限的人也能自动化完成数据抽取任务。

预期成果

项目结束时，你应当获得一份结构化的数据集，包含从 CVPR 2024 会议官网抓取到的信息。该数据集可以是 JSON 或 CSV 文件，可直接用于各类应用，例如构建搜索引擎或问答机器人。

学习目标

理解 HTML 如何充当 GUI 与 API 之间的桥梁。

熟练使用浏览器开发者工具来检查和操作网页内容。

学会借助 AI 辅助来生成网页抓取代码。

培养从网页中解析数据并将其结构化的能力。

提示与指引

首先，要认识到网页本质上是构建于 HTML 之上的 GUI。在页面上点击右键并选择“查看网页源代码”或“检查”，即可访问底层的 HTML 代码。这些代码以结构化形式包含了网页上展示的全部信息。

使用浏览器的开发者工具检查与你想抓取的数据相对应的元素。例如，你可以识别出包含论文标题或作者列表的 HTML 标签。一旦掌握了大致结构，就可以借助 AI 辅助生成代码，用于解析 HTML 并提取所需信息。

向 AI 提供一些 HTML 代码片段以提供上下文。这有助于 AI 理解网页结构并生成更准确的代码。例如，你可以复制包含某个论文标题及其相关标签的几行 HTML。

English Original

Objective

Your task is to extract and compile data from the CVPR 2024 conference website, available at https://openaccess.thecvf.com/CVPR2024?day=all. Specifically, you will gather information such as paper titles, author lists, abstracts, and links to PDFs or supplementary materials.

Background and Context

In Module 1, we discussed the importance of moving from GUIs to APIs, highlighting how APIs allow for precise and scalable automation. However, not all websites provide readily accessible APIs. Often, the data we need is locked behind GUIs, requiring us to find innovative ways to access it.

HTML—the language that structures web content—serves as a bridge between GUIs and APIs. Although websites present information through graphical interfaces, the underlying HTML is plain text that can be parsed and manipulated. By understanding HTML and utilizing AI-assisted programming, we can extract data from web pages efficiently.

Why This Project Matters

In many GenAI applications, integrating data sources is crucial. The most time-consuming part is often not connecting the GenAI backend with the data but constructing or scraping the data itself. Traditionally, parsing or scraping data requires significant programming effort, often involving intricate details and potential for errors. AI-assisted programming simplifies this process, allowing even those with minimal coding experience to automate data extraction tasks.

Expected Outcome

By the end of this project, you should have a structured dataset containing the information extracted from the CVPR 2024 conference website. This dataset can be in the form of a JSON or CSV file, ready for use in various applications, such as building a search engine or a Q&A bot.

Learning Objectives

Understand how HTML serves as a bridge between GUIs and APIs.

Gain proficiency in using browser developer tools for inspecting and manipulating web content.

Learn how to leverage AI assistance in generating code for web scraping.

Develop skills in parsing and structuring data from web pages.

Hints and Guidance

To begin, recognize that the webpage is essentially a GUI built on top of HTML. By right-clicking on the page and selecting "View Page Source" or "Inspect," you can access the underlying HTML code. This code contains all the information displayed on the webpage in a structured format.

Use your browser's developer tools to inspect the elements corresponding to the data you want to extract. For instance, you can identify the HTML tags that contain the paper titles or author lists. Once you have a sense of the structure, you can use AI assistance to generate code that parses the HTML and extracts the necessary information.

Provide the AI with snippets of the HTML code to give it context. This helps the AI understand the structure of the webpage and generate more accurate code. For example, you might copy a few lines of HTML that include a paper title and its associated tags.
