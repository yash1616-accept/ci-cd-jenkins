# --- Stage 1: Build & Dependencies ---
FROM node:22-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files first to leverage Docker cache
COPY package*.json ./

# Install ALL dependencies (including devDependencies for testing/building)
RUN npm ci

# Copy the rest of your app code
COPY . .

# Run your tests - if they fail, the build fails!
RUN npm test

# --- Stage 2: Final Production Image ---
FROM node:22-alpine AS production

WORKDIR /app

# Set environment to production
ENV NODE_ENV=production

# Copy only the necessary production dependencies from builder stage
COPY --from=builder /app/package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy the application source code from the builder stage
COPY --from=builder /app .

# Security: Run as a non-root user (provided by node-alpine image)
USER node

# Document the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]