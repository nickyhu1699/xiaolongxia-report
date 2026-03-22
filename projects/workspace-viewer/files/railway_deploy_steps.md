# 🚂 Railway CLI 完整部署指南

## ✅ Railway CLI 已安装成功

**版本**：4.31.4

---

## 📋 完整部署步骤

### 步骤1：登录 Railway（需要交互）

**方法A：浏览器登录（推荐）**

```bash
cd ~/.openclaw/workspace/railway-deploy
railway login
```

**会发生什么**：
1. 命令执行后，2. 自动打开浏览器
3. 在浏览器中完成登录
4. 回到终端继续

**方法B：Token登录**

```bash
railway login --token
```

**获取Token**：
1. 访问 https://railway.app
2. 登录后，3. 点击头像 → Account Settings → API Tokens
4. 创建新Token
5. 粘贴到终端

---

### 步骤2：初始化项目

```bash
cd ~/.openclaw/workspace/railway-deploy
railway init
```

**选择**：
- ✅ 选择"Create a New Project"
- ✅ 项目名：`openclaw-presentation`
- ✅ 选择"Empty Project"

---

### 步骤3：部署

```bash
railway up
```

**会发生什么**：
1. 上传所有文件到Railway
2. 自动检测Node.js项目
3. 运行`npm install`
4. 运行`npm start`
5. 约1-2分钟完成

---

### 步骤4：生成域名

```bash
railway domain
```

**访问地址**：
```
https://你的项目名.up.railway.app
```

---

## 🎯 一键命令（复制粘贴）

```bash
# 进入目录
cd ~/.openclaw/workspace/railway-deploy

# 登录（会打开浏览器）
railway login

# 初始化项目
railway init

# 部署
railway up

# 生成域名
railway domain
```

---

## 📱 部署后

**访问地址**：
```
https://你的项目名.up.railway.app/openclaw_presentation.html
```

**或者根目录**：
```
https://你的项目名.up.railway.app
```

---

## 🔧 常用命令

**查看状态**：
```bash
railway status
```

**查看日志**：
```bash
railway logs
```

**重启服务**：
```bash
railway run npm start
```

**删除项目**：
```bash
railway down
```

---

## 💰 费用说明

**免费额度**：
- $5/月
- 512MB内存
- 1GB磁盘
- 足够小型项目

**如果超出**：
- 按使用量付费
- 约$0.01/GB/小时

---

## 🎉 准备好了！

**现在就部署？**

在终端运行：
```bash
cd ~/.openclaw/workspace/railway-deploy && railway login
```

---

**或者告诉我"帮我部署"，我继续下一步！** 🚂
