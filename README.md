

# 🎧 faster-whisper-docker

一个基于 [faster-whisper](https://github.com/guillaumekln/faster-whisper) 的 Docker 封装工具，让你像使用 whisper 一样，在任意系统上快速使用 CLI 命令进行语音转写。

---

## 🚀 快速开始

```bash
git clone https://github.com/yourname/faster-whisper-docker
cd faster-whisper-docker
docker build -t whisper-fast .
./install.sh

## 🛠️ 使用方法

``` bash
faster-whisper your-audio.m4a --model-size small --language zh --compute-type int8
```


## 🧠 支持参数

| 参数                | 示例                          | 说明            |
| ----------------- | --------------------------- | ------------- |
| `--model-size`    | `tiny` / `small` / `medium` | 选择模型精度与速度     |
| `--language`      | `zh` / `en` / ...           | 语言代码（可省略自动识别） |
| `--compute-type`  | `int8` / `float32`          | 精度类型（int8 更快） |
| `--output-dir`    | `--output-dir /data/out`    | 输出文件夹         |
| `--output-format` | `srt` / `txt` / `vtt`       | 输出格式          |

## 💾 模型缓存说明
首次使用某模型会下载，缓存保存在：

~/.cache/faster-whisper



## 代码创建

``` bash
mkdir -p faster-whisper-docker && cd faster-whisper-docker

# 创建 Dockerfile
cat > Dockerfile << 'EOF'
FROM python:3.10-slim

# 安装依赖
RUN apt-get update && apt-get install -y \
    ffmpeg git && rm -rf /var/lib/apt/lists/*

# 安装 faster-whisper CLI
RUN pip install --no-cache-dir \
    git+https://github.com/guillaumekln/faster-whisper-cli.git

WORKDIR /app

ENTRYPOINT ["faster-whisper"]
EOF

# 创建安装脚本 install.sh
cat > install.sh << 'EOF'
#!/bin/bash
echo "🔧 安装 faster-whisper 命令到 /usr/local/bin/faster-whisper"

sudo tee /usr/local/bin/faster-whisper > /dev/null << 'EOL'
#!/bin/bash
ARGS=()
for arg in "\$@"; do
  if [[ -f "\$arg" ]]; then
    FILE=\$(basename "\$arg")
    ARGS+=("/data/\$FILE")
  else
    ARGS+=("\$arg")
  fi
done

docker run --rm \
  -v "\$PWD:/data" \
  -v "\$HOME/.cache/faster-whisper:/root/.cache" \
  whisper-fast \
  "\${ARGS[@]}"
EOL

sudo chmod +x /usr/local/bin/faster-whisper
echo "✅ 安装完成！现在你可以直接使用 faster-whisper 命令啦"
EOF

chmod +x install.sh


```