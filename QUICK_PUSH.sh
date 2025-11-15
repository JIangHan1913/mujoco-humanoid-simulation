#!/bin/bash
# 快速推送到 Gitee main 分支的脚本
# 使用方法: bash QUICK_PUSH.sh

echo "=== 开始推送到 main 分支 ==="

# 仓库配置
REPO_URL="https://gitee.com/jianghan1913/mujoco-humanoid-simulation.git"

# 0. 初始化 git 仓库（如果需要）
if [ ! -d ".git" ]; then
    echo "0. 初始化 git 仓库..."
    git init
fi

# 1. 配置 git 用户信息
echo "1. 配置 git 用户信息..."
git config --global user.name "JiangHan1913"
git config --global user.email "jh18954242606@163.com"

# 2. 配置远程仓库
echo "2. 配置远程仓库..."
if git remote get-url origin &>/dev/null; then
    git remote set-url origin $REPO_URL
    echo "   已更新远程仓库: $REPO_URL"
else
    git remote add origin $REPO_URL
    echo "   已添加远程仓库: $REPO_URL"
fi

# 3. 添加所有文件
echo "3. 添加所有文件..."
git add .

# 4. 检查并提交更改
echo "4. 检查并提交更改..."
COMMIT_MSG="feat: MuJoCo人形机器人仿真控制系统

- 添加游戏手柄校准功能（calibrate_gamepad.py）
- 实现游戏手柄实时控制机器人运动
- 支持三种模式：行走、奔跑、抗扰动测试
- 添加视角跟踪和可视化选项
- 支持多种游戏手柄（罗技、北通等）
- 添加完整的 README 文档
- 优化控制逻辑和用户体验"

# 检查是否有暂存的更改需要提交
if ! git diff --cached --quiet 2>/dev/null; then
    echo "   发现更改，正在提交..."
    if git commit -m "$COMMIT_MSG"; then
        echo "   提交成功"
    else
        echo "   提交失败"
        exit 1
    fi
else
    echo "   没有更改需要提交（工作区干净）"
fi

# 5. 确保在 main 分支
echo "5. 确保在 main 分支..."
# 检查是否有提交
HAS_COMMITS=$(git rev-parse --quiet --verify HEAD > /dev/null 2>&1 && echo "yes" || echo "no")

if [ "$HAS_COMMITS" = "yes" ]; then
    # 有提交，检查当前分支
    CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")
    if [ -z "$CURRENT_BRANCH" ]; then
        # 在 detached HEAD 状态，创建 main 分支
        git checkout -b main
        echo "   已创建并切换到 main 分支"
    elif [ "$CURRENT_BRANCH" != "main" ]; then
        # 不在 main 分支，切换到 main
        if git show-ref --verify --quiet refs/heads/main 2>/dev/null; then
            git checkout main
            echo "   已切换到 main 分支"
        else
            # main 分支不存在，重命名当前分支为 main
            git branch -M main
            echo "   已将当前分支重命名为 main"
        fi
    else
        echo "   当前已在 main 分支"
    fi
else
    # 没有提交，创建 main 分支（将在首次提交后生效）
    echo "   新仓库，将在首次提交后创建 main 分支"
    # 如果没有 main 分支，创建一个
    if ! git show-ref --verify --quiet refs/heads/main 2>/dev/null; then
        git checkout -b main 2>/dev/null || git branch main 2>/dev/null
    fi
fi

# 6. 推送到远程仓库
echo "6. 推送到远程仓库..."
echo "   正在推送 main 分支到 origin..."
if git push --progress -u origin main 2>&1; then
    echo ""
    echo "=== 推送成功！ ==="
    echo "查看仓库: $REPO_URL"
    echo "分支: main"
else
    echo ""
    echo "=== 推送失败！ ==="
    echo "可能的原因："
    echo "  1. 远程仓库尚未创建，请先在 Gitee 上创建仓库"
    echo "  2. 网络连接问题"
    echo "  3. 权限问题，请检查仓库访问权限"
    echo ""
    echo "如果是第一次推送，可能需要执行："
    echo "  git push -u origin main --force"
    exit 1
fi
