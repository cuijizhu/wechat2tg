# 使用适用于 ARM64 的 Node.js 最新基础镜像
FROM arm64v8/node:16

# 安装 Chromium 和其他必要的依赖
# 分开运行 apt-get update 和 apt-get install 以提高清晰度
RUN apt-get update && apt-get install -y \
    ca-certificates \
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
    lsb-release \
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

# 设置环境变量
ENV BOT_TOKEN=""
ENV PROTOCOL=""
ENV HOST=""
ENV PORT=""
ENV USERNAME=""
ENV PASSWORD=""

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 设置启动命令
CMD [ "npm", "start" ]
