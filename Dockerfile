# 使用适用于 ARM64 的 CentOS 最新稳定版作为基础镜像
FROM centos:centos8

# 更新软件源
RUN yum update -y && yum clean all

# 安装 EPEL 仓库
RUN yum install -y epel-release

# 安装 curl、gnupg 和其他必要工具
RUN yum install -y curl gpg ca-certificates redhat-lsb-core

# 添加 NodeSource 仓库以安装 Node.js 16
RUN curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -

# 安装 Node.js 和 npm
RUN yum install -y nodejs

# 安装 Chromium 和其他必要的依赖
RUN yum install -y \
    liberation-fonts \
    alsa-lib \
    atk \
    at-spi2-atk \
    glibc \
    cairo \
    cups-libs \
    dbus-libs \
    expat \
    fontconfig \
    gbm \
    gcc \
    glib2 \
    gtk3 \
    nspr \
    nss \
    pango \
    pangox-compat \
    stdc++ \
    libX11 \
    libxcb \
    libXcomposite \
    libXcursor \
    libXdamage \
    libXext \
    libXfixes \
    libXi \
    libXrandr \
    libXrender \
    libXScrnSaver \
    libXtst \
    wget \
    xdg-utils \
    chromium

# 设置 Puppeteer 环境变量以使用系统中的 Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium

# 创建应用目录
RUN mkdir -p /app/config
WORKDIR /app

# 复制 package.json 和 package-lock.json（如果存在）
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 设置启动命令
CMD [ "npm", "start" ]
