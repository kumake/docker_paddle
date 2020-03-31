FROM hub.baidubce.com/paddlepaddle/paddle:1.7.1

#MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"


#设置镜像源
#COPY ./sources.list  /etc/apt/sources.list.2

#设置中文
ENV LANG C.UTF-8

WORKDIR /root

RUN apt-get install  -y  software-properties-common \
        && add-apt-repository ppa:deadsnakes/ppa -y \
        && apt-get update \
        && apt-get install -y python3.7 vim lrzsz curl net-tools inetutils-ping \
        && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1 \
        && update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.6 2 \
        && pip install -i https://pypi.tuna.tsinghua.edu.cn/simple jupyter jupyterlab \
                # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
                && apt-get clean \
                && apt-get autoclean \
                && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
