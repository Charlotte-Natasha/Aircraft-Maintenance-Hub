# ----------------------------
# 1. Build Stage
# ----------------------------
FROM node:20 AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ----------------------------
# 2. Production Stage (Nginx)
# ----------------------------
FROM nginx:1.25-alpine

# Copy compiled build from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for the container
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
