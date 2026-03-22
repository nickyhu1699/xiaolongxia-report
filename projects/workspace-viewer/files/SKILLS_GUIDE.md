# 🦞 小龙虾技能库（Skills Guide）

---

## 📋 技能分类

### 🔥 核心运营技能

#### 1. **扑扑AI - 小红书自动化运营**
**功能**：使用智创扑满API自动生成小红书内容（标题+正文+标签+配图）

**触发词**：
- `/ima [主题]` - 快捷生成小红书笔记
- "帮我生成小红书笔记"
- "小红书内容"

**支持功能**：
- ✅ 账号知识库
- ✅ 同款复刻
- ✅ AI生图
- ✅ 用户自定义配图（最多9张）
- ✅ 自动上传图片到OSS

**使用场景**：
- 快速生成小红书笔记
- 批量生成内容
- 配图自动化

**位置**：`~/.agents/skills/pupu-xhs-automation/`

---

#### 2. **AI图片生成器**
**功能**：AI图片生成，支持4种模式（极速/快速/慢速/标准）

**触发词**：
- "生成一张图片"
- "帮我画一张"
- "AI生图"

**支持功能**：
- ✅ 自动选择最佳模式和尺寸
- ✅ 多种风格
- ✅ 批量生成

**使用场景**：
- 公众号封面图
- 小红书配图
- 文章配图

**位置**：`~/.agents/skills/ai-image-generator/`

---

#### 3. **wechat-publisher（公众号发布）**
**功能**：公众号文章发布工具（修复版），解决Unicode转义和排版对齐问题

**触发词**：
- "发布到公众号"
- "创建公众号草稿"

**支持功能**：
- ✅ 自动排版
- ✅ 图片上传
- ✅ 草稿管理

**使用场景**：
- 公众号文章发布
- 批量发布

**位置**：`~/.agents/skills/wechat-publisher/`

---

### 📰 内容采集技能

#### 4. **agent-reach（全网搜索）**
**功能**：7500+ GitHub stars，搜索和读取16个平台内容

**支持平台**：
- Twitter/X、Reddit、YouTube、GitHub
- Bilibili、小红书、抖音、微博
- 微信公众号、小宇宙播客
- LinkedIn、Instagram、V2EX、RSS
- Exa web search、任何网页

**触发词**：
- "搜推特"、"搜小红书"
- "看视频"、"B站"
- "帮我查"、"全网搜索"
- "read tweet"、"youtube transcript"

**使用场景**：
- 多平台内容搜索
- 视频转录
- 文章抓取

**位置**：`~/.agents/skills/agent-reach/`

---

#### 5. **AI新闻收集器（ai-news-collector）**
**功能**：AI新闻聚合与热度排序工具

**触发词**：
- "今天有什么AI新闻？"
- "总结一下这周的AI动态"
- "最近有什么火的AI产品？"
- "AI圈最近在讨论什么？"

**覆盖内容**：
- 新产品发布
- 研究论文
- 行业动态
- 融资新闻
- 开源项目更新
- 社区病毒传播现象
- AI工具/Agent热门项目

**使用场景**：
- 每日AI新闻汇总
- 行业趋势分析
- 定时推送

**位置**：`~/.openclaw/workspace/skills/ai-news-collectors/`

---

### 🎨 设计创作技能

#### 6. **qiaomu-mondo-poster-design（Mondo风格海报设计）**
**功能**：一句话生成大师级海报、书籍封面、专辑封面

**触发词**：
- "Mondo风格"
- "书籍封面设计"
- "专辑封面"
- "海报设计"
- "读书笔记配图"
- "公众号封面"
- "小红书配图"
- "文章配图"

**支持风格**：
- 33+位传奇设计师风格
- 自动风格对比
- 图生图转换

**支持比例**：
- 21:9（公众号封面）
- 16:9（文章配图）
- 3:4（小红书配图）
- 1:1（专辑封面）
- 9:16（书籍封面、电影海报）

**位置**：`~/.agents/skills/qiaomu-mondo-poster-design/`

