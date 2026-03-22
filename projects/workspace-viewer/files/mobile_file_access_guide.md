# 手机查看OpenClaw工作文件的3个方案

## 方案对比

| 方案 | 难度 | 实时性 | 推荐度 |
|------|------|--------|--------|
| iCloud同步 | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Git仓库 | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| HTTP服务器 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 飞书上传 | ⭐⭐ | ⭐⭐ | ⭐⭐⭐ |

---

## ⭐ 方案1：iCloud同步（最推荐）

### 为什么推荐？
- macOS自带，无需安装
- 手机"文件"App直接查看
- 自动同步，实时更新
- 支持Markdown预览

### 实现步骤

**步骤1：移动workspace到iCloud**

```bash
# 创建iCloud目录
mkdir -p ~/Library/Mobile\ Documents/com~apple~CloudDocs/OpenClaw

# 移动workspace（保留原位置链接）
mv ~/.openclaw/workspace ~/Library/Mobile\ Documents/com~apple~CloudDocs/OpenClaw/
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/OpenClaw/workspace ~/.openclaw/workspace
```

**步骤2：手机查看**

1. 打开iPhone上的"文件"App
2. 点击"浏览" → "iCloud云盘" → "OpenClaw"
3. 点击任意.md文件即可查看

**步骤3：Markdown预览（可选）**

推荐安装App：
- **1Writer**（免费，功能强大）
- **Bear**（付费，体验好）
- **Obsidian Mobile**（免费，功能最强）

---

## 🔧 方案2：Git仓库同步

### 为什么推荐？
- 版本控制
- 多设备同步
- GitHub App直接查看
- 支持历史记录

### 实现步骤

**步骤1：创建Git仓库**

```bash
cd ~/.openclaw/workspace
git init
git add .
git commit -m "初始化OpenClaw工作文件"
```

**步骤2：推送到GitHub**

```bash
# 在GitHub创建仓库后
git remote add origin https://github.com/你的用户名/openclaw-workspace.git
git push -u origin main
```

**步骤3：手机查看**

1. 下载GitHub App
2. 登录你的账号
3. 打开仓库，点击任意.md文件
4. 自动Markdown渲染

---

## 🌐 方案3：HTTP文件服务器

### 为什么推荐？
- 无需云同步
- 实时查看最新文件
- 浏览器直接访问
- 支持局域网访问

### 实现步骤

**步骤1：启动HTTP服务器**

```bash
cd ~/.openclaw/workspace
python3 -m http.server 8888
```

**步骤2：手机访问**

1. 确保手机和电脑在同一WiFi
2. 查看电脑IP地址：`ifconfig | grep "inet " | grep -v 127.0.0.1`
3. 手机浏览器访问：`http://[电脑IP]:8888`
4. 点击任意文件查看

**步骤3：自动启动（可选）**

创建Launchd任务：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.openclaw.fileserver</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>-m</string>
        <string>http.server</string>
        <string>8888</string>
    </array>
    <key>WorkingDirectory</key>
    <string>/Users/sheyujituan/.openclaw/workspace</string>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
```

---

## 📤 方案4：飞书文档上传

### 为什么推荐？
- 你已经在用飞书
- 支持在线编辑
- 团队协作方便
- 手机飞书App查看

### 实现步骤

**手动上传**：
1. 打开飞书云文档
2. 新建文档
3. 复制粘贴内容

**自动上传**（需要配置）：
- 使用feishu-doc技能
- 需要配置app_token和权限

---

## 🎯 我的推荐

**最适合你的方案：iCloud同步**

原因：
1. ✅ 你用Mac，iCloud自带
2. ✅ 实时同步，无延迟
3. ✅ 手机"文件"App原生支持
4. ✅ 配合1Writer/Bear体验更好
5. ✅ 不需要额外安装软件

**实现只需3分钟！**

---

## 📱 推荐的Markdown查看App

### 免费方案
1. **文件App**（系统自带）
   - 基础Markdown渲染
   - 免费
   - 已安装

2. **Obsidian Mobile**
   - 功能最强大
   - 支持插件
   - 免费

3. **1Writer**
   - 界面简洁
   - 支持iCloud
   - 免费

### 付费方案
1. **Bear**（68元/年）
   - 体验最好
   - 界面美观
   - 支持标签

2. **Ulysses**（349元/年）
   - 专业写作工具
   - 功能最强
   - 贵

---

## 🚀 立即开始

**现在就配置iCloud同步？**

告诉我，我帮你执行！

**或者选择其他方案？**

告诉我你的选择，我来帮你配置！

---

**小龙虾生成** 🦞
