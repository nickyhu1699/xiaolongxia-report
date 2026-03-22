# PPT部署上线指南

## 🚀 方案对比

| 方案 | 费用 | 速度 | 域名 | 推荐度 |
|------|------|------|------|--------|
| GitHub Pages | 免费 | 快 | *.github.io | ⭐⭐⭐⭐⭐ |
| Vercel | 免费 | 最快 | *.vercel.app | ⭐⭐⭐⭐⭐ |
| Netlify | 免费 | 快 | *.netlify.app | ⭐⭐⭐⭐ |
| 本地服务器 | 免费 | 最快 | 局域网IP | ⭐⭐⭐ |

---

## ⭐ 方案1：GitHub Pages（最推荐）

### 步骤1：创建GitHub仓库

1. 访问 https://github.com/new
2. 仓库名：`openclaw-presentation`
3. 设为Public
4. 点击"Create repository"

### 步骤2：上传文件

**方法A：网页上传（最简单）**

1. 在GitHub仓库页面点击"uploading an existing file"
2. 拖拽 `openclaw_presentation.html` 到页面
3. 点击"Commit changes"

**方法B：Git命令**

```bash
cd ~/.openclaw/workspace
git init
git add openclaw_presentation.html
git commit -m "添加OpenClaw演讲PPT"
git branch -M main
git remote add origin https://github.com/你的用户名/openclaw-presentation.git
git push -u origin main
```

### 步骤3：启用GitHub Pages

1. 进入仓库Settings
2. 左侧菜单点击"Pages"
3. Source选择"Deploy from a branch"
4. Branch选择"main"
5. 点击"Save"

### 步骤4：访问

等待1-2分钟后，访问：
```
https://你的用户名.github.io/openclaw-presentation/openclaw_presentation.html
```

**优点**：
- ✅ 完全免费
- ✅ 自定义域名
- ✅ HTTPS安全
- ✅ 稳定可靠

---

## ⭐ 方案2：Vercel（最快）

### 步骤1：注册Vercel

访问 https://vercel.com/signup
- 可以用GitHub账号登录

### 步骤2：创建项目

1. 点击"Add New..." → "Project"
2. 选择"Import Git Repository"（如果已上传GitHub）
   或拖拽文件上传

### 步骤3：部署

1. 点击"Deploy"
2. 等待30秒
3. 完成！

**访问地址**：
```
https://你的项目名.vercel.app
```

**优点**：
- ✅ 部署最快（30秒）
- ✅ 自动HTTPS
- ✅ 全球CDN
- ✅ 自定义域名

---

## ⭐ 方案3：Netlify

### 步骤1：注册Netlify

访问 https://app.netlify.com/signup
- 可以用GitHub账号登录

### 步骤2：拖拽上传

1. 登录后看到"Add new site"
2. 选择"Deploy manually"
3. 拖拽HTML文件到页面
4. 自动部署

**访问地址**：
```
https://随机名称.netlify.app
```

**优点**：
- ✅ 拖拽上传
- ✅ 自动HTTPS
- ✅ 表单处理
- ✅ 函数支持

---

## ⭐ 方案4：本地HTTP服务器（局域网访问）

### 启动服务器

```bash
cd ~/.openclaw/workspace
python3 -m http.server 8080
```

### 查看你的IP地址

**macOS**:
```bash
系统偏好设置 → 网络 → 查看IP地址
```

**或命令行**:
```bash
# 方法1
ifconfig | grep "inet " | grep -v 127.0.0.1

# 方法2
ipconfig getifaddr en0
```

### 访问地址

**电脑访问**:
```
http://localhost:8080/openclaw_presentation.html
```

**手机访问**（同一WiFi）:
```
http://你的IP:8080/openclaw_presentation.html
```

**示例**:
```
http://192.168.1.100:8080/openclaw_presentation.html
```

---

## 🎯 我的推荐

### 最快方案：Vercel
- 30秒部署
- 全球CDN
- 自动HTTPS

### 最稳定方案：GitHub Pages
- 完全免费
- 无流量限制
- 稳定可靠

### 最简单方案：Netlify
- 拖拽上传
- 无需Git
- 立即访问

---

## 📱 手机访问

部署后，手机访问链接即可：
- ✅ 全屏展示
- ✅ 手势滑动
- ✅ 横屏最佳

---

## 🎨 自定义域名（可选）

### GitHub Pages

1. 仓库Settings → Pages → Custom domain
2. 输入你的域名
3. 添加CNAME记录

### Vercel/Netlify

1. 项目Settings → Domains
2. 添加域名
3. 配置DNS

---

## 💡 优化建议

### 添加favicon

在HTML的`<head>`中添加：
```html
<link rel="icon" type="image/png" href="favicon.png">
```

### 添加SEO

```html
<meta name="description" content="OpenClaw演讲PPT">
<meta name="keywords" content="OpenClaw, AI, 数字员工">
```

### 添加Open Graph（社交分享）

```html
<meta property="og:title" content="解析小龙虾热潮">
<meta property="og:description" content="发掘OpenClaw+一切可能的时代机会">
<meta property="og:image" content="封面图.png">
```

---

## 🚀 立即开始

**告诉我你想用哪个方案？**

1. **GitHub Pages** - 我帮你准备Git命令
2. **Vercel** - 我告诉你详细步骤
3. **Netlify** - 我指导你拖拽上传
4. **本地服务器** - 我帮你启动并查看IP

**或者告诉我你的GitHub用户名，我帮你生成完整命令！**

---

**小龙虾生成** 🦞
