# 使用适用于 ARM64 的 Debian 最新稳定版作为基础镜像
FROM debian:bullseye-slim

# 更新软件源
RUN apt-get update -o Debug::Acquire::http=true && \
    apt-get upgrade -y

# 安装 curl、gnupg 和其他必要工具
RUN apt-get install -y curl gnupg ca-certificates lsb-release

# 添加 NodeSource 仓库以安装 Node.js 16
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

# 安装 Node.js 和 npm
RUN apt-get install -y nodejs

# 安装 Chromium 和其他必要的依赖
RUN apt-get install -y \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
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
