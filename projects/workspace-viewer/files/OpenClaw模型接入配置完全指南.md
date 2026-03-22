# OpenClaw模型接入配置完全指南

## 🎯 目标

详细讲解如何在OpenClaw中配置和接入AI模型

---

## 📋 配置文件位置

```
~/.openclaw/openclaw.json
```

---

## 🏗️ 配置结构

### 完整配置示例

```json
{
  "env": {
    "DEEPSEEK_API_KEY": "sk-xxxxx",
    "BRAVE_API_KEY": "BSAHH_xxxxx"
  },
  "models": {
    "mode": "merge",
    "default": "zai/glm-5",
    "providers": {
      "deepseek": {
        "baseUrl": "https://api.deepseek.com/v1",
        "apiKey": "${DEEPSEEK_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "deepseek-chat",
            "name": "DeepSeek Chat",
            "api": "openai-completions",
            "reasoning": false,
            "input": ["text"],
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      },
      "zai": {
        "baseUrl": "https://open.bigmodel.cn/api/coding/paas/v4",
        "api": "openai-completions",
        "models": [
          {
            "id": "glm-5",
            "name": "GLM-5",
            "reasoning": true,
            "input": ["text"],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 204800,
            "maxTokens": 131072
          }
        ]
      }
    }
  }
}
```

---

## 📝 配置字段说明

### 1. 顶层字段

| 字段 | 说明 | 必需 |
|------|------|------|
| `env` | 环境变量（存储API密钥） | ❌ |
| `models` | 模型配置 | ✅ |
| `auth` | 认证配置 | ❌ |
| `gateway` | Gateway配置 | ❌ |

---

### 2. models字段

```json
{
  "models": {
    "mode": "merge",           // merge（合并）或 replace（替换）
    "default": "zai/glm-5",    // 默认模型（格式：provider/model-id）
    "providers": {             // 提供商配置
      // ...
    }
  }
}
```

**mode说明**：
- `merge` - 与默认配置合并（推荐）
- `replace` - 完全替换默认配置

---

### 3. providers字段

每个provider包含：

```json
{
  "providers": {
    "<provider-id>": {
      "baseUrl": "https://api.example.com/v1",  // API基础URL
      "apiKey": "${ENV_VAR}",                     // API密钥（可引用环境变量）
      "api": "openai-completions",                // API类型
      "headers": {                                // 自定义请求头（可选）
        "X-Custom-Header": "value"
      },
      "models": [                                 // 模型列表
        {
          "id": "model-id",
          "name": "Model Name",
          "api": "openai-completions",
          "reasoning": false,
          "input": ["text"],
          "contextWindow": 128000,
          "maxTokens": 8192,
          "cost": {
            "input": 0.001,
            "output": 0.002,
            "cacheRead": 0,
            "cacheWrite": 0
          }
        }
      ]
    }
  }
}
```

---

### 4. model字段

| 字段 | 类型 | 说明 | 必需 |
|------|------|------|------|
| `id` | string | 模型ID | ✅ |
| `name` | string | 模型显示名称 | ✅ |
| `api` | string | API类型（openai-completions, anthropic等） | ✅ |
| `reasoning` | boolean | 是否支持推理 | ❌ |
| `input` | array | 输入类型（text, image, audio等） | ❌ |
| `contextWindow` | number | 上下文窗口大小 | ❌ |
| `maxTokens` | number | 最大输出token | ❌ |
| `cost` | object | 费用配置 | ❌ |

---

## 🔧 配置方法

### 方法1：手动编辑配置文件

```bash
# 打开配置文件
nano ~/.openclaw/openclaw.json

# 或使用你喜欢的编辑器
vim ~/.openclaw/openclaw.json
code ~/.openclaw/openclaw.json
```

---

### 方法2：使用命令行配置

```bash
# 设置默认模型
openclaw config set models.default "deepseek/deepseek-chat"

# 添加provider
openclaw config set 'models.providers.deepseek' --json '{
  "baseUrl": "https://api.deepseek.com/v1",
  "apiKey": "sk-xxxxx",
  "api": "openai-completions",
  "models": [
    {
      "id": "deepseek-chat",
      "name": "DeepSeek Chat"
    }
  ]
}'

# 查看配置
openclaw config get models.providers.deepseek
```

---

### 方法3：使用环境变量

```bash
# 1. 设置环境变量
export DEEPSEEK_API_KEY="sk-xxxxx"

# 2. 在配置中引用
{
  "models": {
    "providers": {
      "deepseek": {
        "apiKey": "${DEEPSEEK_API_KEY}"
      }
    }
  }
}
```

---

