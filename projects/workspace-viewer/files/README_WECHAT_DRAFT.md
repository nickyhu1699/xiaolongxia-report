# 微信公众号草稿自动推送工具

自动将文章推送到微信公众号草稿箱的 Python 脚本。

## 📦 安装依赖

```bash
pip install wechatpy markdown
```

## ⚙️ 配置

### 1. 获取 AppID 和 AppSecret

1. 登录微信公众号平台：https://mp.weixin.qq.com
2. 进入"开发" → "基本配置"
3. 复制 AppID 和 AppSecret

### 2. 配置 IP 白名单

1. 在"基本配置"页面，找到"IP白名单"
2. 添加你的服务器 IP 地址
3. 如果是本地测试，添加本机外网 IP

### 3. 编辑配置文件

编辑 `config.json`：

```json
{
  "app_id": "你的AppID",
  "app_secret": "你的AppSecret",
  "default_author": "作者名"
}
```

## 🚀 使用方法

### 方法1：从文件创建草稿

```bash
# 准备文章文件（article.md）
python wechat_draft_pusher.py
```

### 方法2：自定义使用

```python
from wechat_draft_pusher import WeChatDraftPusher

# 初始化
pusher = WeChatDraft_pusher('config.json')

# 从 Markdown 文件创建
media_id = pusher.create_draft_from_file(
    file_path='article.md',
    title='文章标题',
    author='作者名',
    digest='文章摘要',
    cover_image='cover.jpg'
)

# 或直接创建
media_id = pusher.create_draft(
    title='文章标题',
    content='# Markdown 内容',
    author='作者名',
    digest='文章摘要',
    cover_image='cover.jpg'
)

print(f'草稿ID: {media_id}')
```

## 📝 支持的功能

### ✅ 已实现

- ✅ 上传图片到微信服务器
- ✅ Markdown 转 HTML
- ✅ 创建图文消息草稿
- ✅ 从文件创建草稿
- ✅ 获取草稿列表
- ✅ 获取草稿总数
- ✅ 删除草稿

### 🔄 待实现

- 🔄 批量上传草稿
- 🔄 自动发布草稿
- 🔄 定时发布
- 🔄 图片自动压缩
- 🔄 富文本编辑器

## 📋 API 说明

### WeChatDraftPusher 类

#### `__init__(config_file='config.json')`

初始化推送工具。

**参数：**
- `config_file`: 配置文件路径

---

#### `upload_image(image_path)`

上传图片到微信服务器。

**参数：**
- `image_path`: 图片路径

**返回：**
- `media_id`: 图片的 media_id

**示例：**
```python
media_id = pusher.upload_image('cover.jpg')
```

---

#### `create_draft(title, content, author=None, digest=None, cover_image=None, content_source_url=None)`

创建草稿。

**参数：**
- `title`: 文章标题（必填）
- `content`: 文章内容，支持 Markdown 和 HTML（必填）
- `author`: 作者名（可选）
- `digest`: 摘要（可选）
- `cover_image`: 封面图路径或 media_id（可选）
- `content_source_url`: 原文链接（可选）

**返回：**
- `media_id`: 草稿的 media_id

**示例：**
```python
media_id = pusher.create_draft(
    title='文章标题',
    content='# Markdown 内容',
    author='作者名',
    digest='文章摘要',
    cover_image='cover.jpg'
)
```

---

#### `create_draft_from_file(file_path, title=None, author=None, digest=None, cover_image=None)`

从文件创建草稿。

**参数：**
- `file_path`: 文章文件路径（支持 .md 和 .html）
- `title`: 标题（如果为 None，从文件名提取）
- `author`: 作者
- `digest`: 摘要
- `cover_image`: 封面图

**返回：**
- `media_id`: 草稿的 media_id

**示例：**
```python
media_id = pusher.create_draft_from_file(
    file_path='article.md',
    title='文章标题',
    author='作者名',
    cover_image='cover.jpg'
)
```

---

#### `get_draft_list(offset=0, count=10)`

