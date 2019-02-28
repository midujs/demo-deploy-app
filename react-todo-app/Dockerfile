# syntax = docker/dockerfile:experimental
# ===== Builder =====
# ===================
FROM hoanganh25991/node:10-build-tools AS builder
WORKDIR /builder/

# Install
ADD package.json ./
ADD yarn.lock ./
RUN yarn install

# Build
ADD . .

# ===== Runner =====
# ==================
FROM nginx:alpine AS runner
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=0 /builder/build/ /usr/share/nginx/html/

# Start
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]