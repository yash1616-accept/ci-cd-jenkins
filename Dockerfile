FROM node:22-alpine

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy application source
COPY . .

# App runs on port 3000
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
