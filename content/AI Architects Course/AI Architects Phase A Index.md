---
course: AI Architects
section: Phase A — 构建最小化 Agentic AI 系统
section_id: '812393'
source: https://www.superlinear.academy/c/aa/sections/812393
scraped_at: 2026-06-27
lessons: 9
---

# AI Architects — Phase A：构建最小化 Agentic AI 系统

> 课程地址：https://www.superlinear.academy/c/aa/sections/812393

## 章节概述

Phase A 是 AI Architects 课程的第一阶段，也是最重要的阶段。目标是从一个空文件夹开始，凭借对 AI 伙伴的熟练驾驭，亲手架构并构建一款本地运行的个人 Agentic AI Web 应用。整章遵循"在实践中试错"的学习哲学，分四章推进：技术选型与基础设施、AI 服务接入与安全、从 Chatbot 到 Agent 的进化、产品化与用户体验。

## 课程列表

1. [[Ch02-L01 视频4 阶段A演示与讲解]] — Phase A 总览视频，四章结构概览
2. [[Ch02-L02 打好基础 FastAPI应用]] — 为何选 FastAPI，用 Cursor 生成骨架
3. [[Ch02-L03 视频5 Builder Space操作演示]] — Builder Space 导览视频
4. [[Ch02-L04 集成核心智能引擎]] — Student Portal 凭证管理，接入 AI 引擎
5. [[Ch02-L05 用Agentic工具扩展能力]] — Agentic Loop，工具调用与多步决策
6. [[Ch02-L06 手动调试Agent的思维]] — 日志侦探，让不可见的思维链可见
7. [[Ch02-L07 用全栈体验闭合产品闭环]] — 构建前端 UI，完成端到端产品
8. [[Ch02-L08 模块小结]] — 心智模型与架构师直觉，Phase B 展望
9. [[Ch02-L09 视频6 构建ChatGPT克隆版]] — Builder Space 实操演示与问答

## 核心洞察

1. **AI 友好性优于性能**：选择 FastAPI 的首要原因不是高性能，而是它自动生成的 openapi.json 让 AI 能直接读懂接口并正确生成调用代码。
2. **知识必须外化为结构化格式**：openapi.json 是"知识外化"原则的完美应用——只有结构化、机器可读的格式，AI 才能可靠地消费并据此行动。
3. **严格契约创造紧密反馈回路**：Pydantic 类型注解让 AI 生成的代码"提早失败、快速失败"，能自我纠错而无需人工干预。
4. **抽象隐藏凭证管理复杂性**：Student Portal 作为统一网关，把多模型 API Key 管理的复杂性藏在一个接口背后，API Key 绝不硬编码。
5. **Agent 的本质是 Agentic Loop**：LLM 自身不能执行工具，它只生成 Tool Call 请求，由你的代码执行后喂回结果，LLM 再决策——这个循环就是 Agent。
6. **让不可见的变得可见**：Agent 以黑箱方式运行是负担而非资产，用 print 打印完整消息历史是培养 Context Engineering 直觉的最根本训练。
7. **Document as a First Deliverable**：API 文档既是测试场也是前端生成的输入，openapi.json 的 URL 直接喂给 Cursor 就能生成完整前端。

## 去冗余说明

原始抓取内容中存在以下冗余，已在笔记中清理：

- **中英双语重复**：每篇课文都包含完整的中文版和英文版（以"English Original"分隔），英文版是中文版的直接翻译。笔记中仅保留中文版原文。
- **UI 噪音**：移除了"Show transcript"等界面元素标记。
- **重复视频链接**：视频课程中 YouTube 链接和"中文版（可以点 CC 加载字幕）"出现两次，已去重。
- **乱码自动转录**：Lesson 18 的自动转录"所 f 如客厅出"为语音识别乱码，已移除。
- **空图片占位**：原文中图片位置的空行已清理。