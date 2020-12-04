FROM node:14-alpine
WORKDIR /app
COPY package*.json ./
RUN npm i && npm cache clean --force
COPY . .
RUN npm run build
ENTRYPOINT ["npm", "run", "start:prod"]
