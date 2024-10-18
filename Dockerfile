FROM dockerproxy.cn/node:22-slim AS builder
ENV COREPACK_NPM_REGISTRY="https://registry.npmmirror.com"
COPY . /app
WORKDIR /app
RUN npm run build

FROM dockerproxy.cn/nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD [ "nginx", "-g", "daemon off;" ]
