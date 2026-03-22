# 🦞 小龙虾工作手册

## 网站部署（默认方案）

**当用户要求"部署网站"、"把XXX发布到网上"时，默认使用Cloudflare Tunnel**

### 快速部署命令

```bash
# 方法1：使用脚本（推荐）
~/.openclaw/workspace/deploy_website.sh /path/to/website

# 方法2：手动部署
cd /path/to/website
nohup python3 -m http.server 8889 &
sleep 2
nohup cloudflared tunnel --url http://localhost:8889 --no-autoupdate &
sleep 5
tail -f /tmp/cloudflared_8889.log  # 查看URL
```

### 部署流程

1. **确认网站目录**
   - 检查是否有index.html或入口文件
   - 确认文件路径

2. **启动HTTP服务器**
   ```bash
   cd /path/to/website
   python3 -m http.server 8889
   ```

3. **启动Cloudflare Tunnel**
   ```bash
   cloudflared tunnel --url http://localhost:8889
   ```

4. **获取公网URL**
   - 等待5-10秒
   - URL格式：`https://xxx.trycloudflare.com`
   - 返回给用户

5. **说明**
   - 告知用户这是临时链接
   - 有效期：几小时到几天
   - 如需永久链接，推荐GitHub Pages

### 优点

- ⚡ 30秒上线
- 💰 完全免费
- 🌐 公网访问
- 🔒 自动HTTPS
- 📱 全球CDN

### 注意事项

- 适合临时分享、演示
- 不适合长期生产环境
- 重启后会生成新URL
- 如需永久部署，推荐GitHub Pages

### 相关文档

**完整文档**：`WEBSITE_DEPLOYMENT.md`
**部署脚本**：`deploy_website.sh`

---

## 其他常用工具

### 网页抓取
- **Jina.ai Reader**（首选）：`python3 ~/workspace/jina_reader.py <URL>`
- **浏览器自动化**：`python3 ~/workspace/browser_fetch.py [--headed] <URL>`

### AI图片生成
- **Skill位置**：`~/.openclaw/skills/ai-image-generator/`
- **使用**：对话即可，"帮我生成一张XXX图片"

### 定时任务
- **配置文件**：`~/Library/LaunchAgents/`
- **日志位置**：`~/.openclaw/logs/`

---

**更新时间**：2026-03-12 20:50
