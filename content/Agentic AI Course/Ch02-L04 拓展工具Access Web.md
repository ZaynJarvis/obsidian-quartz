---
course: Agentic AI的原理与实践
chapter: 第二章：深入理解 Cursor 的三大思维模式与高级魔改
source: https://www.superlinear.academy/c/agentic-ai/sections/451912/lessons/1685935
scraped_at: 2026-06-27
---

# 第四课：拓展工具：引入搜索 / 爬虫实现 Access Web

## 我的理解

本课解决的是 Cursor 默认"困在编辑器里"的痛点：通过把搜索（DuckDuckGo）和爬虫（requests+BeautifulSoup 或 Playwright）封装成脚本，再在 .cursorrules 中声明调用方式，AI 就能在 Agent 模式下自主选择并执行这些"外部工具"。关键模式是把任意外部能力拆解为"输入-执行-stdout 输出"的脚本单元，让 AI 把 stdout 当作新的上下文继续推理。本课最具启发性的一点是搜索与爬虫可被 AI 自动组合调度，先搜后爬再汇总成 Markdown，呈现多工具协同的多步决策。这背后的通用原则是：只要把流程脚本化并写进 .cursorrules，AI 就能逐步"长出"无所不能的工具集，从语言文字回答进化到真正影响外部世界。

## 相关链接

- [[Ch02-L01 三种编程思维]]
- [[Ch02-L05 对比Devin]]
- [[Ch02-L06 Cursor配置教程]]
- [[Ch02-L00 引言]]

---

## 原文

Lesson 11 of 18
第四课：拓展工具：引入搜索 / 爬虫实现 Access Web

在上一节，我们已经看到了 .cursorrules 文件可以帮助 Cursor 保持自我迭代和“长期记忆”，让它在面对比较复杂的改动时也能有条不紊地完成工作。可是一旦我们想把这个“编程小管家”派去“外面看看世界”，让它获取互联网上的最新信息、自动搜索或是对某些网页做爬虫分析，Cursor 默认就会显得有点力不从心。尤其当我们需要跨网站抓取数据，再批量合并成一份 Markdown 汇总文档时，传统的“手动抄”或者“反复来回复制粘贴”操作就会让人抓狂。

这也是为什么一些人会在第一次使用 Devon 或其他更高阶的 Agent AI 产品时，被他们的“浏览器交互”“自动爬虫”功能惊艳到。可实际上，我们并不需要订阅那些昂贵的云端工具，在本地一样可以给 Cursor 增加相当灵活的“访问 Web”能力。我们可以自己写一些脚本工具，再在 .cursorrules 中告诉它“你可以调用这些脚本。”当 Cursor 遇到要搜索或爬虫的任务，就会在 Agent 模式下自动选择并调用脚本，将结果收回进行分析整理。如此一来，Cursor 就不仅是一个封闭的代码生成器，而更像是你身边一位可以“满世界跑腿”的全能小伙伴。

下面这一节就想和你一起琢磨，如何给 Cursor 加上搜索和爬虫这两大核心工具。即便你以前没怎么写过爬虫或命令行脚本，也可以跟着这章的思路，在十分钟内搭建一个初步可用的“Web Access”环境，别小看这一步，它往往能让你在处理信息时节省大把时间，把重复性的检索或数据汇总全部交给 Cursor 自动完成。

如果你是那种对 AI 安全性和可控性非常敏感的同学，或许看到“让 Cursor 能随意上网访问各种页面”会有点担忧。其实大可以不必过分焦虑，你既可以在本地给 Cursor 准备一个独立的虚拟环境，也可以给脚本设置超时或权限限制，最重要的就是对工具的输入输出格式做好限定，不要让 AI 轻易调用一些危险命令。具体的安全考虑我们在后面会再谈到一些要点，这里先聚焦于如何让 AI 获得“上网工具”，把思路打通即可。

让 Cursor 学会“搜索”，为什么要先考虑 DuckDuckGo?

很多人第一反应会想：搜索当然用谷歌或必应呀，它们的覆盖面也许更广。但是在过去几个月的实践里，不少同学发现 Google 的官方 API 并没能和谷歌网页端那样给力，甚至有时结果质量和网页端差距巨大，调用起来也更麻烦。必应的 API 虽然在某些场景下确实不错，但在不同地区或不同账户下，授权流程又让人一头雾水。所以相对来说，DuckDuckGo 的公共搜索 API 会更好用一点，而且对新手也比较友好，通常直接发个 HTTP 请求就能得到 JSON 格式的搜索结果，拿来做实验或者集成到 Cursor 里非常省心。

