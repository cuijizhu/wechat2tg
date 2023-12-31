FROM arm64v8/node:16

# 安装所需依赖
RUN apt-get update && apt-get install -y \
    ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 \
    libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 \
    libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 \
    libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 \
    libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 \
    libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release \
    wget xdg-utils chromium && \
    rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium
ENV BOT_TOKEN=""
ENV PROTOCOL=""
ENV HOST=""
ENV PORT=""
ENV USERNAME=""
ENV PASSWORD=""

WORKDIR /app
COPY package*.json ./

# 安装其他 npm 依赖
RUN npm install

# 非root用户运行
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

COPY . .

CMD [ "npm", "start" ]
