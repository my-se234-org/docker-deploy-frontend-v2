#!/bin/sh
set -e

# 这里设置默认值，方便你测试；正式使用时会被 docker-compose.yml 的环境变量覆盖
VITE_GRAPHQL_URI="${VITE_GRAPHQL_URI:-http://207.90.237.51:8082/graphql}"
VITE_SERVER_URI="${VITE_SERVER_URI:-http://207.90.237.51:8082}"

# 在所有 .js 文件中查找并替换占位符
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_GRAPHQL_URI_PLACEHOLDER|${VITE_GRAPHQL_URI}|g" {} \;
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_SERVER_URI_PLACEHOLDER|${VITE_SERVER_URI}|g" {} \;

# 启动 nginx
nginx -g 'daemon off;'