当然，如果你更熟悉其他搜索服务，也可以写类似的脚本，只要保证输入和输出结构清晰，比如输入是一个搜索关键字字符串，输出就是一个 JSON 或者文本描述的结果，然后在 .cursorrules 里“声明”这个脚本的使用方法就可以。

最简单的实现思路就是，先写一个名叫 search.py 的脚本，里面用 requests 库对 DuckDuckGo API 发起搜索，把搜索结果解析一下，再把最重要的几条标题、链接和摘要打印到 stdout。Cursor 在调用这个脚本的时候，就能得到一串从 stdout 传回的文本内容。它读完这段文本后，再继续后续的决策，例如把结果整合成 Markdown，或者把里面的链接再逐个调用更深入的爬虫等等。

举个非常粗略的示例，search.py 可能长这样：

#!/usr/bin/env python3

import argparse
import sys
import traceback
from duckduckgo_search import DDGS

def search(query, max_results=10):
	"""
	Search using DuckDuckGo and return results with URLs and text snippets.
	Uses the HTML backend which has proven to be more reliable.
    
	Args:
    	query (str): Search query
    	max_results (int): Maximum number of results to return
	"""
	try:
    	print(f"DEBUG: Searching for query: {query}", file=sys.stderr)
   	 
    	with DDGS() as ddgs:
        	results = list(ddgs.text(
            	query,
            	max_results=max_results,
            	backend='html'  # Use only the HTML backend
        	))
       	 
        	if not results:
            	print("DEBUG: No results found", file=sys.stderr)
            	return
       	 
        	print(f"DEBUG: Found {len(results)} results", file=sys.stderr)
       	 
        	for i, r in enumerate(results, 1):
            	print(f"\n=== Result {i} ===")
            	print(f"URL: {r.get('link', r.get('href', 'N/A'))}")
            	print(f"Title: {r.get('title', 'N/A')}")
            	print(f"Snippet: {r.get('snippet', r.get('body', 'N/A'))}")
           	 
	except Exception as e:
    	print(f"ERROR: Search failed: {str(e)}", file=sys.stderr)
    	print(f"ERROR type: {type(e)}", file=sys.stderr)
    	traceback.print_exc(file=sys.stderr)
    	sys.exit(1)

def main():
	parser = argparse.ArgumentParser(description="Search using DuckDuckGo API")
	parser.add_argument("query", help="Search query")
	parser.add_argument("--max-results", type=int, default=10,
                  	help="Maximum number of results (default: 10)")
    
	args = parser.parse_args()
	search(args.query, args.max_results)

if __name__ == "__main__":
	main()

然后我们要在 .cursorrules 中告诉 AI：“当你想搜索信息时，你可以调用这个脚本，并且要用正确的方式传入关键字。”大致可以写上一些文字：

## Search engine

You could use the `tools/search_engine.py` file to search the web.
```
py310/bin/python ./tools/search_engine.py "your search keywords"
```
This will output the search results in the following format:
```
URL: https://example.com
Title: This is the title of the search result
Snippet: This is a snippet of the search result
```

Cursor 看到这段声明后，就相当于知道“我有一个叫 search_engine 的武器，只要我在命令行里敲 python search_engine.py '关键字'，就能得到搜索结果。”接下来只要在 Agent 模式里当它想要查点资料，就能自动用这个指令了。它执行脚本后，脚本会把结果打印在 stdout。Cursor 又会把这段 stdout 视为新的上下文，注入下一次 LLM 推理。最终 AI 可以分析搜索结果，自行决定是否需要再深入调查。

如果所有流程都配置正确，你就能像和一个懂搜索的“人类助理”对话一样，让它帮你对比一下最近海外哪些网站上在讨论某款新出的摄像机。它就会自动运行 search.py，列出 5~10 条相关链接，并用自然语言解读每个链接的大意。你可以继续让它检查这些链接里有没有什么常见的负面评价、有没有靠谱的评测报告等，它就会在需要时反复调用 search_engine.py，直到得到它想要的信息。最后，它再把所有结果汇总成一份 Markdown 或 PDF 草稿，供你一目了然地参考。这时候你可能会感觉，自己真的雇了一名实习生小哥，把网络资料搜集和初步的阅读整理都做掉了，你只需要做更进一步的深度判断即可。

