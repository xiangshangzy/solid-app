FROM dockerproxy.cn/node:22-slim AS builder
ENV COREPACK_NPM_REGISTRY="https://registry.npmmirror.com"
COPY . /app
WORKDIR /app
RUN npm run build

FROM dockerproxy.cn/nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
RUN echo '
   server {
    listen 3000;
    # gzip config
    gzip on;
    gzip_min_length 1k;
    gzip_comp_level 9;
    gzip_types text/plain text/css text/javascript application/json application/javascript application/x-javascript application/xml;
    gzip_vary on;
    gzip_disable "MSIE [1-6]\.";
    root /usr/share/nginx/html;
    location / {
        try_files $uri $uri/ /index.html;
    }}
    ' > /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD [ "nginx", "-g", "daemon off" ]
