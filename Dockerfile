FROM node:20-alpine

# Set production environment
ENV NODE_ENV=production

# Create app directory
WORKDIR /usr/src/app

# Install build dependencies for better-sqlite3
RUN apk add --no-cache python3 make g++ 

# Install app dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Bundle app source
COPY . .

# Ensure the data directory exists and is writable
RUN mkdir -p data && chown -R node:node /usr/src/app

# Use the non-root node user for security
USER node

# Default command
CMD ["npm", "start"]
