# OpenClaw 安装教程：从零开始打造你的私人 AI 助手

> 想要一个真正的"贾维斯"吗？手把手教你部署 OpenClaw，让 AI 不仅会聊天，还能帮你"干活"！

## 🤖 什么是 OpenClaw？

OpenClaw 是一个开源的 AI Agent 框架，它不仅仅是一个聊天机器人，更是一个拥有"手脚"的数字管家。

**它能做什么？**
- ✅ 自动处理工作流程（如自动值机、选座）
- ✅ 深度调研并整理报告
- ✅ 管理日程、预约会议
- ✅ 操作本地文件和系统
- ✅ 接入多种 IM 平台（飞书、Telegram、企业微信等）
- ✅ 浏览网页、截图、填表单

简单来说：**ChatGPT 只能给你建议，OpenClaw 能帮你执行！**

---

## 🎯 为什么选择 OpenClaw？

### 1. 真正的智能助手
传统的 AI 聊天机器人只能"纸上谈兵"，而 OpenClaw 能：
- 自动打开网页帮值机并选座
- 整理多个网页信息生成报告
- 直接操作你的日历和文件
- 24小时待命处理重复性工作

### 2. 完全开源免费
- 代码开源，可自行部署
- 无需付费订阅，只需配置 API Key
- 支持多种大模型（OpenAI、DeepSeek、智谱等）

### 3. 隐私安全
- 本地部署，数据不上传
- 完全掌控自己的 AI 助手
- 可自定义权限范围

---

## 📋 部署前准备

### 推荐配置

**操作系统：**
- 🍎 **Mac（强烈推荐）**：原生支持最完善，可操作日历、备忘录、截图等
- 🪟 Windows：完全可用，部分系统集成功能受限
- 🐧 Linux：适合开发者，配置灵活

**IM 工具选择：**
- 🇨🇳 **国内用户：飞书**（现代化、开发友好、功能丰富）
- 🌍 **国外用户：Telegram**（API 最完善，功能最强）
- 备选：企业微信、钉钉、QQ

**部署方式：**
- 💻 有 Mac：推荐**本地部署**（体验最好，功能最全）
- ☁️ 无 Mac 或想 24 小时运行：推荐**云端部署**（成本低，稳定可靠）

---

## 🚀 一、Mac 本地部署（推荐）

### 为什么选择 Mac 本地部署？

**优势：**
- ✅ 系统集成：可操作日历、备忘录、文件系统
- ✅ 隐私安全：数据完全本地，不上传云端
- ✅ 响应速度快：本地运行，无网络延迟
- ✅ 功能最全：支持所有高级功能
- ✅ 成本低：无需购买云服务器

### 系统要求

- **CPU**：M 系列芯片或 Intel i5 以上
- **内存**：8GB 以上（推荐 16GB）
- **硬盘**：10GB 以上空闲空间
- **系统**：macOS 12 Monterey 或更高版本

### 安装步骤

#### 第一步：打开终端

1. 按 `Command + 空格` 打开 Spotlight
2. 输入 `Terminal` 或"终端"
3. 按回车打开终端

#### 第二步：安装 OpenClaw

在终端中运行以下命令：

```bash
# 方法一：使用 npm 安装（推荐）
npm install -g openclaw

# 方法二：使用 Homebrew 安装
brew install openclaw
```

安装过程可能需要几分钟，请耐心等待。

#### 第三步：初始化配置

```bash
# 初始化 OpenClaw
openclaw init

# 启动配置向导
openclaw config
```

按照提示输入：
- 大模型 API Key（如 OpenAI、DeepSeek 等）
- 选择默认模型
- 配置 IM 平台（可选）

#### 第四步：启动 OpenClaw

```bash
# 启动 Gateway 服务
openclaw gateway start

# 检查状态
openclaw status
```

看到 ✅ Gateway is running 就表示启动成功！

---

## 🪟 二、Windows 本地部署

### 系统要求

- Windows 10 或更高版本
- 4GB 以上内存
- 10GB 以上硬盘空间

### 安装步骤

#### 第一步：安装 Node.js

1. 访问 https://nodejs.org/
2. 下载 LTS 版本安装包
3. 双击安装，一路 Next 即可

#### 第二步：安装 OpenClaw

打开 PowerShell（以管理员身份运行）：

```powershell
npm install -g openclaw
```

#### 第三步：配置和启动

```powershell
# 初始化
openclaw init

# 配置
openclaw config

# 启动
openclaw gateway start
```

---

## ☁️ 三、云端一键部署

### 适合人群
- 没有 Mac 电脑
- 需要 24 小时在线运行
- 多人共享使用

### 部署方案

#### 方案一：Railway 部署（最简单）

1. Fork OpenClaw 官方仓库
2. 注册 Railway 账号
3. 连接 GitHub 仓库
4. 一键部署