获取草稿列表。

**参数：**
- `offset`: 偏移量
- `count`: 数量

**返回：**
- `dict`: 草稿列表

**示例：**
```python
result = pusher.get_draft_list(offset=0, count=10)
print(result['item'])
```

---

#### `get_draft_count()`

获取草稿总数。

**返回：**
- `int`: 草稿总数

**示例：**
```python
total = pusher.get_draft_count()
print(f'草稿总数: {total}')
```

---

#### `delete_draft(media_id)`

删除草稿。

**参数：**
- `media_id`: 草稿ID

**返回：**
- `bool`: 是否成功

**示例：**
```python
success = pusher.delete_draft('media_id')
```

## 🎯 使用场景

### 场景1：批量上传草稿

```python
import os
from wechat_draft_pusher import WeChatDraftPusher

pusher = WeChatDraftPusher()

# 批量上传
articles_dir = 'articles'
for filename in os.listdir(articles_dir):
    if filename.endswith('.md'):
        filepath = os.path.join(articles_dir, filename)
        pusher.create_draft_from_file(filepath)
        print(f'✅ 已上传: {filename}')
```

### 场景2：定时发布

```python
import schedule
import time
from wechat_draft_pusher import WeChatDraftPusher

def publish_article():
    pusher = WeChatDraftPusher()
    media_id = pusher.create_draft_from_file('today_article.md')
    # TODO: 调用发布 API
    print(f'✅ 草稿已创建: {media_id}')

# 每天 9:00 发布
schedule.every().day.at("09:00").do(publish_article)

while True:
    schedule.run_pending()
    time.sleep(60)
```

### 场景3：配合 AI 生成内容

```python
from wechat_draft_pusher import WeChatDraftPusher
import openai

# AI 生成文章
response = openai.ChatCompletion.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "写一篇关于AI的文章"}]
)
content = response.choices[0].message.content

# 推送到草稿箱
pusher = WeChatDraftPusher()
media_id = pusher.create_draft(
    title='AI 时代的思考',
    content=content,
    author='AI 助手'
)
```

## ⚠️ 注意事项

1. **IP 白名单**：必须配置 IP 白名单，否则会报错
2. **Access Token**：wechatpy 会自动管理 token，无需手动处理
3. **图片限制**：
   - 格式：支持 JPG、PNG
   - 大小：≤ 2MB
   - 建议尺寸：900×500 像素（16:9）
4. **内容限制**：
   - 标题：≤ 30 字
   - 摘要：≤ 120 字
   - 正文：无限制（建议 1500-3000 字）

## 🔧 故障排查

### 错误1：`40001: invalid credential`

**原因**：AppID 或 AppSecret 错误

**解决**：检查 config.json 中的配置

---

### 错误2：`40164: invalid ip`

**原因**：IP 不在白名单中

**解决**：在公众号后台添加服务器 IP 到白名单

---

### 错误3：`45009: reach max api daily quota limit`

**原因**：API 调用次数超限

**解决**：等待次日重置，或申请提高配额

---

### 错误4：图片上传失败

**原因**：图片格式或大小不符合要求

**解决**：
- 检查图片格式（JPG、PNG）
- 压缩图片至 2MB 以内
- 使用 900×500 像素

## 📚 参考资料

- [wechatpy 官方文档](https://wechatpy.org/)
- [微信公众号开发文档](https://developers.weixin.qq.com/doc/offiaccount/Getting_Started/Overview.html)
- [草稿箱管理 API](https://developers.weixin.qq.com/doc/offiaccount/Draft_Box/Add_draft.html)

## 📝 更新日志

**v1.0.0 (2026-03-12)**
- ✅ 初始版本
- ✅ 支持创建草稿
- ✅ 支持上传图片
- ✅ 支持 Markdown 转 HTML
- ✅ 支持从文件创建草稿

---

**作者**：OpenClaw AI Assistant 🦞  
**日期**：2026-03-12  
**许可证**：MIT