## 🎯 常见模型提供商配置

### 1. DeepSeek（推荐，性价比高）

```json
{
  "models": {
    "providers": {
      "deepseek": {
        "baseUrl": "https://api.deepseek.com/v1",
        "apiKey": "${DEEPSEEK_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "deepseek-chat",
            "name": "DeepSeek Chat",
            "reasoning": false,
            "input": ["text"],
            "contextWindow": 128000,
            "maxTokens": 8192
          },
          {
            "id": "deepseek-reasoner",
            "name": "DeepSeek Reasoner",
            "reasoning": true,
            "input": ["text"],
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://platform.deepseek.com/api_keys

---

### 2. GLM（智谱AI）

```json
{
  "models": {
    "providers": {
      "zai": {
        "baseUrl": "https://open.bigmodel.cn/api/coding/paas/v4",
        "apiKey": "${GLM_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "glm-5",
            "name": "GLM-5",
            "reasoning": true,
            "input": ["text"],
            "contextWindow": 204800,
            "maxTokens": 131072,
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            }
          },
          {
            "id": "glm-4.7-flash",
            "name": "GLM-4.7 Flash",
            "reasoning": true,
            "input": ["text"],
            "contextWindow": 204800,
            "maxTokens": 131072
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://open.bigmodel.cn/

---

### 3. Moonshot（月之暗面）

```json
{
  "models": {
    "providers": {
      "moonshot": {
        "baseUrl": "https://api.moonshot.cn/v1",
        "apiKey": "${MOONSHOT_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "moonshot-v1-8k",
            "name": "Moonshot V1 8K",
            "contextWindow": 8192,
            "maxTokens": 4096
          },
          {
            "id": "moonshot-v1-32k",
            "name": "Moonshot V1 32K",
            "contextWindow": 32768,
            "maxTokens": 4096
          },
          {
            "id": "moonshot-v1-128k",
            "name": "Moonshot V1 128K",
            "contextWindow": 131072,
            "maxTokens": 4096
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://platform.moonshot.cn/

---

### 4. OpenAI

```json
{
  "models": {
    "providers": {
      "openai": {
        "baseUrl": "https://api.openai.com/v1",
        "apiKey": "${OPENAI_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "gpt-4o",
            "name": "GPT-4o",
            "contextWindow": 128000,
            "maxTokens": 4096
          },
          {
            "id": "gpt-4o-mini",
            "name": "GPT-4o Mini",
            "contextWindow": 128000,
            "maxTokens": 4096
          },
          {
            "id": "gpt-4-turbo",
            "name": "GPT-4 Turbo",
            "contextWindow": 128000,
            "maxTokens": 4096
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://platform.openai.com/api-keys

---

### 5. Anthropic Claude

```json
{
  "models": {
    "providers": {
      "anthropic": {
        "baseUrl": "https://api.anthropic.com",
        "apiKey": "${ANTHROPIC_API_KEY}",
        "api": "anthropic",
        "models": [
          {
            "id": "claude-3-5-sonnet-20241022",
            "name": "Claude 3.5 Sonnet",
            "contextWindow": 200000,
            "maxTokens": 8192
          },
          {
            "id": "claude-3-5-haiku-20241022",
            "name": "Claude 3.5 Haiku",
            "contextWindow": 200000,
            "maxTokens": 8192
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://console.anthropic.com/

---

### 6. 通义千问（阿里云）

```json
{
  "models": {
    "providers": {
      "qwen": {
        "baseUrl": "https://dashscope.aliyuncs.com/compatible-mode/v1",
        "apiKey": "${QWEN_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "qwen-max",
            "name": "Qwen Max",
            "contextWindow": 32768,
            "maxTokens": 8192
          },
          {
            "id": "qwen-plus",
            "name": "Qwen Plus",
            "contextWindow": 32768,
            "maxTokens": 8192
          },
          {
            "id": "qwen-turbo",
            "name": "Qwen Turbo",
            "contextWindow": 8192,
            "maxTokens": 2048
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://dashscope.console.aliyun.com/

---

### 7. 文心一言（百度）

```json
{
  "models": {
    "providers": {
      "ernie": {
        "baseUrl": "https://aip.baidubce.com/rpc/2.0/ai_custom/v1",
        "apiKey": "${ERNIE_API_KEY}",
        "api": "ernie",
        "models": [
          {
            "id": "ernie-4.0-8k",
            "name": "ERNIE 4.0 8K",
            "contextWindow": 8192,
            "maxTokens": 2048
          },
          {
            "id": "ernie-3.5-8k",
            "name": "ERNIE 3.5 8K",
            "contextWindow": 8192,
            "maxTokens": 2048
          }
        ]
      }
    }
  }
}
```

**获取API密钥**：https://console.bce.baidu.com/qianfan/

---

## 🔄 切换默认模型

### 方法1：修改配置文件

```json
{
  "models": {
    "default": "deepseek/deepseek-chat"
  }
}
```

### 方法2：使用命令行

```bash
# 切换到DeepSeek
openclaw config set models.default "deepseek/deepseek-chat"

# 切换到GLM-5
openclaw config set models.default "zai/glm-5"

# 切换到Moonshot
openclaw config set models.default "moonshot/moonshot-v1-8k"
```

---

## ✅ 验证配置

### 1. 查看当前配置

```bash
# 查看所有模型配置
openclaw config get models

# 查看默认模型
openclaw config get models.default

# 查看特定provider
openclaw config get models.providers.deepseek
```

### 2. 测试模型连接

```bash
# 启动OpenClaw Gateway
openclaw gateway start

# 测试对话
openclaw chat "你好，测试一下"
```

### 3. 检查配置文件

```bash
# 验证JSON格式
cat ~/.openclaw/openclaw.json | jq .

# 查看完整配置
cat ~/.openclaw/openclaw.json
```

---

## 🚀 完整配置示例

### 多模型配置

```json
{
  "env": {
    "DEEPSEEK_API_KEY": "sk-xxxxx",
    "GLM_API_KEY": "xxxxx.xxxxx",
    "MOONSHOT_API_KEY": "sk-xxxxx",
    "OPENAI_API_KEY": "sk-xxxxx"
  },
  "models": {
    "mode": "merge",
    "default": "zai/glm-5",
    "providers": {
      "deepseek": {
        "baseUrl": "https://api.deepseek.com/v1",
        "apiKey": "${DEEPSEEK_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "deepseek-chat",
            "name": "DeepSeek Chat",
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      },
      "zai": {
        "baseUrl": "https://open.bigmodel.cn/api/coding/paas/v4",
        "apiKey": "${GLM_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "glm-5",
            "name": "GLM-5",
            "reasoning": true,
            "contextWindow": 204800,
            "maxTokens": 131072
          }
        ]
      },
      "moonshot": {
        "baseUrl": "https://api.moonshot.cn/v1",
        "apiKey": "${MOONSHOT_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "moonshot-v1-8k",
            "name": "Moonshot V1 8K",
            "contextWindow": 8192,
            "maxTokens": 4096
          }
        ]
      },
      "openai": {
        "baseUrl": "https://api.openai.com/v1",
        "apiKey": "${OPENAI_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "gpt-4o-mini",
            "name": "GPT-4o Mini",
            "contextWindow": 128000,
            "maxTokens": 4096
          }
        ]
      }
    }
  }
}
```

---

## 🔒 安全建议

### 1. 使用环境变量

❌ **不推荐**：
```json
{
  "apiKey": "sk-xxxxx"
}
```

✅ **推荐**：
```json
{
  "apiKey": "${DEEPSEEK_API_KEY}"
}
```

### 2. 不要提交配置文件

```bash
# 添加到.gitignore
echo "~/.openclaw/openclaw.json" >> ~/.gitignore
```

### 3. 定期更换API密钥

- 定期轮换密钥
- 不要在多个地方使用同一密钥
- 监控API使用量

---

## 🐛 常见问题

### 1. 模型找不到

**错误**：`Model not found: deepseek/deepseek-chat`

**解决**：
```bash
# 检查provider配置
openclaw config get models.providers.deepseek

# 检查模型ID是否正确
openclaw config get models.providers.deepseek.models
```

### 2. API密钥无效

**错误**：`Invalid API key`

**解决**：
```bash
# 检查环境变量
echo $DEEPSEEK_API_KEY

# 或直接检查配置
cat ~/.openclaw/openclaw.json | grep apiKey
```

### 3. 连接超时

**错误**：`Connection timeout`

**解决**：
- 检查baseUrl是否正确
- 检查网络连接
- 尝试使用代理

---

## 📚 参考资料

- **OpenClaw文档**：https://docs.openclaw.ai
- **Model Providers**：https://docs.openclaw.ai/concepts/model-providers
- **配置指南**：https://docs.openclaw.ai/configuration

---

## 💡 最佳实践

1. **使用环境变量** - 不要硬编码API密钥
2. **配置多个模型** - 根据需求切换不同模型
3. **定期备份配置** - 保存配置文件备份
4. **监控使用量** - 关注API调用和费用
5. **测试配置** - 修改后立即测试

---

**创建时间**：2026-03-18 00:40
**作者**：小龙虾 🦞
