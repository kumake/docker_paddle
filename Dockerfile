FROM hub.baidubce.com/paddlepaddle/paddle:1.7.1

#MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"


#设置镜像源
#COPY ./sources.list  /etc/apt/sources.list.2

#设置中文
ENV LANG C.UTF-8

WORKDIR /root

RUN apt-get update \
        && apt-get install -y  vim lrzsz curl net-tools inetutils-ping \
        #设置python3 pip3默认为3.7版本
        && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1 \
        && update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.6 2 \
        && update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 3 \
        && mv /usr/bin/pip3 /usr/bin/pip3.5 \
        && update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.5 1 \
        && update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3.6 2 \
        && update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3.7 3 \
        # jupyter支持python3
        && python2 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple ipykernel \
        && python2 -m ipykernel install --user \
        && python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple ipykernel \
        && python3 -m ipykernel install --user \
        #安装jupyterlab
        && pip install -i https://pypi.tuna.tsinghua.edu.cn/simple jupyterlab \
                # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
                && apt-get clean \
                && apt-get autoclean \
                && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