在试用的过程中，有些人可能会发现一个小插曲：因为 DuckDuckGo 的访问速度或者 API 限制，有时候会失败，也可能出现一些语义不匹配的结果。这个时候，AI 本身也有可能出现“翻车”——它拿到了无关的信息却误以为成功抓取了有价值内容。面对这种情况，如果你希望它能更稳一点，可以在脚本里增加简单的验证逻辑，比如当结果为空就返回一个特定的错误码，让 AI 看到报错后自我 debug。或者在 .cursorrules 里再写明一点：“若搜索结果无关，请尝试改换关键字或添加更多限定词语。”这样就能减少一些胡编乱造的概率。

让 Cursor 用playwright把网页“爬”下来

相比搜索更进一步的需求是，让 Cursor 针对特定网页做爬虫。也许你想抓取某个学术会议官网，把里面所有论文的标题和作者搜集起来；或者你想定期从某个在线商店收集商品信息，用来做价格比对和趋势分析——以前可能要写一堆爬虫脚本手工跑，现在就可以让 AI 来完成脚本编写，自己跑脚本执行，再解析结果整理成一个你需要的 Markdown。只要给它足够清晰的指令和工具描述，它就可以全自动地干完。

如果你只是想对纯 HTML 做简单解析，requests+BeautifulSoup 其实就够了，比如写一个 crawler.py，用命令行接收要爬的 URL，然后把抓到的网页在里面挑选一些标签信息，用 print 函数输出即可。Cursor 每调用一次 crawler.py，就能获取一份网页的文本内容，然后再结合搜索脚本或后续的结果处理逻辑，做更深入的分析。看起来，这和“手动写爬虫”似乎并没有本质差异，可区别就在于你可以把这件事彻底交给 AI 去迭代：它会先试着写一个初版爬虫，如果报错，它就自己读错误信息，根据 .cursorrules 里的“你可以修改 crawler.py 的代码”提示来修复，然后再试。这种多步决策和自我修补的过程，正是 Agentic AI 令人惊艳的地方。

有时你需要在页面上执行一些 JavaScript，或者需要更真实的浏览器环境，比如碰到 React、Vue 之类的前端动态加载，这种时候 requests+BeautifulSoup 并不够，就得用到 playwright 或者类似的无头浏览器。虽然这会让脚本写起来复杂不少，不过在你让 Cursor 自动“探索”这些页面时，可靠性也会提升。它能在无头浏览器里点击按钮、滚动页面、等待特定元素加载，然后把最终的 DOM 抓出来给你。当然，这种脚本在实际运行时也更易被网站识别为爬虫，所以还要注意访问频率、可能的反爬机制等。

不管你采用 requests+BeautifulSoup 还是 playwright，这背后的思路都类似：在 .cursorrules 里注册一个“Web Crawler Tool”，给出调用格式，比如 python crawler.py "https://example.com"。一旦 AI 在内部推理时判断“我需要抓取这个链接的页面”，它就会执行 crawler.py。脚本再把抓到的网页（或者提取出的信息）打印到 stdout，AI 继续拿到这段内容做后续解析、汇总，甚至进行写入别的文件的操作。

当你第一次看到它把爬下来的数据自动整合成一个漂亮的 Markdown，再贴到仓库里时，那种“AI 真在帮我干活”的直观冲击，和单纯让 AI 给你写几行代码的感觉完全不一样。它仿佛真的具备了“实地访问”的能力，能跑到网站“采集材料”，把中间的繁琐过程全程自动化。我们不需要知道脚本里面有什么库、如何安装，也不需要关心出现错误该怎么 debug，AI 全程都能自己搞定。

当然，如果脚本遇到特别高的反爬墙，比如需要验证码或登录，AI 也不太容易绕过。除非你再给它接入什么自动打码平台之类的服务，但那已经是更高阶、更灰色地带的技巧了，这里就先不鼓励深入。在绝大多数公司内部运维或者公共信息网页抓取场景下，requests+BeautifulSoup 或者 playwright 就绰绰有余了。这里给出了一个参考实现。

