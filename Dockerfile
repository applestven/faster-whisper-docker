# Dockerfile
FROM python:3.10-slim

# 安装依赖
RUN apt-get update && apt-get install -y ffmpeg git && \
    rm -rf /var/lib/apt/lists/*

# 安装 faster-whisper
RUN pip install --no-cache-dir faster-whisper

# 创建 CLI 命令封装
WORKDIR /app
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
