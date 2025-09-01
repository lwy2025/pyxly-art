
# 确保脚本在出错时立即退出
set -e

# 询问用户是否要在本地预览
echo "是否要在本地预览更改？(y/n)"
read preview_answer

if [ "$preview_answer" = "y" ] || [ "$preview_answer" = "Y" ]; then
  echo "\n启动本地Hugo服务器..."
  echo "请在浏览器中访问 http://localhost:1313 查看效果"
  echo "按 Ctrl+C 停止预览并继续部署流程"
  hugo server -D
  
  echo "\n预览已停止，继续部署流程..."
fi

# 提示用户输入提交信息
echo "\n请输入提交信息:"
read commit_message

# 如果用户没有输入提交信息，使用默认信息
if [ -z "$commit_message" ]; then
  commit_message="更新博客内容"
fi

# 显示当前状态
echo "\n检查当前git状态..."
git status

echo "\n开始添加所有更改的文件..."
git add .

# 提交更改
echo "\n提交更改..."
git commit -m "$commit_message"

# 拉取远程更改（防止冲突）
echo "\n拉取远程main分支的最新更改..."
git pull origin main

# 推送到GitHub
echo "\n推送到GitHub..."
git push origin main

# 完成提示
echo "\n✅ 推送成功！GitHub Actions 正在自动部署你的博客。"
echo "\n📋 你可以在以下位置查看部署状态："
echo "   https://github.com/lwy2025/pyxly-art/actions"
echo "\n⏱️  部署通常需要1-2分钟完成。"
echo "🌐  完成后可以访问你的博客："
echo "   https://lwy2025.github.io/pyxly-art/"