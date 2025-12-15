# 1. Build Stage
FROM node:20 AS builder

WORKDIR /app

# Create non-root user
RUN useradd -m natasha

# Copy dependency files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

#Give natasha ownership of the app folder
RUN chown -R natasha:natasha /app

# Switch to non-root user
USER natasha

# Build the application
RUN npm run build

# 2. Production Stage (Nginx)
FROM nginx:1.25-alpine

# Copy compiled build from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for the container
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
