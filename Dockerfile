FROM arm64v8/node:16

# 安装所需依赖
RUN apt-get update
RUN apt-get install -y ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 \
                                         libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 \
                                         libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 \
                                         libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 \
                                         libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils

WORKDIR /app
COPY package*.json ./

# 禁用 Puppeteer 默认的 Chromium 下载
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# 下载 Chromium 并解压到 puppeteer/.local-chromium
ARG CHROMIUM_URL=http://ftp.cn.debian.org/debian/pool/main/c/chromium/chromium_120.0.6099.129-1_arm64.deb
RUN wget $CHROMIUM_URL -O chromium.deb && \
    mkdir -p /app/node_modules/puppeteer/.local-chromium && \
    dpkg-deb -R chromium.deb /tmp/chromium-deb && \
    cp -R /tmp/chromium-deb/usr/lib/chromium/* /app/node_modules/puppeteer/.local-chromium && \
    rm -rf chromium.deb /tmp/chromium-deb

# 设置 Puppeteer 环境变量以使用手动安装的 Chromium
ENV PUPPETEER_EXECUTABLE_PATH /app/node_modules/puppeteer/.local-chromium/chrome

ENV BOT_TOKEN=""
ENV PROTOCOL=""
ENV HOST=""
ENV PORT=""
ENV USERNAME=""
ENV PASSWORD=""

RUN npm install

COPY . .

CMD [ "npm", "start" ]
