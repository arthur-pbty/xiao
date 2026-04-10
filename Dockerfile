FROM node:24-bookworm

WORKDIR /app

# System dependencies used by native modules and image/audio commands.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ffmpeg \
    git \
    graphicsmagick \
    imagemagick \
    libgif-dev \
    libjpeg62-turbo-dev \
    liblqr-1-0 \
    libpango1.0-dev \
    librsvg2-dev \
    make \
    g++ \
    python3 \
 && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force

COPY . .

# Refresh parse-domain data when available.
RUN npx --yes parse-domain-update || true

ENV NODE_ENV=production

CMD ["node", "Xiao.js"]