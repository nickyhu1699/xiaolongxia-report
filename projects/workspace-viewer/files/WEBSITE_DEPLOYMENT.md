# 网站部署方案

## 🌟 推荐方案：Cloudflare Tunnel（默认）

**特点**：
- ⚡ 30秒上线
- 💰 完全免费
- 🌐 公网访问
- 🔒 自动HTTPS
- 🚫 无需注册
- 📱 全球CDN
- ⏱️ 临时链接（几小时到几天）

---

## 📋 部署流程（标准化）

### 步骤1：准备网站文件

**确保有index.html或入口文件**：
```bash
# 检查文件
ls -la /path/to/website/
```

---

### 步骤2：启动本地HTTP服务器

**方法A：Python服务器（推荐）**
```bash
# 进入网站目录
cd /path/to/website/

# 启动服务器（端口8889）
python3 -m http.server 8889
```

**方法B：Node.js服务器**
```bash
# 安装serve
npm install -g serve

# 启动服务器
serve -p 8889
```

**后台运行**：
```bash
# 后台启动
nohup python3 -m http.server 8889 &

# 记录PID
echo $! > /tmp/http_server.pid
```

---

### 步骤3：启动Cloudflare Tunnel

**命令**：
```bash
cloudflared tunnel --url http://localhost:8889 --no-autoupdate
```

**后台运行**：
```bash
nohup cloudflared tunnel --url http://localhost:8889 --no-autoupdate > /tmp/cloudflared.log 2>&1 &
```

---

### 步骤4：获取公网URL

**查看日志**：
```bash
# 等待5-10秒后查看
tail -f /tmp/cloudflared.log
```

**输出示例**：
```
2026-03-12T11:59:13Z INF |  https://camp-issue-nut-liked.trycloudflare.com
```

**URL格式**：
```
https://[随机字符串].trycloudflare.com
```

---

### 步骤5：测试访问

**浏览器访问**：
```
https://your-url.trycloudflare.com
```

**或直接访问特定文件**：
```
https://your-url.trycloudflare.com/openclaw_presentation.html
```

---

## 🔄 完整自动化脚本

**创建脚本**：`deploy_website.sh`

```bash
#!/bin/bash

# 部署网站到Cloudflare Tunnel
# 用法: ./deploy_website.sh [网站目录] [端口]

WEBSITE_DIR=${1:-$(pwd)}
PORT=${2:-8889}

echo "🚀 开始部署网站..."
echo "📁 网站目录: $WEBSITE_DIR"
echo "🔌 本地端口: $PORT"

# 1. 进入目录
cd "$WEBSITE_DIR" || exit 1

# 2. 启动HTTP服务器
echo "🌐 启动HTTP服务器..."
nohup python3 -m http.server $PORT > /tmp/http_server.log 2>&1 &
HTTP_PID=$!
echo $HTTP_PID > /tmp/http_server.pid
sleep 2

# 3. 启动Cloudflare Tunnel
echo "🚇 启动Cloudflare Tunnel..."
nohup cloudflared tunnel --url http://localhost:$PORT --no-autoupdate > /tmp/cloudflared.log 2>&1 &
CLOUDFLARED_PID=$!
echo $CLOUDFLARED_PID > /tmp/cloudflared.pid
sleep 5

# 4. 获取公网URL
echo "📡 获取公网URL..."
PUBLIC_URL=$(grep -o 'https://[^.]*\.trycloudflare\.com' /tmp/cloudflared.log | head -1)

if [ -z "$PUBLIC_URL" ]; then
    echo "❌ 部署失败：未获取到公网URL"
    exit 1
fi

echo ""
echo "✅ 部署成功！"
echo ""
echo "🌐 公网访问地址："
echo "   $PUBLIC_URL"
echo ""
echo "📊 进程信息："
echo "   HTTP服务器PID: $HTTP_PID"
echo "   Cloudflared PID: $CLOUDFLARED_PID"
echo ""
echo "📝 日志文件："
echo "   HTTP日志: /tmp/http_server.log"
echo "   Tunnel日志: /tmp/cloudflared.log"
echo ""
echo "🛑 停止服务："
echo "   kill $HTTP_PID $CLOUDFLARED_PID"
```

**使用方法**：
```bash
# 添加执行权限
chmod +x deploy_website.sh

# 部署当前目录
./deploy_website.sh

# 部署指定目录
./deploy_website.sh /path/to/website

# 指定端口
./deploy_website.sh /path/to/website 9999
```

---

## 🛠️ 管理命令

### 查看状态
```bash
# 查看进程
ps aux | grep cloudflared
ps aux | grep "http.server"

# 查看日志
tail -f /tmp/cloudflared.log
tail -f /tmp/http_server.log
```

### 停止服务
```bash
# 停止所有
kill $(cat /tmp/http_server.pid)
kill $(cat /tmp/cloudflared.pid)

# 或直接杀进程
pkill -f cloudflared
pkill -f "http.server 8889"
```

### 重启服务
```bash
# 停止
kill $(cat /tmp/http_server.pid) 2>/dev/null
kill $(cat /tmp/cloudflared.pid) 2>/dev/null

# 重新部署
./deploy_website.sh
```

---

## 📝 注意事项

### 1. 临时链接
- URL有效期：几小时到几天
- 重启后会生成新URL
- 适合临时分享、演示

### 2. 端口占用
- 默认使用8889端口
- 如果被占用，改用其他端口
- 检查端口：`lsof -i :8889`

### 3. 文件访问
- 默认访问index.html
- 可直接访问特定文件
- 支持所有静态文件

### 4. 性能
- 全球CDN加速
- 支持大文件
- 无带宽限制

---

## 🎯 使用场景

### ✅ 适合
- 临时演示
- 快速分享
- 开发测试
- PPT展示
- 静态网站

### ❌ 不适合
- 长期生产环境
- 需要固定域名
- 需要数据库
- 需要服务器端逻辑

---

## 🌐 其他部署方案（备选）

### 方案2：GitHub Pages（永久免费）
**优点**：
- 永久链接
- 自定义域名
- 版本控制

**缺点**：
- 需要GitHub账号
- 配置较复杂
- 部署较慢（几分钟）

**适用**：长期项目、开源项目

---

### 方案3：Vercel（永久免费）
**优点**：
- 30秒部署
- 自动HTTPS
- 支持动态网站

**缺点**：
- 需要注册
- 有配额限制

**适用**：前端项目、Next.js

---

### 方案4：Netlify（永久免费）
**优点**：
- 拖拽上传
- 自动部署
- 表单处理

**缺点**：
- 需要注册
- 有配额限制

**适用**：静态网站、JAMstack

---

## 📚 相关文件

**脚本位置**：
```
~/.openclaw/workspace/deploy_website.sh
```

**上次部署**：
- 网站：OpenClaw演讲PPT
- URL：https://camp-issue-nut-liked.trycloudflare.com
- 时间：2026-03-12 19:59
- 状态：✅ 运行中

---

## 💡 快速命令

**一键部署**：
```bash
cd /path/to/website && \
nohup python3 -m http.server 8889 & \
sleep 2 && \
nohup cloudflared tunnel --url http://localhost:8889 --no-autoupdate &
```

**一键停止**：
```bash
pkill -f cloudflared && pkill -f "http.server 8889"
```

---

**更新时间**：2026-03-12 20:50
**小龙虾整理** 🦞
