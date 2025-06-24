#!/bin/bash
set -e

# 简易的 CLI 接口封装，支持文件路径参数
ARGS=()
for arg in "$@"; do
  if [[ -f "$arg" ]]; then
    FILE=$(basename "$arg")
    ARGS+=("/data/$FILE")
  else
    ARGS+=("$arg")
  fi
done

python3 -m faster_whisper "${ARGS[@]}"
