---
course: AI Builders：从用户到构建者
chapter: 实战项目：五个真实项目
source: https://www.superlinear.academy/c/ai/sections/334458/lessons/1240531
scraped_at: 2026-06-28
video: false
---

# 项目 2：从 Instagram 账号下载图片

## 我的理解

本项目通过下载公开 Instagram 账号的所有图片，展示了如何在严格反爬限制下创造性地获取数据。关键技巧是利用浏览器开发者工具的 Network 标签页，在滚动页面时捕获动态加载的图片 URL，再借助 AI 生成批量下载脚本。与 CVPR 项目解析静态 HTML 不同，Instagram 的动态加载内容需要在网络层抓包，体现了面对不同 Web 技术时灵活应对的能力。整个流程仍是批处理模式：先收集完整的 URL 列表，再统一执行下载，同时全程遵守平台使用规范。

## 相关链接

- [[Ch01-L05 技术洞察 2 GUI 与 API]] — 平台限制 API 获取时，从网络层绕过 GUI 的核心动机
- [[Ch01-L04 技术洞察 1 批处理]] — 先收集 URL 列表再批量下载，是批处理的直接应用
- [[Ch02-L05 理解常见陷阱 文件与网页]] — 动态网页内容加载是网页处理中的常见陷阱
- [[Ch04-L10 心得 4 风险管理]] — 在受限平台操作时需评估合规与伦理风险

---

## 原文

Lesson 19 of 68
项目 2：从 Instagram 账号下载图片 / Project 2: Downloading Images from an Instagram Account

目标

在本项目中，你将下载某个公开 Instagram 账号下的所有图片，例如 Yan 的账号：https://www.instagram.com/grapeot/。

背景与上下文

与许多社交媒体平台一样，Instagram 对自动化数据抓取设有严格限制。申请 API key 往往耗时漫长，平台还部署了多种反爬措施来阻止未经授权的抓取。其 HTML 页面也是动态加载的，对爬虫并不友好。然而，借助开发者工具与 AI 助手的合理使用，你完全可以以合乎伦理且高效的方式从公开账号下载图片。

本项目延续了 Module 1 中关于从 GUI 过渡到 API 的思路，以及 Module 2 中关于理解 GenAI 内部机制与最佳实践的内容。它生动展示了 AI 辅助编程与高效提示词管理如何帮助我们克服实际工作中的障碍。

本项目的意义

从受限平台上自动获取数据是一项很有价值的技能。它体现了你能够创造性地思考、合理利用现有工具来达成目标，同时遵守道德规范的能力。本项目同样强调了理解 Web 技术与开发者工具在数据抓取任务中如何发挥作用的重要性。

预期成果

你应当能够下载指定 Instagram 账号下所有公开可见的图片并保存到本地。这将涉及汇总图片 URL 列表并自动化执行下载流程。

学习目标

学会以合乎伦理的方式应对平台限制。

积累使用浏览器开发者工具进行网络分析的经验。

理解如何处理动态加载的内容。

培养通过 AI 辅助编程来自动化复杂任务的能力。

提示与指引

首先在浏览器中打开这个公开的 Instagram 账号。要意识到，尽管 GUI 是动态展示图片的，但底层数据依然可以被访问到。使用浏览器的开发者工具，特别是“Network”标签页，在你滚动页面时观察被加载的资源——这些资源中就包含图片本身。

Instagram 使用了无限滚动和动态内容加载等技术，这意味着内容不会一次性全部加载出来。为了抓取到所有图片，你可能需要滚动浏览整个页面，让所有图片都加载完成。在此过程中，网络活动会记录下这些图片的 URL。

拿到图片 URL 列表后，你就可以借助 AI 来生成下载脚本。向 AI 说明你所面临的挑战，例如动态加载内容与反爬机制等，以便获得更具针对性的帮助。

English Original

Objective

In this project, you will download all images from a specific public Instagram account, e.g. Yan's account: https://www.instagram.com/grapeot/.

Background and Context

Instagram, like many social media platforms, imposes strict limitations on automated data extraction. Applying for an API key can be time-consuming, and the platform employs anti-bot measures to prevent unauthorized scraping. The HTML page is also dynamic and thus not scraper friendly. However, with the proper use of developer tools and AI assistance, you can ethically and efficiently download images from a public account.

This project builds upon the concepts from Module 1 regarding GUI to API transitions and from Module 2 on understanding GenAI internals and best practices. It exemplifies how AI-assisted programming and effective prompt management can overcome practical obstacles.

Why This Project Matters

Automating the retrieval of data from platforms with restrictions is a valuable skill. It demonstrates the ability to think creatively and utilize available tools to achieve your goals while adhering to ethical guidelines. This project also highlights the importance of understanding how web technologies and developer tools can be leveraged in data extraction tasks.

Expected Outcome

You should be able to download all publicly available images from the specified Instagram account and save them locally. This will involve compiling a list of image URLs and automating the download process.

Learning Objectives

Learn to navigate platform restrictions ethically.

Gain experience in using browser developer tools for network analysis.

Understand how to handle dynamically loaded content.

Develop AI-assisted programming skills for automating complex tasks.

Hints and Guidance

Begin by accessing the public Instagram account in your web browser. Recognize that while the GUI presents images dynamically, the underlying data can still be accessed. Use your browser's developer tools, specifically the "Network" tab, to monitor the assets being loaded as you scroll through the page. These assets include the images themselves.

Instagram employs techniques like infinite scrolling and dynamic content loading, which means that not all content is loaded simultaneously. To capture all images, you may need to scroll through the entire page, allowing all images to load. As you do so, the network activity will record the URLs of these images.

Once you have the list of image URLs, you can use AI assistance to generate a script that downloads them. Provide the AI with information about the challenges you're facing, such as dynamically loaded content and anti-bot measures, to get more accurate assistance.