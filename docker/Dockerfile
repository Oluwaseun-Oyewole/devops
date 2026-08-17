FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV production

COPY package*.json ./
# Use cache mount to speed up install of existing dependencies
RUN --mount=type=cache,target=/usr/src/app/.npm \
  npm set cache /usr/src/app/.npm && \
  npm ci --only=production

USER node
COPY --chown=node:node ./src .

EXPOSE 3000

CMD ["node", "dist/index.js"]