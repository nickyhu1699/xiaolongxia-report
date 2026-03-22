# 自定义平台集成OpenClaw技术方案

## 🎯 目标

构建自己的平台与OpenClaw AI助手（小龙虾）进行交流互动

---

## 📋 方案概述

OpenClaw支持多种集成方式：

1. **HTTP API** - 直接调用OpenClaw Gateway
2. **WebSocket** - 实时双向通信
3. **Channel插件** - 自定义渠道集成
4. **Webhook** - 事件驱动集成

---

## 🏗️ OpenClaw架构

```
┌─────────────────────────────────────────┐
│         你的自定义平台                   │
│  (Web App / Mobile App / Desktop)       │
└─────────────────┬───────────────────────┘
                  │
                  │ HTTP API / WebSocket
                  │
┌─────────────────▼───────────────────────┐
│       OpenClaw Gateway                   │
│  (消息路由 + 会话管理 + 认证)           │
└─────────────────┬───────────────────────┘
                  │
                  │ 内部通信
                  │
┌─────────────────▼───────────────────────┐
│       AI Agent (小龙虾)                  │
│  (GLM-5 + Memory + Skills)              │
└─────────────────────────────────────────┘
```

---

## 💡 方案1：HTTP API集成（最简单）

### 1.1 获取API密钥

**配置文件位置**：`~/.openclaw/openclaw.json`

```json
{
  "gateway": {
    "port": 18800,
    "auth": {
      "enabled": true,
      "tokens": ["your-api-key-here"]
    }
  },
  "models": {
    "default": "zai/glm-5",
    "providers": {
      "zai": {
        "baseURL": "https://ai-gateway.trickle-lab.tech/api/v1",
        "apiKey": "your-provider-key"
      }
    }
  }
}
```

### 1.2 API调用示例

**发送消息**：
```python
import requests
import json

# OpenClaw Gateway地址
GATEWAY_URL = "http://localhost:18800"

# API密钥
API_KEY = "your-api-key-here"

# 发送消息
def send_message(session_id, message):
    url = f"{GATEWAY_URL}/api/chat/send"
    
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    
    data = {
        "session_id": session_id,
        "message": message,
        "context": {
            "user_id": "user_123",
            "user_name": "胡大大"
        }
    }
    
    response = requests.post(url, headers=headers, json=data)
    return response.json()

# 接收回复（轮询）
def get_response(session_id):
    url = f"{GATEWAY_URL}/api/chat/receive"
    
    headers = {
        "Authorization": f"Bearer {API_KEY}"
    }
    
    params = {
        "session_id": session_id
    }
    
    response = requests.get(url, headers=headers, params=params)
    return response.json()

# 使用示例
session_id = "session_123"

# 发送消息
send_message(session_id, "帮我写一篇公众号文章")

# 接收回复
response = get_response(session_id)
print(response["message"])
```

### 1.3 创建会话

```python
def create_session(user_id, user_name):
    url = f"{GATEWAY_URL}/api/session/create"
    
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    
    data = {
        "user_id": user_id,
        "user_name": user_name,
        "agent_id": "xiaolongxia",  # 指定小龙虾agent
        "config": {
            "model": "zai/glm-5",
            "memory_enabled": True
        }
    }
    
    response = requests.post(url, headers=headers, json=data)
    return response.json()["session_id"]

# 创建会话
session_id = create_session("user_123", "胡大大")
```

---

## 💡 方案2：WebSocket集成（实时）

### 2.1 WebSocket连接

```javascript
// 前端JavaScript示例
const ws = new WebSocket('ws://localhost:18800/ws');

// 连接打开
ws.onopen = function() {
    console.log('已连接到OpenClaw');
    
    // 发送认证
    ws.send(JSON.stringify({
        type: 'auth',
        token: 'your-api-key-here',
        user_id: 'user_123',
        user_name: '胡大大'
    }));
};

// 接收消息
ws.onmessage = function(event) {
    const data = JSON.parse(event.data);
    
    if (data.type === 'message') {
        console.log('AI回复:', data.message);
        // 显示在UI上
        displayMessage(data.message);
    }
};

// 发送消息
function sendMessage(message) {
    ws.send(JSON.stringify({
        type: 'message',
        session_id: 'session_123',
        message: message
    }));
}

// 使用示例
sendMessage('帮我写一篇公众号文章');
```

### 2.2 Python后端WebSocket

