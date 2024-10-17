FROM dockerproxy.cn/node:20-slim AS base
RUN npm config set registry https://registry.npmmirror.com/
RUN npm i -g pnpm

#Build stage on top of 'base'
FROM base AS dependencies
WORKDIR /app
# Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./
# Install dependencies
RUN pnpm install

# Create a build stage based on the 'base' stage
FROM base AS build
WORKDIR /app
# Copy code
COPY . .
# Copy dependencies stage
COPY --from=dependencies /app/node_modules ./node_modules
# Build the application using pnpm
RUN pnpm build
# Prune development dependencies
RUN pnpm prune --prod

# Deployment stage from the base
FROM base AS deploy
WORKDIR /app
# Copy the built application
COPY --from=build /app/dist/ ./dist/
# Copy the production dependencies
COPY --from=build /app/node_modules ./node_modules
# Run the application
# CMD [ "node", "dist/main.js" ]
CMD [ "sleep", "1d" ]