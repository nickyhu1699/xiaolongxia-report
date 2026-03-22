# 每日工作总结定时任务配置指南

## 📋 功能说明

每天早上7点自动：
1. 读取前一天的工作记录（memory/YYYY-MM-DD.md）
2. 生成工作总结文章
3. 创建封面图并上传
4. 推送到微信公众号草稿箱
5. 保存文章到本地

---

## 🚀 快速配置

### 1️⃣ 赋予执行权限

```bash
chmod +x ~/.openclaw/workspace/run_daily_summary.sh
chmod +x ~/.openclaw/workspace/setup_cron.sh
```

### 2️⃣ 配置Cron定时任务

```bash
cd ~/.openclaw/workspace
./setup_cron.sh
```

### 3️⃣ 验证配置

```bash
# 查看当前Cron任务
crontab -l

# 手动测试执行
./run_daily_summary.sh

# 查看日志
tail -f ~/.openclaw/logs/daily_summary.log
```

---

## 📂 文件结构

```
~/.openclaw/
├── workspace/
│   ├── daily_summary_generator.py    # 核心脚本
│   ├── run_daily_summary.sh          # Cron执行脚本
│   ├── setup_cron.sh                 # Cron配置脚本
│   ├── wechat_draft_pusher.py        # 微信推送工具
│   └── config.json                   # 微信配置
├── memory/
│   └── 2026-03-11.md                 # 每日工作记录
├── daily_summaries/                  # 生成的文章
│   └── 2026-03-11.md
└── logs/
    └── daily_summary.log             # 执行日志
```

---

## ⚙️ Cron表达式说明

```
0 7 * * * /path/to/run_daily_summary.sh
│ │ │ │ │
│ │ │ │ └── 星期几（0-7，0和7都是周日）
│ │ │ └──── 月份（1-12）
│ │ └────── 日期（1-31）
│ └──────── 小时（0-23）
└────────── 分钟（0-59）
```

**当前配置**：每天早上7:00执行

**其他示例**：
- `0 8 * * *` - 每天早上8:00
- `0 9 * * 1-5` - 周一到周五早上9:00
- `0 18 * * *` - 每天下午6:00

---

## 🧪 测试

### 手动测试

```bash
cd ~/.openclaw/workspace
python3 daily_summary_generator.py
```

### 查看日志

```bash
tail -f ~/.openclaw/logs/daily_summary.log
```

---

## ⚠️ 注意事项

### 1. 确保有前一天的工作记录

脚本会读取 `memory/YYYY-MM-DD.md` 文件，如果没有记录会跳过。

### 2. 确保Python环境正确

```bash
which python3
# 应该输出：/usr/bin/python3 或 /opt/homebrew/bin/python3
```

### 3. 确保微信配置正确

```bash
cat ~/.openclaw/workspace/config.json
# 应该包含正确的AppID和AppSecret
```

### 4. Cron环境变量

如果遇到问题，检查Cron的环境变量是否包含Python路径。

---

## 🔧 故障排查

### 问题1：Cron任务没有执行

**检查**：
```bash
# 查看Cron服务是否运行
sudo launchctl list | grep cron

# 查看Cron日志
log show --predicate 'process == "cron"' --last 1h
```

**解决**：
```bash
# 重启Cron服务
sudo launchctl unload -w /System/Library/LaunchDaemons/com.vix.cron.plist
sudo launchctl load -w /System/Library/LaunchDaemons/com.vix.cron.plist
```

---

### 问题2：Python脚本执行失败

**检查日志**：
```bash
tail -f ~/.openclaw/logs/daily_summary.log
```

**常见原因**：
- Python路径不正确
- 依赖包未安装
- 配置文件错误

---

### 问题3：微信推送失败

**检查**：
1. IP白名单是否配置
2. AppID和AppSecret是否正确
3. 网络连接是否正常

---

## 📊 日志示例

```
========================================
执行时间: 2026-03-12 07:00:00
工作目录: /Users/sheyujituan/.openclaw/workspace
📅 生成日期: 2026-03-11
✅ 读取记忆文件: /Users/sheyujituan/.openclaw/memory/2026-03-11.md
📝 生成工作总结...
🎨 生成封面图...
✅ 封面图已生成: cover_daily_summary_2026-03-11.jpg
📤 上传封面图...
✅ 封面图上传成功
📝 创建草稿...
✅ 草稿创建成功
✅ 推送成功！
✅ 文章已保存: /Users/sheyujituan/.openclaw/daily_summaries/2026-03-11.md
✅ 执行成功
```

---

## 🎯 自定义

### 修改执行时间

编辑Cron任务：
```bash
crontab -e
```

修改时间（例如改为早上8点）：
```
0 8 * * * /Users/sheyujituan/.openclaw/workspace/run_daily_summary.sh
```

### 修改文章模板

编辑 `daily_summary_generator.py` 中的 `generate_summary_from_memory` 方法。

### 修改封面图样式

编辑 `daily_summary_generator.py` 中的 `create_cover` 方法。

---

## 📞 联系与反馈

如有问题，请检查日志文件：
- 执行日志：`~/.openclaw/logs/daily_summary.log`
- 系统日志：`log show --predicate 'process == "cron"' --last 1h`

---

**创建时间**: 2026-03-12  
**作者**: OpenClaw AI Assistant 🦞