搜索与爬虫组合：自动调度

很多人会好奇，AI 既可以搜索，也可以单点爬虫，那能不能让它先搜索一些相关链接列表，再自动挨个爬取？答案是肯定可以，而且完成度还相当高。比如你想找所有评论过“特定品牌咖啡机”的博客，让 AI 先搜索关键字 coffee machine brand X reviews，再从搜索结果里抽取 5-10 个可疑链接，然后把这些链接分别调用 crawler.py 进一步抓取，把抓到的内容串起来再用 LLM 对其提取核心观点……到了最后，AI 可以输出一份带有链接和提炼摘要的 Markdown 文档，或者一个 JSON，用于你后面进一步分析。这就是多工具互相配合下多步决策的典型应用。

你也会看到在执行过程中，AI 时不时地贴出一些 stdout，表示某些页面抓取失败，或者 parse 出奇怪的结果，但它会自己尝试改正。如果所有页面都抓成功了，它会继续调用 LLM 进行总结。只有当它真无法突破某些网页的登录限制或地理限制时，才会停下来问你该怎么办。这已经相当接近我们对一个真人小助手的需求期待了。

如果你以前把搜索和爬虫当作完全独立的脚本世界去做，这样的组合场景往往挺让人头疼，因为需要在 shell 脚本或 Python 代码里先写一堆逻辑，再做好异常处理；可是一旦在某个循环里失败，就得手动去 debug。现在则正好反过来，Cursor 自己会在对话上下文里保持一个“世界观”，知道“我已经成功搜索了多少链接，这些链接里哪几个失败了”，随时更新自己的决策路径。人类用户只用在高层做一个“请给我整理好这些评论链接并提炼观点”就行。

对搜索和爬虫工具的拓展思路：顺便多想一步

当你初次实现了 search_tool 和 crawler_tool 后，很可能会迅速沉迷在那种自动跑脚本的快乐里。要知道，这其实也才是“Agentic AI 时代”最初级的外部扩展，后面还有很多更带劲的玩法，比如让 AI 直接实现数据可视化：将抓来的数据再用 Plotly、Matplotlib 画图，然后一并输出 PNG。或者做一些图像处理：让它调用 ImageMagick、OpenCV 来给爬到的图片做统一裁剪，再放到 Markdown 里预览。这些都属于“让 AI 通过工具更直接地影响现实世界”——只要你能想到的流程，就可以想办法做成一个脚本，再在 .cursorrules 里描述清楚，AI 执行脚本的过程就跟我们人类打包跑脚本差不多，只是换成了全自动化形态。

有时候，你甚至可以“借力打力”。比如许多网站想要登录才能获得更多数据，也许你可以让 AI 自动调用一个本地的自动化浏览器工具（像 Selenium 或者 playwright 也行），去输入用户名密码登录，然后把 Cookie 或 session token 一并保存。后续再访问其他链接时，它就能获得更多权限。如果在过去，这些自动化脚本编写需要较高门槛，但让 Cursor 自己去写脚本，自己 debug，下次再用 .cursorrules 记下来所有要点，它就可以越来越熟练。

但要提醒大家一句，搜索和爬虫在法律与合规层面有时会比较敏感，你在对外爬取数据时一定要确保不违反对方的版权或访问协议，也要别让脚本频繁访问导致网络负担，毕竟 AI 不懂手下留情。有些站点很可能会在你重复访问时弹出验证码或封 IP，这时候 AI 也无能为力，除非你进一步给它分布式代理或打码服务，但那就又是一套灰色操作了，所以在公司里部署时要懂得合规与风险评估。

一个简短的回顾

我们在这里给 Cursor 增加搜索和爬虫两种常见工具，背后其实体现了一个更通用的原则：当你想让 AI 自己干点“需要外部执行”的活，就把这些活拆解成一个个简单的脚本，并在 .cursorrules 里说明脚本叫什么名字、如何调用、输入是什么、预期输出是什么。让 AI 知道一旦有相关场景，就可以执行脚本获取结果，再拿结果去进一步处理。等你通过几个小实验看着 Cursor 在终端里娴熟地执行 search.py、crawler.py 并且成功把结果写到 markdown.md 文件时，你会发现它真的能帮你做各种以前让人疲于奔命的批量信息搜集。

