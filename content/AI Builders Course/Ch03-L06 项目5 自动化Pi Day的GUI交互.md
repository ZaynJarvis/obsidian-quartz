---
course: AI Builders：从用户到构建者
chapter: 实战项目：五个真实项目
source: https://www.superlinear.academy/c/ai/sections/334458/lessons/1240534
scraped_at: 2026-06-28
video: false
---

# 项目 5：自动化 Pi Day Challenge 中的 GUI 交互

## 我的理解

当目标应用没有可用 API 时，GUI 自动化是最后的手段。本项目使用 Python 的 PyAutoGUI 库直接控制操作系统级别的鼠标输入，在 Pi Day Challenge 游戏中按照计算好的圆周坐标序列自动移动鼠标，目标是获得 S 级评级。这与前几个项目的网页数据抓取完全不同：它完全绕开网络层，直接操控屏幕和输入设备，需要根据屏幕分辨率和窗口位置精确校准坐标。项目生动展示了构建者心态的极致表达——理解底层系统机制后，看似不可能被程序控制的游戏也能被自动化，将「玩游戏的用户」彻底转变为「自动化游戏的构建者」。

## 相关链接

- [[Ch01-L05 技术洞察 2 GUI 与 API]] — 无 API 可用时直接操控 GUI 的极端案例，完整展现了 GUI 自动化路线
- [[Ch01-L06 技术洞察 3 从用户到构建者]] — 将「玩游戏的用户」转变为「自动化游戏的构建者」
- [[Ch02-L09 自动化的力量 以及生成式 AI 的角色]] — GUI 自动化作为 GenAI 无法直接触达场景的补充手段
- [[Ch04-L03 第 1 步 识别你工作流程中的瓶颈]] — 识别「无 API 可用」这一瓶颈是解决问题的第一步

---

## 原文

Lesson 22 of 68
项目 5：自动化 Pi Day Challenge 中的 GUI 交互 / Project 5: Automating GUI Interactions in the Pi Day Challenge

目标

你的目标是编写一个程序，自动完成在 Pi Day Challenge 游戏中绘制完美圆形的任务。游戏地址为 https://yage.ai/genai/pi.html。借助自动化工具，争取拿到尽可能高的评级，例如“S”级。

背景与上下文

在前面的模块中，我们讨论过 GUI 的局限性，以及它们给自动化带来的挑战。当没有可用的 API 时，我们必须寻找其他方式来与软件交互。本项目通过直接调用操作系统的输入控制接口，来介绍 GUI 自动化这一概念。

本项目将之前模块中的多个关键概念融合在一起，包括 builder 思维、自动化策略，以及在无法访问 API 时如何突破限制。它展示了：当我们理解底层系统后，就能自动化那些乍看之下似乎不可能完成的任务。

本项目的意义

自动化 GUI 交互拓展了编程能够触及的范围。它证明：即便是没有开放 API 的游戏或应用，也可以通过程序进行操控，这凸显了创新思维和解决问题能力的重要性。

预期成果

完成本项目后，你应当拥有一个能够在 Pi Day Challenge 游戏中绘制近乎完美圆形并获得高评级的程序。这需要通过自动化鼠标移动，来模拟手稳如尺地画圆的动作。

学习目标

理解在没有 API 可用时，如何自动化 GUI 交互。

掌握使用操作系统 API 和自动化库的技能。

提升将程序化动作映射到可视化界面的解决问题能力。

认识 GUI 自动化的潜力与局限。

提示与指引

首先，选择一门带有 GUI 自动化库的编程语言。例如，Python 拥有名为 PyAutoGUI 的库，可用于控制鼠标和键盘。安装所需的库，并确保它们能够正常工作。

计算在游戏窗口内绘制完美圆形所需的坐标。这可能涉及确定圆心和半径，然后沿圆周计算出一系列点，依次将鼠标光标移动到这些位置。

编写脚本，将鼠标光标依次移动到这些计算好的点上，模拟画圆动作。加入适当的延迟，以贴近自然的鼠标运动。测试脚本，并根据屏幕分辨率、窗口位置等因素进行必要的调整。

English Original

Objective

Your goal is to create a program that automates the task of drawing a perfect circle in the Pi Day Challenge game, available at https://yage.ai/genai/pi.html. The aim is to achieve the highest possible ranking, such as an 'S' ranking, by leveraging automation tools.

Background and Context

In earlier modules, we discussed the limitations of GUIs and the challenges they present in automation. When APIs are unavailable, we must find alternative methods to interact with software. This project introduces the concept of GUI automation through direct interaction with the operating system's input controls.

This project brings together several key concepts from previous modules, including the builder mindset, automation strategies, and overcoming limitations when APIs are not accessible. It showcases how understanding underlying systems allows us to automate tasks that seem impossible at first glance.

Why This Project Matters

Automating interactions with GUIs expands the scope of what can be achieved through programming. It demonstrates that even games or applications without accessible APIs can be manipulated programmatically, highlighting the importance of innovative thinking and problem-solving.

Expected Outcome

By the end of this project, you should have a program that can draw a near-perfect circle in the Pi Day Challenge game, achieving a high ranking. This will involve automating mouse movements to replicate the action of drawing with a steady hand.

Learning Objectives

Understand how to automate GUI interactions when APIs are unavailable.

Develop skills in using operating system APIs and automation libraries.

Enhance problem-solving abilities in mapping programmatic actions to visual interfaces.

Recognize the potential and limitations of GUI automation.

Hints and Guidance

To begin, choose a programming language that has libraries for GUI automation. Python, for example, has a library called PyAutoGUI that allows you to control the mouse and keyboard. Install the necessary libraries and ensure they are functioning correctly.

Calculate the coordinates required to draw a perfect circle within the game's window. This may involve determining the center point and radius, then calculating points along the circumference to move the mouse cursor accordingly.

Write a script that moves the mouse cursor to these calculated points, simulating the action of drawing a circle. Include appropriate delays to mimic natural mouse movements. Test your script and adjust as necessary to account for factors like screen resolution and window positioning.