#!/bin/bash

# 1. 切换到 Xcode 项目所在目录（请改成你的真实路径）
cd "/Users/jz/Documents/SwiftApp/IdleStudy"

# 2. 检查是否有改动，如果有才提交
if [[ `git status --porcelain` ]]; then
    git add .
    git commit -m "Auto commit at $(date +%Y-%m-%d_%H:%M:%S)"
    git push origin main
else
    echo "No changes to commit."
fi

