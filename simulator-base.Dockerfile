FROM cr.yandex/mirror/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV PATH="${PATH}:/opt/KasperskyOS-Community-Edition-1.2.0.45/toolchain/bin:/home/user/.local/bin"
RUN apt-get update && \
    apt install -y \
        net-tools \
        python3 \
        python3-dev \
        python3-pip \
        python3-serial \
        python3-opencv \
        python3-wxgtk4.0 \
        python3-matplotlib \
        python3-lxml \
        python3-pygame \
        sudo \
        mc \
        vim \
        curl \
        tar \
        expect \
        build-essential \
        device-tree-compiler \
        parted \
        fdisk \
        dosfstools \
        && adduser --disabled-password --gecos "" user \
        && echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY ./KasperskyOS-Community-Edition-1.2.0.45.zip /tmp

RUN unzip /tmp/KasperskyOS-Community-Edition-1.2.0.45 -d /opt \
    && rm /tmp/*.zip \
    && ln -s /opt/KasperskyOS-Community-Edition-1.2.0.45 /opt/KasperskyOS-Local-Edition \
    && echo '/opt/KasperskyOS-Community-Edition-1.2.0.45/toolchain/lib' >> /etc/ld.so.conf.d/KasperskyOS.conf \
    && echo '/opt/KasperskyOS-Community-Edition-1.2.0.45/toolchain/x86_64-pc-linux-gnu/aarch64-kos/lib/' >> /etc/ld.so.conf.d/KasperskyOS.conf \
    && ldconfig

RUN su -c 'pip3 install PyYAML mavproxy pymavlink --user --upgrade' user



CMD ["bash"]