---

### 📝 文本处理技能

#### 7. **baoyu-format-markdown（Markdown格式化）**
**功能**：格式化纯文本或markdown文件

**触发词**：
- "format markdown"
- "beautify article"
- "add formatting"
- "improve article layout"

**支持功能**：
- ✅ 添加frontmatter
- ✅ 标题、摘要、目录
- ✅ 粗体、列表、代码块
- ✅ 输出到 `{filename}-formatted.md`

**使用场景**：
- 文章排版
- Markdown美化

**位置**：`~/.openclaw/workspace/skills/baoyu-format-markdown/`

---

### 🔧 开发工具技能

#### 8. **skill-creator（技能创建器）**
**功能**：创建、编辑、改进或审核AgentSkills

**触发词**：
- "create a skill"
- "author a skill"
- "tidy up a skill"
- "improve this skill"
- "review the skill"
- "clean up the skill"
- "audit the skill"

**支持功能**：
- ✅ 从零创建新技能
- ✅ 改进现有技能
- ✅ 审核技能质量
- ✅ 重构技能目录
- ✅ 移动文件到references/或scripts/
- ✅ 验证AgentSkills规范

**位置**：`~/.agents/skills/skill-creator/`

---

#### 9. **skill-vetter（技能审核器）**
**功能**：安全优先的OpenClaw技能审核工具

**触发词**：
- 在安装ClawHub、GitHub或其他来源的技能前使用

**检查内容**：
- 🔴 红旗警告
- 🔍 权限范围
- 🔍 可疑模式

**使用场景**：
- 安装技能前的安全检查
- 技能可信度评估

**位置**：`~/.agents/skills/skill-vetter/`

---

#### 10. **clawhub（技能市场）**
**功能**：使用ClawHub CLI搜索、安装、更新和发布agent skills

**触发词**：
- "搜索技能"
- "安装技能"
- "更新技能"
- "发布技能"

**支持功能**：
- ✅ 搜索clawhub.com上的技能
- ✅ 安装/更新技能到最新版或指定版本
- ✅ 发布新技能或更新

**使用场景**：
- 发现新技能
- 技能管理

**位置**：`~/.agents/skills/clawhub/`

---

### 🛠️ 系统工具技能

#### 11. **healthcheck（安全加固）**
**功能**：主机安全加固和风险容忍配置

**触发词**：
- "security audit"
- "firewall/SSH/update hardening"
- "risk posture"
- "exposure review"
- "OpenClaw cron scheduling"
- "version status check"

**使用场景**：
- 安全审计
- 防火墙配置
- SSH加固
- 自动更新配置
- 定期检查

**位置**：`~/.agents/skills/healthcheck/`

---

#### 12. **node-connect（节点连接诊断）**
**功能**：诊断OpenClaw节点连接和配对失败

**触发词**：
- QR/setup code/manual connect fails
- "local Wi-Fi works but VPS/tailnet does not"
- "pairing required"
- "unauthorized"
- "bootstrap token invalid or expired"
- "gateway.bind"
- "gateway.remote.url"
- "Tailscale"
- "device-pair.config.publicUrl"

**支持平台**：
- Android
- iOS
- macOS companion apps

**位置**：`~/.agents/skills/node-connect/`

---

#### 13. **video-frames（视频帧提取）**
**功能**：使用ffmpeg从视频中提取帧或短视频片段

**触发词**：
- "extract frames"
- "extract video clips"

**支持功能**：
- ✅ 提取视频帧
- ✅ 提取短视频片段

**使用场景**：
- 视频分析
- 缩略图生成

**位置**：`~/.agents/skills/video-frames/`

---

#### 14. **weather（天气查询）**
**功能**：通过wttr.in或Open-Meteo获取当前天气和预报

**触发词**：
- "天气"
- "temperature"
- "forecast"
- 询问任何地点的天气

**不支持**：
- ❌ 历史天气数据
- ❌ 严重天气警报
- ❌ 详细气象分析

**API**：无需API密钥

