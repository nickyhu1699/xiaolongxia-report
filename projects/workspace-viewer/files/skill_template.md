# OpenClaw Skill 快速上手模板

## 📁 完整Skill模板

```
my-skill/
├── SKILL.md
├── README.md
├── scripts/
│   └── main.py
├── requirements.txt
├── .env
└── env.example.txt
```

---

## 📝 SKILL.md 模板

```markdown
---
name: skill-name
description: 当用户XXX时使用这个技能
---

# Skill标题

一句话描述这个技能的功能。

## 功能说明

详细描述这个技能能做什么。

## 工作流程

### 第一步：[步骤名称]

1. 具体操作1
2. 具体操作2

### 第二步：[步骤名称]

1. 具体操作1
2. 具体操作2

## 参数说明

| 参数 | 类型 | 必填 | 说明 | 默认值 |
|------|------|------|------|--------|
| param1 | string | 是 | 参数说明 | - |
| param2 | number | 否 | 参数说明 | 10 |

## 使用示例

### 示例1

**用户输入**："XXX"
**执行结果**：XXX

### 示例2

**用户输入**："XXX"
**执行结果**：XXX

## 输出格式

\`\`\`
结果格式说明
\`\`\`

## 注意事项

- 注意事项1
- 注意事项2

## 依赖

- Python 3.8+
- 必需的Python包见 requirements.txt

## 配置

复制 `env.example.txt` 为 `.env` 并填写配置：

\`\`\`bash
cp env.example.txt .env
\`\`\`

## 作者

你的名字

## 许可证

MIT
```

---

## 🐍 scripts/main.py 模板

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Skill名称 - 简短描述

作者: 你的名字
日期: YYYY-MM-DD
"""

import sys
import os
import json
import logging
from pathlib import Path
from typing import Dict, Any

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class SkillExecutor:
    """Skill执行器"""
    
    def __init__(self):
        """初始化"""
        self.name = "skill-name"
        self.version = "1.0.0"
        logger.info(f"初始化 {self.name} v{self.version}")
    
    def validate_input(self, args: list) -> Dict[str, Any]:
        """
        验证输入参数
        
        Args:
            args: 命令行参数
            
        Returns:
            验证后的参数字典
        """
        params = {}
        
        # 示例：解析参数
        if len(args) > 0:
            params['input'] = args[0]
        
        logger.info(f"参数验证完成: {params}")
        return params
    
    def execute(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        执行核心逻辑
        
        Args:
            params: 参数字典
            
        Returns:
            执行结果
        """
        logger.info("开始执行...")
        
        try:
            # TODO: 在这里实现你的核心逻辑
            
            result = {
                "status": "success",
                "message": "执行成功",
                "data": {}
            }
            
            logger.info("执行完成")
            return result
            
        except Exception as e:
            logger.error(f"执行失败: {e}")
            return {
                "status": "error",
                "message": str(e),
                "data": None
            }
    
    def format_output(self, result: Dict[str, Any]) -> str:
        """
        格式化输出
        
        Args:
            result: 执行结果
            
        Returns:
            格式化的输出字符串
        """
        if result['status'] == 'success':
            output = f"✅ {result['message']}\n"
            if result['data']:
                output += json.dumps(result['data'], ensure_ascii=False, indent=2)
        else:
            output = f"❌ {result['message']}"
        
        return output

def main():
    """主函数"""
    # 1. 创建执行器
    executor = SkillExecutor()
    
    # 2. 验证输入
    args = sys.argv[1:]
    params = executor.validate_input(args)
    
    # 3. 执行
    result = executor.execute(params)
    
    # 4. 输出
    output = executor.format_output(result)
    print(output)

if __name__ == "__main__":
    main()
```

---

## 📦 requirements.txt 模板

```txt
# 核心依赖
requests>=2.31.0
python-dotenv>=1.0.0

# 数据处理
beautifulsoup4>=4.12.0
lxml>=4.9.0

# 工具库
click>=8.1.0
rich>=13.0.0
```

---

## 🔐 .env 模板

```bash
# API密钥
API_KEY=your_api_key_here
API_SECRET=your_api_secret_here

# 配置
DEBUG=false
TIMEOUT=30
MAX_RETRIES=3
```

---

## 📋 env.example.txt 模板

```bash
# 复制此文件为 .env 并填写真实值

# API密钥
API_KEY=
API_SECRET=

# 配置
DEBUG=false
TIMEOUT=30
MAX_RETRIES=3
```

---

## 📖 README.md 模板

```markdown
# Skill名称

简短描述这个技能的功能。

## 功能

- 功能1
- 功能2
- 功能3

## 安装

\`\`\`bash
# 安装依赖
pip install -r requirements.txt

# 配置环境变量
cp env.example.txt .env
# 编辑 .env 填写配置
\`\`\`

## 使用

### 在OpenClaw中使用

直接对话："帮我XXX"

### 命令行测试

\`\`\`bash
python scripts/main.py [参数]
\`\`\`

## 示例

### 示例1

输入: XXX
输出: XXX

### 示例2

输入: XXX
输出: XXX

## 配置说明

| 环境变量 | 说明 | 必填 |
|---------|------|------|
| API_KEY | API密钥 | 是 |
| API_SECRET | API密钥 | 是 |

## 开发

### 项目结构

\`\`\`
my-skill/
├── SKILL.md           # Skill描述
├── scripts/           # 脚本
│   └── main.py
├── requirements.txt   # 依赖
└── .env              # 配置
\`\`\`

### 本地测试

\`\`\`bash
# 1. 安装依赖
pip install -r requirements.txt

# 2. 配置环境变量
cp env.example.txt .env

# 3. 运行测试
python scripts/main.py test
\`\`\`

## 常见问题

### Q: XXX？

A: XXX

## 更新日志

### v1.0.0 (YYYY-MM-DD)

- 初始版本

## 许可证

MIT

## 作者

你的名字
```

---

## 🚀 一键创建Skill

```bash
#!/bin/bash
# create_skill.sh

SKILL_NAME=$1

if [ -z "$SKILL_NAME" ]; then
    echo "用法: ./create_skill.sh <skill-name>"
    exit 1
fi

# 创建目录
mkdir -p ~/.openclaw/skills/$SKILL_NAME/{scripts,assets,references}

# 创建文件
touch ~/.openclaw/skills/$SKILL_NAME/SKILL.md
touch ~/.openclaw/skills/$SKILL_NAME/README.md
touch ~/.openclaw/skills/$SKILL_NAME/scripts/main.py
touch ~/.openclaw/skills/$SKILL_NAME/requirements.txt
touch ~/.openclaw/skills/$SKILL_NAME/.env
touch ~/.openclaw/skills/$SKILL_NAME/env.example.txt

chmod +x ~/.openclaw/skills/$SKILL_NAME/scripts/main.py

echo "✅ Skill创建成功: ~/.openclaw/skills/$SKILL_NAME"
```

---

**小龙虾生成** 🦞