详细教程：[OpenClaw 官方文档](https://docs.openclaw.ai)

#### 方案二：VPS 部署（更灵活）

```bash
# SSH 到你的服务器
ssh user@your-server

# 安装 Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# 安装 OpenClaw
npm install -g openclaw

# 配置
openclaw init
openclaw config

# 使用 PM2 保持运行
npm install -g pm2
pm2 start "openclaw gateway start" --name openclaw
```

---

## 🔑 四、API 配置指南

### 支持的大模型

OpenClaw 支持多种大模型，推荐以下几种：

#### 1. OpenAI（推荐）
- 官网：https://platform.openai.com/
- 模型：GPT-4、GPT-4-turbo、GPT-3.5-turbo
- 价格：按 token 计费

#### 2. DeepSeek（性价比高）
- 官网：https://platform.deepseek.com/
- 模型：deepseek-chat、deepseek-coder
- 价格：比 OpenAI 便宜很多

#### 3. 智谱 AI（国产）
- 官网：https://open.bigmodel.cn/
- 模型：glm-4、glm-3-turbo
- 价格：有免费额度

### 配置方法

```bash
# 运行配置命令
openclaw config

# 选择 "Add new provider"
# 输入 API Key
# 选择默认模型
```

或者直接编辑配置文件：

```bash
# 打开配置文件
openclaw config edit

# 添加以下内容
providers:
  - name: openai
    apiKey: sk-xxxxxxxx
    model: gpt-4-turbo
    
  - name: deepseek
    apiKey: sk-xxxxxxxx
    model: deepseek-chat
```

---

## 💬 五、接入飞书（可选）

### 为什么选择飞书？

- ✅ 国内访问速度快
- ✅ 免费版功能丰富
- ✅ 支持富文本、文档、表格
- ✅ 消息推送稳定

### 配置步骤

#### 第一步：创建飞书应用

1. 访问 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业自建应用
3. 获取 App ID 和 App Secret

#### 第二步：配置权限

在飞书应用管理后台，开启以下权限：
- `im:message` - 获取和发送消息
- `im:message:send_as_bot` - 以应用身份发送消息

#### 第三步：配置 OpenClaw

```bash
# 安装飞书插件
openclaw plugin install feishu

# 配置飞书
openclaw feishu config
```

输入你的 App ID 和 App Secret。

#### 第四步：启用事件订阅

在飞书应用后台：
1. 配置事件订阅 URL：`https://your-domain/webhook/feishu`
2. 订阅消息事件
3. 发布应用

---

## ❓ 常见问题解决

### 1. 安装失败怎么办？

**问题：** npm install 报错

**解决：**
```bash
# 切换到官方源
npm config set registry https://registry.npmjs.org/

# 清除缓存
npm cache clean --force

# 重新安装
npm install -g openclaw
```

### 2. Gateway 启动失败？

**问题：** `openclaw gateway start` 报错

**解决：**
```bash
# 检查端口占用
lsof -i :18800

# 杀掉占用进程
kill -9 <PID>

# 重新启动
openclaw gateway start
```

### 3. API Key 配置错误？

**问题：** 提示 API Key 无效

**解决：**
- 检查 API Key 是否正确复制
- 确认账户余额充足
- 检查 API Key 权限设置

### 4. 飞书消息收不到？

**问题：** 发送消息给机器人无响应

**解决：**
- 检查事件订阅是否配置正确
- 确认应用已发布
- 查看 OpenClaw 日志：`openclaw logs`

---

## 🎓 进阶使用

### 自定义 Skills

OpenClaw 支持自定义技能包，扩展 AI 的能力：

```bash
# 安装技能包
openclaw skill install <skill-name>

# 查看已安装技能
openclaw skill list
```

### 定时任务

```bash
# 创建定时任务
openclaw cron add "0 9 * * *" "每天早上9点提醒我开会"

# 查看定时任务
openclaw cron list
```

### 多模型切换

```bash
# 切换默认模型
openclaw model switch deepseek-chat

# 查看可用模型
openclaw model list
```

---

## 📚 学习资源

- **官方文档**：https://docs.openclaw.ai
- **GitHub 仓库**：https://github.com/openclaw/openclaw
- **社区论坛**：https://discord.com/invite/clawd
- **技能市场**：https://clawhub.com
- **中文教程**：https://github.com/xianyu110/awesome-openclaw-tutorial

---

## 🎉 总结

OpenClaw 是一个强大且灵活的 AI Agent 框架，无论你是：
- 🍎 Mac 用户（推荐本地部署）
- 🪟 Windows 用户（完全可用）
- ☁️ 云端爱好者（24小时在线）

都能找到适合自己的部署方式。

**开始你的 AI 助手之旅吧！**

有任何问题，欢迎在评论区留言或加入社区讨论。

---

**相关推荐：**
- [3 个 OpenClaw 技能让你的 AI Agent 超进化]()
- [如何用 OpenClaw 接入飞书打造私人助手]()
- [OpenClaw 云端部署完整指南]()

---

*作者：OpenClaw 社区*
*发布时间：2026年3月10日*
