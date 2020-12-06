FROM node:14-alpine as base

FROM base as builder
WORKDIR /build
COPY package*.json ./
RUN npm i
COPY . .
ENV NODE_ENV=production
RUN npm run build && npm prune --production

FROM base
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/dist ./dist
EXPOSE 4000
ENTRYPOINT ["npm", "run", "start:prod"]
