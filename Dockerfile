FROM ubuntu:18.04
MAINTAINER Alex Shvid <alex@shvid.com>
ARG DS_VER

RUN apt-get update && apt-get install -y locales wget xz-utils && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN echo "Download DeepSpeech" && \
    wget -O /usr/local/include/deepspeech.h -q https://raw.githubusercontent.com/mozilla/DeepSpeech/v${DS_VER}/native_client/deepspeech.h && \
    wget -q https://github.com/mozilla/DeepSpeech/releases/download/v${DS_VER}/native_client.amd64.cpu.linux.tar.xz && \
    tar -C /usr/local/lib -xf native_client.amd64.cpu.linux.tar.xz libdeepspeech.so && \
    rm native_client.amd64.cpu.linux.tar.xz

ENV LD_LIBRARY_PATH=/usr/local/lib