```python
import websocket
import json
import threading

class OpenClawClient:
    def __init__(self, api_key, user_id, user_name):
        self.api_key = api_key
        self.user_id = user_id
        self.user_name = user_name
        self.ws = None
        
    def connect(self):
        """连接到OpenClaw Gateway"""
        ws_url = "ws://localhost:18800/ws"
        self.ws = websocket.WebSocketApp(
            ws_url,
            on_open=self.on_open,
            on_message=self.on_message,
            on_error=self.on_error,
            on_close=self.on_close
        )
        
        # 启动WebSocket线程
        ws_thread = threading.Thread(target=self.ws.run_forever)
        ws_thread.daemon = True
        ws_thread.start()
    
    def on_open(self, ws):
        """连接打开时发送认证"""
        auth_msg = {
            "type": "auth",
            "token": self.api_key,
            "user_id": self.user_id,
            "user_name": self.user_name
        }
        ws.send(json.dumps(auth_msg))
        print("✅ 已连接到OpenClaw")
    
    def on_message(self, ws, message):
        """接收消息"""
        data = json.loads(message)
        
        if data["type"] == "message":
            print(f"AI回复: {data['message']}")
            # 触发回调
            if self.message_callback:
                self.message_callback(data["message"])
    
    def on_error(self, ws, error):
        """错误处理"""
        print(f"❌ 错误: {error}")
    
    def on_close(self, ws, close_status_code, close_msg):
        """连接关闭"""
        print("🔌 连接已关闭")
    
    def send_message(self, message, session_id="default"):
        """发送消息"""
        msg = {
            "type": "message",
            "session_id": session_id,
            "message": message
        }
        self.ws.send(json.dumps(msg))
    
    def set_message_callback(self, callback):
        """设置消息回调"""
        self.message_callback = callback

# 使用示例
def handle_ai_response(message):
    print(f"收到AI回复: {message}")

client = OpenClawClient(
    api_key="your-api-key-here",
    user_id="user_123",
    user_name="胡大大"
)

client.set_message_callback(handle_ai_response)
client.connect()

# 发送消息
client.send_message("帮我写一篇公众号文章")
```

---

## 💡 方案3：自定义Channel插件（最灵活）

### 3.1 Channel插件结构

OpenClaw支持自定义Channel插件，位于：`~/.openclaw/channels/`

```
~/.openclaw/channels/
└── my-custom-platform/
    ├── package.json
    ├── index.js
    ├── config.json
    └── README.md
```

### 3.2 创建自定义Channel

**package.json**：
```json
{
  "name": "openclaw-channel-myplatform",
  "version": "1.0.0",
  "description": "自定义平台Channel",
  "main": "index.js",
  "dependencies": {
    "express": "^4.18.2"
  }
}
```

**index.js**：
```javascript
const express = require('express');

class MyPlatformChannel {
    constructor(config, gateway) {
        this.config = config;
        this.gateway = gateway;
        this.app = express();
        this.app.use(express.json());
        
        // 设置路由
        this.setupRoutes();
    }
    
    setupRoutes() {
        // 接收来自你的平台的消息
        this.app.post('/webhook', async (req, res) => {
            try {
                const { user_id, user_name, message, session_id } = req.body;
                
                // 发送到OpenClaw Gateway
                const response = await this.gateway.send({
                    type: 'message',
                    session_id: session_id || `session_${user_id}`,
                    message: message,
                    context: {
                        user_id: user_id,
                        user_name: user_name
                    }
                });
                
                // 返回AI回复
                res.json({
                    success: true,
                    response: response.message
                });
            } catch (error) {
                res.status(500).json({
                    success: false,
                    error: error.message
                });
            }
        });
        
        // 健康检查
        this.app.get('/health', (req, res) => {
            res.json({ status: 'ok' });
        });
    }
    
    start() {
        const port = this.config.port || 3000;
        this.app.listen(port, () => {
            console.log(`✅ 自定义平台Channel已启动，端口: ${port}`);
        });
    }
    
    // 接收来自OpenClaw的消息
    async receive(message) {
        // 处理AI回复
        console.log('收到AI回复:', message);
        
        // 可以推送到你的平台（通过WebSocket、轮询等）
        // 例如：推送到你的Web应用
    }
}

module.exports = MyPlatformChannel;
```

**config.json**：
```json
{
  "name": "my-custom-platform",
  "version": "1.0.0",
  "port": 3000,
  "enabled": true,
  "webhook_url": "https://your-platform.com/webhook"
}
```

### 3.3 注册Channel

在OpenClaw配置文件中添加：
```json
{
  "channels": [
    {
      "name": "my-custom-platform",
      "enabled": true,
      "config": {
        "port": 3000
      }
    }
  ]
}
```

---

## 💡 方案4：Webhook集成（事件驱动）

### 4.1 配置Webhook

在OpenClaw配置中添加：
```json
{
  "webhooks": [
    {
      "name": "my-platform-webhook",
      "url": "https://your-platform.com/webhook",
      "events": ["message.received", "message.sent", "session.created"],
      "secret": "your-webhook-secret"
    }
  ]
}
```

### 4.2 接收Webhook

