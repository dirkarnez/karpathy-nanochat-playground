#!/bin/bash

echo "User: $(whoami) UID: $(id -u) GID: $(id -g)"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" # linux, double confirmed

curl -LsSf https://astral.sh/uv/install.sh | sh

source $HOME/.local/bin/env

uv --version

# git clone --depth=1 https://github.com/karpathy/nanochat.git && \

cd nanochat && \
uv sync --extra cpu && \
source .venv/bin/activate && \
bash ./runs/speedrun.sh && \
python -m scripts.chat_cli
