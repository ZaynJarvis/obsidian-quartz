---
course: AI Builders：从用户到构建者
chapter: 深入原理：LLM 是如何训练出来的
source: https://www.superlinear.academy/c/ai/sections/336476/lessons/1247927
scraped_at: 2026-06-28
video: false
---

# LLM 推理中的 Temperature（温度）参数

## 我的理解

Temperature 控制的是采样前的概率分布“平滑程度”：低温度保留原始分布让高概率词几乎必然被选中，高温度拉平分布让低概率词也有机会被采样，从而产生更多样的创意输出。一个必须纠正的常见误解是：temperature 与幻觉没有直接因果关系——即使 temperature 为零，模型依然会幻觉；幻觉的根源在于训练阶段的噪声机制，而非推理时的采样策略。构建者应根据任务性质选择：事实查询、代码生成适合低温，创意写作、头脑风暴适合高温，降低 temperature 不是修复幻觉的手段。

## 相关链接

- [[Ch05-L06 要点 1 与幻觉共处]] — 澄清“降 temperature 可减少幻觉”的误解，幻觉根源在训练机制而非采样策略
- [[Ch07-L03 嘈杂微调带来的问题]] — 幻觉起源于噪声训练而非 temperature，两节课共同从不同角度澄清幻觉的真正成因
- [[Ch02-L03 理解常见陷阱 偷懒]] — Temperature 设置影响模型输出的保守或发散程度，与调试模型偷懒行为时的参数调节有关

---

## 原文

Lesson 57 of 68
LLM 推理中的 Temperature（温度）参数 / Temperature in LLM Inference

我们经常在 LLM API 的参数中看到“temperature”（温度）。它究竟是什么意思？Temperature 与模型生成输出的方式有关。LLM 使用概率框架来预测下一个 token，产生的是一个概率分布，而不是确定性的输出。例如，模型并不会直接输出“fire”，而是可能给“fire”分配 80% 的概率，给“flame”分配 20% 的概率。随后，采样器（sampler）会基于这个分布来决定最终的预测结果，这也解释了为什么用相同的输入多次运行同一个 LLM，可能会得到不同的结果。

Temperature 的作用是在采样前对概率分布进行平滑处理。当 temperature 为零时，采样器直接使用原始分布。较高的 temperature 会使概率分布变得更平滑，例如把 80-20 的分布改变为 70-30。这会提升那些原本概率较低的 token 被采样到的可能性，从而让 LLM 生成更加多样的结果，表现得更具“创造力”。

因此，Temperature 成为在创造力与准确性之间取得平衡的有效参数。较低或为零的 temperature 往往会产生更可预测的回答；而较高的 temperature 则可能生成本来不太可能出现的句子，从而带来更具创意的输出。

需要特别指出的是，temperature 与幻觉（hallucination）并没有直接关系。即使在 temperature 为零时，LLM 仍然会出现幻觉；同时也没有明确证据表明降低 temperature 会显著降低幻觉发生的概率。即便存在影响，也很难被直接观察到。

English Original

We often see "temperature" in LLM API's parameters. What does it mean? Temperature relates to how they generate output. LLMs use a probabilistic framework to predict the next token, producing a probability distribution rather than a deterministic output. For instance, instead of simply outputting "fire," it might generate an 80% chance for "fire" and 20% for "flame." A sampler then uses this distribution to determine the final prediction, which explains why running the same LLM with identical input multiple times can yield different results.

Temperature affects this process by smoothing the probability distribution before sampling. At zero temperature, the sampler uses the distribution as-is. Higher temperatures smooth out the probabilities, potentially changing an 80-20 split to 70-30, for example. This increases the likelihood of sampling tokens that were originally less probable, potentially making the LLM more creative by generating more diverse results.

Temperature thus becomes an effective parameter for balancing creativity and accuracy. Lower or zero temperatures tend to produce more predictable answers, while higher temperatures can lead to more creative outputs by generating sentences that would be less likely otherwise.

It's important to note that temperature doesn't directly relate to hallucination. LLMs can hallucinate even at zero temperature, and there's no clear evidence that reducing temperature significantly decreases the probability of hallucination. The impact, if any, isn't readily observable.