# 🚂 Railway CLI 快速部署指南

## ✅ Railway CLI 已安装

当前版本：已安装

---

## 🚀 3步部署

### 步骤1：登录 Railway

```bash
cd ~/.openclaw/workspace/railway-deploy
railway login
```

**操作**：
1. 会打开浏览器
2. 用GitHub或邮箱登录
3. 回到终端

---

### 步骤2：初始化项目

```bash
railway init
```

**操作**：
1. 选择"Create New Project"
2. 输入项目名：`openclaw-presentation`
3. 选择"Empty Project"

---

### 步骤3：部署

```bash
railway up
```

**操作**：
- 自动检测Node.js项目
- 自动安装依赖
- 自动部署
- 约1-2分钟

---

### 步骤4：生成域名

```bash
railway domain
```

**结果**：
```
https://openclaw-presentation.up.railway.app
```

---

## 🎯 一键执行

**告诉我"开始部署"，我立即执行所有步骤！**

或者你手动执行：
```bash
cd ~/.openclaw/workspace/railway-deploy
railway login
railway init
railway up
railway domain
```

---

## 💰 费用说明

Railway提供：
- ✅ $5/月免费额度
- ✅ 512MB内存
- ✅ 自动HTTPS
- ✅ 自定义域名

完全够用！

---

## 🎉 部署后

访问地址：
```
https://你的项目名.up.railway.app
```

特点：
- ✅ 全球CDN
- ✅ HTTPS安全
- ✅ 24小时在线
- ✅ 自动重启

---

**准备好开始了吗？** 🚂

告诉我"开始"，我立即帮你部署！