**位置**：`~/.agents/skills/weather/`

---

### 💬 微信工具技能

#### 15. **wechat-multi（微信多开）**
**功能**：macOS微信多开工具（小绿书）

**触发词**：
- "打开两个微信"
- "微信双开"
- "微信多开"
- "再开一个微信"
- "微信更新后重建"
- "修复微信多开"
- "关闭所有微信"
- "小绿书"

**原理**：
- 复制WeChat.app
- 修改Bundle ID
- 重新签名
- 实现多实例运行

**位置**：`~/.agents/skills/wechat-multi/`

---

### 📚 飞书技能

#### 16. **feishu-doc（飞书文档）**
**功能**：飞书文档读写操作

**触发词**：
- "飞书文档"
- "云文档"
- "docx链接"

**支持功能**：
- ✅ 读取文档
- ✅ 写入文档
- ✅ 追加内容
- ✅ 插入内容
- ✅ 创建文档
- ✅ 表格操作
- ✅ 图片上传

**位置**：`/opt/homebrew/lib/node_modules/openclaw/extensions/feishu/skills/feishu-doc/`

---

#### 17. **feishu-drive（飞书云存储）**
**功能**：飞书云存储文件管理

**触发词**：
- "云空间"
- "文件夹"
- "drive"

**支持功能**：
- ✅ 列出文件
- ✅ 查看文件信息
- ✅ 创建文件夹
- ✅ 移动文件
- ✅ 删除文件

**位置**：`/opt/homebrew/lib/node_modules/openclaw/extensions/feishu/skills/feishu-drive/`

---

#### 18. **feishu-perm（飞书权限管理）**
**功能**：飞书文档和文件权限管理

**触发词**：
- "sharing"
- "permissions"
- "collaborators"
- "分享"
- "权限"

**位置**：`/opt/homebrew/lib/node_modules/openclaw/extensions/feishu/skills/feishu-perm/`

---

#### 19. **feishu-wiki（飞书知识库）**
**功能**：飞书知识库导航

**触发词**：
- "知识库"
- "wiki"
- "wiki链接"

**支持功能**：
- ✅ 列出空间
- ✅ 查看节点
- ✅ 创建页面
- ✅ 移动页面
- ✅ 重命名

**位置**：`/opt/homebrew/lib/node_modules/openclaw/extensions/feishu/skills/feishu-wiki/`

---

### 🧠 自我进化技能

#### 20. **self-improvement（自我进化）**
**功能**：捕获学习、错误和纠正，实现持续改进

**触发场景**：
1. 命令或操作意外失败
2. 用户纠正（"No, that's wrong..."）
3. 用户请求不存在的功能
4. 外部API或工具失败
5. 发现知识过时或不正确
6. 发现更好的方法

**使用方式**：
- 自动记录错误和纠正
- 在重要任务前回顾学习内容

**位置**：`~/.openclaw/workspace/skills/self-improving-agent/`

---

## 📊 技能统计

**总计**：20个技能

**分类**：
- 🔥 核心运营：3个
- 📰 内容采集：2个
- 🎨 设计创作：1个
- 📝 文本处理：1个
- 🔧 开发工具：3个
- 🛠️ 系统工具：4个
- 💬 微信工具：1个
- 📚 飞书技能：4个
- 🧠 自我进化：1个

---

## 💡 使用建议

### 内容创作工作流

1. **AI新闻收集** → 了解最新动态
2. **agent-reach搜索** → 收集参考资料
3. **AI图片生成** → 生成配图
4. **扑扑AI** → 生成小红书笔记
5. **wechat-publisher** → 发布到公众号

### 技能开发工作流

1. **skill-creator** → 创建新技能
2. **skill-vetter** → 审核技能安全性
3. **clawhub** → 发布到技能市场

### 日常运营工作流

1. **AI新闻收集** → 每日新闻推送
2. **weather** → 查看天气
3. **self-improvement** → 持续优化

---

**技能库持续更新中！**🦞

**最后更新**：2026-03-20 02:36
