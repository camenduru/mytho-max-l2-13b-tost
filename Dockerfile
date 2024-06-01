FROM nvidia/cuda:12.4.0-devel-ubuntu22.04
WORKDIR /content
ENV PATH="/home/camenduru/.local/bin:${PATH}"
RUN adduser --disabled-password --gecos '' camenduru && \
    adduser camenduru sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R camenduru:camenduru /content && \
    chmod -R 777 /content && \
    chown -R camenduru:camenduru /home && \
    chmod -R 777 /home

RUN apt update -y && apt install software-properties-common -y && add-apt-repository -y ppa:git-core/ppa && apt update -y && apt install -y aria2 git git-lfs unzip ffmpeg python3-pip python-is-python3

USER camenduru

RUN pip install -q opencv-python imageio imageio-ffmpeg ffmpeg-python av runpod \
    torch==2.3.0+cu121 torchvision==0.18.0+cu121 torchaudio==2.3.0+cu121 torchtext==0.18.0 torchdata==0.7.1 --extra-index-url https://download.pytorch.org/whl/cu121 \
    xformers==0.0.26.post1 \
    https://github.com/camenduru/wheels/releases/download/runpod/vllm-0.4.3-cp310-cp310-linux_x86_64.whl

RUN aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/raw/main/added_tokens.json -d /content/model -o added_tokens.json && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/raw/main/config.json -d /content/model -o config.json && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/raw/main/generation_config.json -d /content/model -o generation_config.json && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00001-of-00013.bin -d /content/model -o pytorch_model-00001-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00002-of-00013.bin -d /content/model -o pytorch_model-00002-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00003-of-00013.bin -d /content/model -o pytorch_model-00003-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00004-of-00013.bin -d /content/model -o pytorch_model-00004-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00005-of-00013.bin -d /content/model -o pytorch_model-00005-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00006-of-00013.bin -d /content/model -o pytorch_model-00006-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00007-of-00013.bin -d /content/model -o pytorch_model-00007-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00008-of-00013.bin -d /content/model -o pytorch_model-00008-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00009-of-00013.bin -d /content/model -o pytorch_model-00009-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00010-of-00013.bin -d /content/model -o pytorch_model-00010-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00011-of-00013.bin -d /content/model -o pytorch_model-00011-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00012-of-00013.bin -d /content/model -o pytorch_model-00012-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/pytorch_model-00013-of-00013.bin -d /content/model -o pytorch_model-00013-of-00013.bin && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/raw/main/pytorch_model.bin.index.json -d /content/model -o pytorch_model.bin.index.json && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/raw/main/special_tokens_map.json -d /content/model -o special_tokens_map.json && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/resolve/main/tokenizer.model -d /content/model -o tokenizer.model && \
	aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/camenduru/MythoMax-L2-13b/raw/main/tokenizer_config.json -d /content/model -o tokenizer_config.json

COPY ./worker_runpod.py /content/Meta-Llama-3-8B-Instruct/worker_runpod.py
WORKDIR /content/Meta-Llama-3-8B-Instruct
CMD python worker_runpod.py
