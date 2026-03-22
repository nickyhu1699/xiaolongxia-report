# 🦞 OpenClaw Skill 开发完全指南

## 📚 目录

1. [什么是OpenClaw Skill？](#什么是openclaw-skill)
2. [工作原理](#工作原理)
3. [目录结构](#目录结构)
4. [核心文件详解](#核心文件详解)
5. [开发步骤](#开发步骤)
6. [实战案例](#实战案例)
7. [最佳实践](#最佳实践)

---

## 什么是OpenClaw Skill？

**OpenClaw Skill = 可复用的AI能力模块**

就像手机App一样，每个Skill是一个独立的能力单元，可以被OpenClaw调用。

**类比**：
- **App Store** → **ClawHub**（技能市场）
- **iOS App** → **OpenClaw Skill**（技能）
- **App代码** → **Python/Node.js脚本**
- **App描述** → **SKILL.md**

**核心特点**：
- ✅ **可复用** - 写一次，到处使用
- ✅ **可分享** - 发布到ClawHub市场
- ✅ **可组合** - 多个Skill组合使用
- ✅ **标准化** - 统一的接口规范

---

## 工作原理

### 🔄 执行流程

```
用户请求
   ↓
OpenClaw理解意图
   ↓
匹配SKILL.md描述
   ↓
执行Skill脚本
   ↓
返回结果给用户
```

### 📊 技术架构

```
┌─────────────────┐
│  用户对话输入    │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  OpenClaw Core  │ ← 理解意图
│  (AI大脑)       │ ← 匹配Skill
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  SKILL.md       │ ← 决定用哪个Skill
│  (描述文件)     │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  scripts/*.py   │ ← 执行具体逻辑
│  (脚本文件)     │
         │
         ↓
┌─────────────────┐
│  外部API/工具   │ ← 调用实际服务
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  返回结果       │
└─────────────────┘
```

---

## 目录结构

### 标准Skill目录

```
my-skill/                    # Skill根目录
├── SKILL.md                 # ⭐ 核心：Skill描述和使用指南
├── README.md                # 项目说明（可选）
├── package.json             # Node.js依赖（如果用Node）
├── requirements.txt         # Python依赖（如果用Python）
├── .env                     # 环境变量（密钥等）
├── env.example.txt          # 环境变量示例
├── scripts/                 # 脚本目录
│   ├── main.py              # 主脚本
│   ├── helper.js            # 辅助脚本
│   └── utils.py             # 工具函数
├── references/              # 参考文档
│   ├── api.md               # API文档
│   └── examples.md          # 使用示例
├── assets/                  # 资源文件
│   ├── images/              # 图片
│   └── templates/           # 模板
└── tests/                   # 测试文件
    └── test_main.py
```

### 最小化Skill

```
simple-skill/
├── SKILL.md                 # 必须
└── scripts/
    └── main.py              # 必须
```

---

## 核心文件详解

### 1. SKILL.md - 最重要的文件

**作用**：告诉OpenClaw这个Skill是做什么的，以及如何使用

**结构**：

```markdown
---
name: skill-name                    # Skill名称
description: 一句话描述              # 触发条件描述
---

# Skill标题

详细描述...

## 工作流程

步骤1...
步骤2...

## 使用示例

示例1...
示例2...

## 参数说明

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|

## 注意事项

- 注意1
- 注意2
```

**关键要素**：

#### A. YAML头部（必须）

```yaml
---
name: ai-news-collector                    # 唯一标识
description: 当用户询问AI新闻时使用        # 触发条件
---
```

**description写法技巧**：
- ✅ 好："当用户询问AI新闻时使用"
- ❌ 差："一个AI新闻工具"
- ✅ 好："当用户需要创建小红书笔记时触发"
- ❌ 差："小红书笔记工具"

**OpenClaw会根据description自动判断何时调用这个Skill！**

---

#### B. 工作流程（建议）

```markdown
## 工作流程

### 第一步：收集数据

1. 搜索关键词A
2. 搜索关键词B
3. 合并结果

### 第二步：处理数据

1. 去重
2. 排序
3. 格式化

### 第三步：输出结果

返回格式化报告
```

**这是给OpenClaw看的执行指南！**

---

#### C. 使用示例（建议）

```markdown
## 使用示例

**用户说**："今天有什么AI新闻？"
**Skill执行**：搜索最新AI新闻，生成报告

**用户说**："帮我总结这周的AI动态"
**Skill执行**：搜索本周AI新闻，按热度排序

**用户说**："最近有什么火的AI产品？"
**Skill执行**：重点搜索社区爆款产品
```

---

### 2. scripts/ - 脚本目录

**存放实际执行的代码**

#### Python脚本示例

```python
#!/usr/bin/env python3
# scripts/main.py

import sys
import json
from pathlib import Path

def main():
    """主函数"""
    # 1. 读取参数（如果有）
    args = sys.argv[1:] if len(sys.argv) > 1 else []
    
    # 2. 执行核心逻辑
    result = do_something(args)
    
    # 3. 输出结果
    print(json.dumps(result, ensure_ascii=False, indent=2))

def do_something(args):
    """核心逻辑"""
    # 你的代码...
    return {
        "status": "success",
        "data": "处理结果"
    }

if __name__ == "__main__":
    main()
```

#### Node.js脚本示例

```javascript
// scripts/main.js

async function main() {
    // 1. 读取参数
    const args = process.argv.slice(2);
    
    // 2. 执行逻辑
    const result = await doSomething(args);
    
    // 3. 输出结果
    console.log(JSON.stringify(result, null, 2));
}

async function doSomething(args) {
    // 你的代码...
    return {
        status: "success",
        data: "处理结果"
    };
}

main().catch(console.error);
```

---

### 3. 依赖管理

#### Python (requirements.txt)

```
requests>=2.31.0
beautifulsoup4>=4.12.0
python-dotenv>=1.0.0
```

#### Node.js (package.json)

```json
{
  "name": "my-skill",
  "version": "1.0.0",
  "dependencies": {
    "axios": "^1.6.0",
    "cheerio": "^1.0.0-rc.12"
  }
}
```

---

### 4. 环境变量 (.env)

```bash
# API密钥
OPENAI_API_KEY=sk-xxx
ANTHROPIC_API_KEY=sk-xxx

# 配置
MAX_RESULTS=10
TIMEOUT=30
```

**注意**：
- `.env` 不要提交到Git
- 提供 `env.example.txt` 作为示例

---

## 开发步骤

### 步骤1：规划Skill

**问自己3个问题**：

1. **这个Skill解决什么问题？**
   - 例：自动收集AI新闻

2. **用户会怎么触发它？**
   - 例："今天有什么AI新闻？"

3. **需要什么资源？**
   - API密钥？浏览器？数据库？

---

### 步骤2：创建目录结构

```bash
# 创建Skill目录
mkdir -p ~/.openclaw/skills/my-skill/{scripts,references,assets}

# 创建核心文件
touch ~/.openclaw/skills/my-skill/SKILL.md
touch ~/.openclaw/skills/my-skill/scripts/main.py
touch ~/.openclaw/skills/my-skill/requirements.txt
```

---

### 步骤3：编写SKILL.md

```markdown
---
name: my-skill
description: 当用户说XXX时使用这个技能
---

# 我的技能

## 功能描述

这个技能可以...

## 工作流程

### 第一步：...

### 第二步：...

## 使用示例

**用户**："..."
**执行**：...
```

---

### 步骤4：编写脚本

```python
# scripts/main.py

def main():
    # 实现你的逻辑
    print("Hello from my skill!")

if __name__ == "__main__":
    main()
```

---

### 步骤5：测试

```bash
# 手动测试
cd ~/.openclaw/skills/my-skill
python3 scripts/main.py

# 在OpenClaw中测试
# 直接对话："帮我XXX"
```

---

### 步骤6：发布（可选）

**发布到ClawHub**：

1. 打包成ZIP
2. 访问 https://clawhub.com
3. 上传技能包
4. 填写描述
5. 发布

---

## 实战案例

### 案例1：简单的问候Skill

**目录**：
```
greeting-skill/
├── SKILL.md
└── scripts/
    └── greet.py
```

**SKILL.md**：
```markdown
---
name: greeting
description: 当用户需要问候语或祝福时使用
---

# 问候语生成器

生成各种场合的问候语和祝福。

## 工作流程

1. 理解场合（生日/节日/日常）
2. 生成对应问候语
3. 返回结果

## 使用示例

**用户**："给我一个生日祝福"
**返回**："🎂 生日快乐！愿你..."
```

**scripts/greet.py**：
```python
#!/usr/bin/env python3
import random

greetings = {
    "生日": [
        "🎂 生日快乐！愿你心想事成！",
        "🎉 生日快乐！天天开心！",
        "🎈 生日快乐！万事如意！"
    ],
    "新年": [
        "🎊 新年快乐！万事如意！",
        "🧧 新年快乐！财源广进！"
    ]
}

def main():
    occasion = "生日"  # 简化示例
    print(random.choice(greetings.get(occasion, ["祝福你！"])))

if __name__ == "__main__":
    main()
```

---

### 案例2：网页抓取Skill

**SKILL.md**：
```markdown
---
name: web-scraper
description: 当用户需要抓取网页内容时使用
---

# 网页内容抓取器

抓取网页并提取关键信息。

## 工作流程

1. 接收URL
2. 抓取网页
3. 提取内容
4. 返回Markdown格式

## 参数

| 参数 | 说明 | 示例 |
|------|------|------|
| url | 网页地址 | https://example.com |
```

**scripts/scrape.py**：
```python
#!/usr/bin/env python3
import sys
import requests
from bs4 import BeautifulSoup

def scrape(url):
    """抓取网页"""
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    
    # 提取标题
    title = soup.find('title').text if soup.find('title') else ''
    
    # 提取正文
    content = soup.find('body').text.strip() if soup.find('body') else ''
    
    return f"# {title}\n\n{content}"

def main():
    if len(sys.argv) < 2:
        print("用法: python scrape.py <URL>")
        return
    
    url = sys.argv[1]
    result = scrape(url)
    print(result)

if __name__ == "__main__":
    main()
```

---

## 最佳实践

### 1. SKILL.md写法

**✅ 好的描述**：
```yaml
description: 当用户询问天气、温度或预报时使用
```

**❌ 差的描述**：
```yaml
description: 一个天气工具
```

**原因**：OpenClaw根据description判断何时调用，要写得具体！

---

### 2. 错误处理

```python
try:
    result = api_call()
except Exception as e:
    print(f"❌ 错误: {e}")
    sys.exit(1)
```

---

### 3. 日志记录

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

logger.info("开始执行...")
logger.error("发生错误")
```

---

### 4. 环境变量管理

```python
from dotenv import load_dotenv
import os

load_dotenv()

API_KEY = os.getenv("API_KEY")
if not API_KEY:
    raise ValueError("缺少API_KEY环境变量")
```

---

### 5. 模块化设计

```python
# scripts/utils.py
def helper_function():
    pass

# scripts/main.py
from utils import helper_function

def main():
    helper_function()
```

---

## 🎯 总结

### OpenClaw Skill = 三要素

1. **SKILL.md** - 告诉OpenClaw何时用、怎么用
2. **scripts/** - 实际执行的代码
3. **依赖管理** - 环境配置

### 开发流程

```
规划 → 创建目录 → 写SKILL.md → 写脚本 → 测试 → 发布
```

### 关键点

- ✅ **description要具体** - OpenClaw靠它判断
- ✅ **工作流程要清晰** - 给OpenClaw看的执行指南
- ✅ **错误处理要完善** - 提升鲁棒性
- ✅ **模块化设计** - 易于维护

---

## 🚀 立即开始

**创建你的第一个Skill**：

```bash
# 1. 创建目录
mkdir -p ~/.openclaw/skills/hello-world/scripts

# 2. 创建SKILL.md
cat > ~/.openclaw/skills/hello-world/SKILL.md << 'EOF'
---
name: hello-world
description: 当用户测试或演示时使用
---

# Hello World

简单的演示技能。

## 工作流程

1. 输出问候语
2. 返回结果

## 使用示例

**用户**："测试一下"
**返回**："Hello from OpenClaw Skill!"
EOF

# 3. 创建脚本
cat > ~/.openclaw/skills/hello-world/scripts/main.py << 'EOF'
#!/usr/bin/env python3
print("Hello from OpenClaw Skill!")
EOF

chmod +x ~/.openclaw/skills/hello-world/scripts/main.py

# 4. 测试
cd ~/.openclaw/skills/hello-world
python3 scripts/main.py
```

---

**小龙虾生成** 🦞
**文档位置**：`~/.openclaw/workspace/openclaw_skill_development_guide.md`
