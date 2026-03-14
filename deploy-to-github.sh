#!/bin/bash
# 网页项目部署工具
# 用法: deploy-to-github.sh <项目目录> <项目名称>

PROJECT_DIR=$1
PROJECT_NAME=$2

if [ -z "$PROJECT_DIR" ] || [ -z "$PROJECT_NAME" ]; then
    echo "用法: deploy-to-github.sh <项目目录> <项目名称>"
    echo "示例: deploy-to-github.sh ~/my-web-project my-cool-app"
    exit 1
fi

# GitHub Pages仓库路径
PAGES_REPO=~/github-pages/xiaolongxia-report
PROJECT_DEST="$PAGES_REPO/projects/$PROJECT_NAME"

echo "======================================"
echo "🦞 网页项目部署工具"
echo "======================================"
echo ""
echo "项目名称: $PROJECT_NAME"
echo "源目录: $PROJECT_DIR"
echo "目标目录: $PROJECT_DEST"
echo ""

# 创建目标目录
mkdir -p "$PROJECT_DEST"

# 复制项目文件
echo "📦 复制项目文件..."
cp -r "$PROJECT_DIR"/* "$PROJECT_DEST/"

# 进入Pages仓库
cd "$PAGES_REPO"

# 添加到Git
echo "📤 添加到Git..."
git add projects/$PROJECT_NAME/

# 提交
echo "💾 提交更改..."
git commit -m "Add project: $PROJECT_NAME ($(date '+%Y-%m-%d %H:%M'))"

# 推送
echo "🚀 推送到GitHub..."
git push origin main

echo ""
echo "======================================"
echo "✅ 部署完成！"
echo "======================================"
echo ""
echo "🌐 访问地址:"
echo "https://nickyhu1699.github.io/xiaolongxia-report/projects/$PROJECT_NAME/"
echo ""
echo "🦞 小龙虾自动部署"
