FROM node:22-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# 用占位符来构建前端
RUN VITE_GRAPHQL_URI="__VITE_GRAPHQL_URI_PLACEHOLDER" \
    VITE_SERVER_URI="__VITE_SERVER_URI_PLACEHOLDER" \
    npm run build -- --mode production

# 生产环境
FROM nginx:alpine AS production-stage
# 复制自定义 Nginx 配置，确保监听 80 端口
COPY nginx-custom.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
EXPOSE 80