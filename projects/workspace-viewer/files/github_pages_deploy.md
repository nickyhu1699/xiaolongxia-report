# 🚀 GitHub Pages 部署指南

## ✅ 为什么选GitHub Pages？

- 💰 **完全免费**
- 📊 **无流量限制**
- 🔒 **自动HTTPS**
- 🌐 **全球CDN**
- 🔄 **自动部署**（推送代码自动更新）
- 🎯 **自定义域名**

---

## 📋 3步部署（2分钟）

### 步骤1：创建GitHub仓库（30秒）

1. 打开浏览器，访问：https://github.com/new
2. 仓库名：`openclaw-presentation`
3. 描述：`OpenClaw演讲PPT - 解析小龙虾热潮`
4. 设为 **Public**（必须公开才能用Pages）
5. 点击 **"Create repository"**

---

### 步骤2：推送代码（1分钟）

**复制粘贴这些命令到终端**：

```bash
# 进入PPT目录
cd ~/.openclaw/workspace/railway-deploy

# 初始化Git
git init

# 添加所有文件
git add .

# 提交
git commit -m "初始化OpenClaw演讲PPT"

# 创建main分支
git branch -M main

# 添加远程仓库（替换成你的用户名）
git remote add origin https://github.com/你的用户名/openclaw-presentation.git

# 推送到GitHub
git push -u origin main
```

---

### 步骤3：启用GitHub Pages（30秒）

1. 在GitHub仓库页面，点击 **"Settings"**
2. 左侧菜单找到 **"Pages"**
3. Source选择 **"Deploy from a branch"**
4. Branch选择 **"main"**
5. Folder选择 **"/ (root)"**
6. 点击 **"Save"**

---

### 步骤4：访问网站（等待1分钟）

**访问地址**：
```
https://你的用户名.github.io/openclaw-presentation/openclaw_presentation.html
```

或根目录：
```
https://你的用户名.github.io/openclaw-presentation
```

---

## 🎯 完整命令（一键复制）

**告诉我你的GitHub用户名，我生成完整命令！**

**或者手动执行**：

```bash
# 1. 进入目录
cd ~/.openclaw/workspace/railway-deploy

# 2. 初始化并提交
git init
git add .
git commit -m "初始化OpenClaw演讲PPT"
git branch -M main

# 3. 添加远程仓库（替换用户名）
git remote add origin https://github.com/你的用户名/openclaw-presentation.git

# 4. 推送
git push -u origin main

# 5. 到GitHub仓库Settings → Pages启用
```

---

## 💡 提示

**如果已有Git仓库**：

```bash
cd ~/.openclaw/workspace/railway-deploy
git remote remove origin
git remote add origin https://github.com/你的用户名/openclaw-presentation.git
git push -u origin main
```

**如果需要创建index.html**：

在`railway-deploy`目录创建`index.html`：
```html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="refresh" content="0; url=openclaw_presentation.html">
</head>
<body>
  <a href="openclaw_presentation.html">点击查看演讲PPT</a>
</body>
</html>
```

---

## 🎉 部署后效果

**访问地址**：
```
https://你的用户名.github.io/openclaw-presentation
```

**特点**：
- ✅ 自动跳转到PPT
- ✅ 全球CDN加速
- ✅ HTTPS安全
- ✅ 永久免费

---

## 📊 对比其他平台

| 平台 | 费用 | 速度 | 稳定性 | 自定义域名 |
|------|------|------|--------|-----------|
| **GitHub Pages** | 免费 | 快 | ⭐⭐⭐⭐⭐ | ✅ |
| Netlify | 免费 | 最快 | ⭐⭐⭐⭐ | ✅ |
| Vercel | 免费 | 最快 | ⭐⭐⭐⭐ | ✅ |
| Railway | $5/月额度 | 快 | ⭐⭐⭐⭐ | ✅ |

**GitHub Pages是最稳定的！**

---

## 🚀 立即开始

**告诉我你的GitHub用户名，我生成完整命令！**

**或者直接执行**：

1. 打开 https://github.com/new 创建仓库
2. 告诉我用户名，我生成推送命令

**小龙虾随时待命！** 🦞
