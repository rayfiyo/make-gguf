FROM debian:12-slim

ARG REPO=${REPO}
ARG MODEL=${MODEL}
ARG CONVERT=${CONVERT}

RUN apt update -y &&\
    apt upgrade &&\
    apt install -y git git-lfs python3 make pip python3.11-venv &&\
    git clone https://github.com/ggerganov/llama.cpp.git &&\
    cd llama.cpp &&\
    make &&\
    mkdir /models &&\
    cd /models &&\
    git lfs install &&\
    git clone ${REPO} &&\
    cd / &&\
    python3 -m venv venv &&\
    . /venv/bin/activate &&\
    python3 -m pip install numpy && \
    python3 -m pip install -r /llama.cpp/requirements.txt && \
    python3 /llama.cpp/${CONVERT} /models/${MODEL}/ --outtype f16 --outfile /models/${MODEL}-f16.gguf
