#!/bin/bash

echo "User: $(whoami) UID: $(id -u) GID: $(id -g)"


case "$(uname -s)" in
Linux*)
    # echo "Running on Linux"

    # export ARMGCC_DIR="/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi"
    # export ARMGCC_GCC="$ARMGCC_DIR/bin/arm-none-eabi-gcc"

    # if [ ! -f "$ARMGCC_GCC" ]; then
    #     echo "$ARMGCC_GCC not found. Downloading now..."

    #     # /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc --version
    #     # arm-none-eabi-gcc (Arm GNU Toolchain 14.2.Rel1 (Build arm-14.52)) 14.2.1 20241119
    #     cd /opt; \
    #     wget https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/14.2.rel1/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
    #     tar -xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
    #     cd arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi && \
    #     ls -R
    
    # else
    #     echo "$ARMGCC_GCC already exists. Skipping download."
    # fi

    curl -LsSf https://astral.sh/uv/install.sh | sh
    source $HOME/.local/bin/env

    ;;
  MSYS_*|MINGW*)
    echo "Running on Windows (MSYS/MSYS2)"
    
    # https://releases.astral.sh/github/uv/releases/download/0.13.1/uv-x86_64-pc-windows-msvc.zip
    export PATH="$PATH:$(cygpath -u $USERPROFILE)/Downloads/uv-x86_64-pc-windows-msvc"

    export PATH="$PATH:$(cygpath -u $USERPROFILE)/Downloads/PortableGit/bin"
    export PATH="$PATH:/D/Softwares/PortableGit/bin"

    export PATH="$PATH:/D/Softwares/cmake-3.29.3-windows-x86_64/bin"  
    export PATH="$PATH:$(cygpath -u $USERPROFILE)/Downloads/cmake-3.29.3-windows-x86_64/cmake-3.29.3-windows-x86_64/bin"

    # https://github.com/dirkarnez/python-portable/releases/download/v3.13.9/python-3.13.9-amd64-portable.zip
    export PYTHON_DIR="$(cygpath -u $USERPROFILE)/Downloads/python-3.13.9-amd64-portable"
    export PATH="$PATH:$PYTHON_DIR:$PYTHON_DIR/Scripts"
    export PATH="$PATH:$(cygpath -u $SYSTEMDRIVE)/Program Files/7-Zip:$(cygpath -u $SYSTEMDRIVE)/Program Files (x86)/7-Zip"

    # if [ ! -f "$ARMGCC_GCC" ]; then
    #     echo "$ARMGCC_GCC not found. Downloading now..."

    #     cd "$(cygpath -u $USERPROFILE)/Downloads"; \
    #         cd https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/14.2.rel1/arm-gnu-toolchain-14.2.rel1-mingw-w64-x86_64-arm-none-eabi.zip
    #         tar -xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && \
    #         cd arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi && \
    #         ls -R

    # else
    #     echo "$ARMGCC_GCC already exists. Skipping download."
    # fi
    ;;
  *)
    echo "Running on a unsupported OS"
    ;;
esac

uv --version

git clone --depth=1 https://github.com/karpathy/nanochat.git

# export USE_LIBUV=0
# source .venv/Scripts/activate && \

cd nanochat && \
uv sync --extra cpu && \
source .venv/bin/activate && \
bash ./runs/speedrun.sh && \
python -m scripts.chat_cli
