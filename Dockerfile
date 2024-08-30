FROM debian:12-slim
RUN	apt update -y &&\
    apt upgrade &&\
    apt install -y git python3 make pip &&\
    git clone https://github.com/ggerganov/llama.cpp.git &&\
    cd llama.cpp &&\
    make &&\
    mkdir /models &&\
    cd /models &&\
    git lfs install &&\
    git clone https://huggingface.co/tokyotech-llm/Llama-3-Swallow-70B-v0.1 &&\
    cd / &&\
    python3 -m venv venv &&\
    source venv/bin/activate &&\
    python -m pip install -r /llama.cpp/requirements.txt &&\
    python /llama.cpp/convert_hf_to_gguf.py /models/Llama-3-Swallow-8B-Instruct-v0.1/ --outtype f16 --outfile /models/Llama-3-Swallow-8B-Instruct-v0.1-f16.gguf