所以别把“编程 + AI”仅仅局限在编辑器里那点自动补全功能，想象力可以再放开一些。尤其是对很多企业来说，如果他们能把公司内部某些频繁查询或重复操作的流程变成脚本，再把脚本接给 AI，就像给 AI 分配了一把又一把新式武器。AI 就可以独自守在那儿跑完流程，出现异常才喊你一声，这比传统的“人工+脚本”模式要灵活得多。

后面我们会继续探讨更多工具类型，以及在魔改后如何像 Devin 那样把“搜索 + 爬虫 + 自检迭代 + .cursorrules 规划”结合起来，实现一种近乎全自动的任务流水线。先别急着一口气把所有脚本都塞进 .cursorrules，你只要先尝试加一个最简版的 search.py 或 crawler.py，看看 AI 是如何自发“学会”调用它，看看遇到错误时 AI 会如何 debug，这过程中你会更深刻地体会到 Agentic AI 的真正魅力。而且，你也能迅速感知自己最常见的痛点或需求是什么，对哪部分访问更有价值，再继续拓展也不迟。

如果你只是想小试牛刀，就先让它爬两个网站看看；如果你想要在工作流里一步到位建个“搜集 - 爬取 - 分析 - 报告合成”闭环，那就更需要在 .cursorrules 里为每个阶段都写点提示，告诉 AI 什么时候该调用哪些脚本，以及成功条件是什么。等你看着它自动跑完多轮，最后提交一份 Markdown，不带你手动复制粘贴任何一步，那一刻你大概就会真切地意识到“我问你做”这个新范式的威力。

至此，我们已经完成了从“在局域网里自动补全代码”到“跨越外部世界获取信息”的一大飞跃。因为有了搜索、爬虫之类的工具，Cursor 的视野陡然变得开阔，甚至还能根据你给出的全局提示，在不同阶段切换搜索和爬虫脚本，一次又一次地整合信息。在更进阶的使用场景中，你可以把搜索、爬虫、图像处理、甚至云端部署脚本全都注册到 .cursorrules 里，做一个真正意义上的“全栈代理”，让 AI 有能力从零开始挖掘资料，提炼思路，自己写代码，自己测试，最后上线部署。

很多人会说，这已经很厉害了，但和 Devin 那种号称月费 500 美元的功能比起来，是否还缺点啥？实际上，通过上面这几节和后续的魔改方式，我们已经覆盖了很大一部分关键环节，甚至在很多项目里 Cursor 已经不输 Devin，只需要你持续地给它添加合适的脚本和提示词。就像我们常说的：好钢要用在刀刃上，先针对你最常见的实际需求出发，做一个或两个脚本尝试，你会发现你获得的生产力提升远超预期。等到真的遇到特别庞大或极其复杂的工程需求，你再考虑是否要去迁移到专门的 Agentic AI 平台或租用昂贵服务。

本节的重点其实并不只是让你掌握某个特定的搜索或爬虫脚本，更大的意义在于感受这类“外部执行工具”在 Agentic AI 里的核心地位。当 AI 不再停留在“语言文字”的回答，而是真能把脚一跺、走出编辑器，连通到各式各样的外部资源或接口时，才是真正让“我问你做”落地。像搜索和爬虫只是一种入门案例，这背后更大的潜力，是让 AI 在你的电脑里“无所不能”。你甚至可以自己写个脚本去 SSH 登录某台服务器，让 AI 自动帮你部署应用，或者自己写脚本访问你公司内部的 BI 系统，把特定维度的数据拉出来，自动生成报表。只要你做对权限管控，就算让它放飞自我地跑那些脚本也无妨。

在下一部分，我们会更系统地讲解怎么用这些思路去实现“魔改后的 Cursor”，从而到达一个逼近专业级 Agentic AI 的体验，甚至在很多中小型项目里足以替代 Devin 的功能——当然，如果你追求更极致的全自动性，或者想在云端让 AI 跑起来不受本地环境限制，也可以再组合 Docker 隔离、Orchestrator 等高阶技术。不过，现在你已经把最关键的一步迈了出去，掌握了给 AI “新增工具”的模式，相当于给这位“虚拟员工”配了更多武器。请试着发挥想象力，好好琢磨还能让它做到哪些省时省力的事情，也为你的后续继续精进打下扎实的基础。
