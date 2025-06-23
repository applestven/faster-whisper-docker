FROM python:3.10-slim

# 安装依赖
RUN apt-get update && apt-get install -y \
    ffmpeg git && rm -rf /var/lib/apt/lists/*

# 安装 faster-whisper CLI
RUN pip install --no-cache-dir \
    git+https://github.com/guillaumekln/faster-whisper-cli.git

WORKDIR /app

ENTRYPOINT ["faster-whisper"]
