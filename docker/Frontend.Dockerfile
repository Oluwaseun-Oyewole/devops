FROM node:20-bullseye AS build

WORKDIR /app

COPY package*.json ./

RUN --mount=type=cache,target=/usr/src/app/.npm \
  npm set cache /usr/src/app/.npm && \
  npm ci

COPY --chown=node:node ./src .

RUN npm run build

CMD ["npm", "run", "dev"]