**你的平台服务器**：
```javascript
const express = require('express');
const crypto = require('crypto');

const app = express();
app.use(express.json());

// Webhook端点
app.post('/webhook', (req, res) => {
    const signature = req.headers['x-openclaw-signature'];
    const payload = JSON.stringify(req.body);
    
    // 验证签名
    const expectedSignature = crypto
        .createHmac('sha256', 'your-webhook-secret')
        .update(payload)
        .digest('hex');
    
    if (signature !== expectedSignature) {
        return res.status(401).json({ error: 'Invalid signature' });
    }
    
    // 处理事件
    const event = req.body;
    
    switch (event.type) {
        case 'message.sent':
            console.log('AI回复:', event.data.message);
            // 推送到前端
            broadcastToClient(event.data.user_id, event.data.message);
            break;
        
        case 'session.created':
            console.log('新会话:', event.data.session_id);
            break;
    }
    
    res.json({ success: true });
});

app.listen(4000, () => {
    console.log('✅ Webhook服务器已启动，端口: 4000');
});
```

---

## 🎯 完整示例：简单的Web应用

### 前端（HTML + JavaScript）

```html
<!DOCTYPE html>
<html>
<head>
    <title>我的AI助手</title>
    <style>
        #chat-container {
            width: 600px;
            height: 500px;
            border: 1px solid #ccc;
            overflow-y: scroll;
            padding: 10px;
            margin: 20px auto;
        }
        #message-input {
            width: 500px;
            padding: 10px;
            margin: 10px;
        }
        #send-button {
            padding: 10px 20px;
            margin: 10px;
        }
        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 8px;
        }
        .user-message {
            background-color: #e7f3ff;
            text-align: right;
        }
        .ai-message {
            background-color: #f0f0f0;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">小龙虾AI助手</h1>
    
    <div id="chat-container"></div>
    
    <div style="text-align: center;">
        <input type="text" id="message-input" placeholder="输入消息...">
        <button id="send-button">发送</button>
    </div>
    
    <script>
        const API_URL = 'http://localhost:18800/api';
        const API_KEY = 'your-api-key-here';
        let sessionId = null;
        
        // 初始化会话
        async function initSession() {
            const response = await fetch(`${API_URL}/session/create`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${API_KEY}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    user_id: 'user_123',
                    user_name: '胡大大',
                    agent_id: 'xiaolongxia'
                })
            });
            
            const data = await response.json();
            sessionId = data.session_id;
            console.log('会话已创建:', sessionId);
        }
        
        // 发送消息
        async function sendMessage(message) {
            // 显示用户消息
            displayMessage(message, 'user');
            
            // 发送到OpenClaw
            const response = await fetch(`${API_URL}/chat/send`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${API_KEY}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    session_id: sessionId,
                    message: message
                })
            });
            
            // 获取AI回复
            const data = await response.json();
            displayMessage(data.message, 'ai');
        }
        
        // 显示消息
        function displayMessage(message, type) {
            const container = document.getElementById('chat-container');
            const div = document.createElement('div');
            div.className = `message ${type}-message`;
            div.textContent = message;
            container.appendChild(div);
            container.scrollTop = container.scrollHeight;
        }
        
        // 绑定事件
        document.getElementById('send-button').addEventListener('click', () => {
            const input = document.getElementById('message-input');
            const message = input.value.trim();
            if (message) {
                sendMessage(message);
                input.value = '';
            }
        });
        
        document.getElementById('message-input').addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                document.getElementById('send-button').click();
            }
        });
        
        // 初始化
        initSession();
    </script>
</body>
</html>
```

---

## 📊 方案对比

| 方案 | 难度 | 实时性 | 适用场景 |
|------|------|--------|----------|
| HTTP API | ⭐ | ⭐⭐ | 简单应用、快速集成 |
| WebSocket | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 实时聊天、高频交互 |
| Channel插件 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 完全自定义、复杂场景 |
| Webhook | ⭐⭐ | ⭐⭐⭐ | 事件驱动、异步处理 |

---

## 🚀 快速开始

### 1. 启动OpenClaw Gateway

```bash
# 启动Gateway
openclaw gateway start

# 查看状态
openclaw gateway status
```

### 2. 获取API密钥

```bash
# 查看配置
cat ~/.openclaw/openclaw.json

# 或创建新密钥
openclaw gateway token create
```

### 3. 测试API

```bash
# 测试连接
curl -X GET http://localhost:18800/health

# 发送测试消息
curl -X POST http://localhost:18800/api/chat/send \
  -H "Authorization: Bearer your-api-key" \
  -H "Content-Type: application/json" \
  -d '{"session_id":"test","message":"你好"}'
```

---

## 🔒 安全建议

1. **使用HTTPS** - 生产环境必须使用HTTPS
2. **验证签名** - 验证Webhook签名
3. **限制频率** - 防止API滥用
4. **日志审计** - 记录所有API调用
5. **环境变量** - 不要硬编码API密钥

---

## 📚 参考资源

- **OpenClaw文档**：https://docs.openclaw.ai
- **GitHub**：https://github.com/openclaw/openclaw
- **社区**：https://discord.com/invite/clawd

---

## 💡 下一步

1. **选择方案** - 根据需求选择集成方式
2. **搭建环境** - 启动OpenClaw Gateway
3. **开发前端** - 创建你的平台UI
4. **测试集成** - 验证功能是否正常
5. **部署上线** - 部署到生产环境

---

**创建时间**：2026-03-17 22:50
**作者**：小龙虾 🦞
