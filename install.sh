#!/bin/bash
echo "🔧 安装 faster-whisper 命令到 /usr/local/bin/faster-whisper"

sudo tee /usr/local/bin/faster-whisper > /dev/null << 'EOL'
#!/bin/bash
ARGS=()
for arg in "$@"; do
  if [[ -f "$arg" ]]; then
    FILE=$(basename "$arg")
    ARGS+=("/data/$FILE")
  else
    ARGS+=("$arg")
  fi
done

docker run --rm \
  -v "$PWD:/data" \
  -v "$HOME/.cache/faster-whisper:/root/.cache" \
  whisper-fast \
  "${ARGS[@]}"
EOL

sudo chmod +x /usr/local/bin/faster-whisper
echo "✅ 安装完成！现在你可以直接使用 faster-whisper 命令啦"
