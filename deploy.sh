#!/bin/bash
# 部署协作报告到GitHub Pages

echo "=========================================="
echo "🦞 小龙虾协作报告 - GitHub Pages部署"
echo "=========================================="
echo ""

# 设置Git用户信息（如果需要）
read -p "请输入你的GitHub用户名: " github_username
read -p "请输入你的GitHub邮箱: " github_email

git config user.name "$github_username"
git config user.email "$github_email"

echo ""
echo "✅ Git配置完成"
echo ""

# 显示下一步操作
echo "=========================================="
echo "📝 接下来请按以下步骤操作："
echo "=========================================="
echo ""
echo "步骤1: 在GitHub创建新仓库"
echo "  - 访问: https://github.com/new"
echo "  - 仓库名: xiaolongxia-report"
echo "  - 描述: 🦞 小龙虾×胡大大 11天人机协作之旅"
echo "  - 选择: Public"
echo "  - 不要勾选: Add a README file"
echo "  - 点击: Create repository"
echo ""
echo "步骤2: 添加远程仓库并推送"
echo "  git remote add origin https://github.com/$github_username/xiaolongxia-report.git"
echo "  git branch -M main"
echo "  git push -u origin main"
echo ""
echo "步骤3: 启用GitHub Pages"
echo "  - 访问: https://github.com/$github_username/xiaolongxia-report/settings/pages"
echo "  - Source: Deploy from a branch"
echo "  - Branch: main (root)"
echo "  - 点击: Save"
echo ""
echo "步骤4: 访问在线报告"
echo "  等待1-2分钟后访问:"
echo "  https://$github_username.github.io/xiaolongxia-report/"
echo ""
echo "=========================================="
echo "🎯 快速推送命令（复制粘贴）："
echo "=========================================="
echo ""
echo "git remote add origin https://github.com/$github_username/xiaolongxia-report.git"
echo "git branch -M main"
echo "git push -u origin main"
echo ""
