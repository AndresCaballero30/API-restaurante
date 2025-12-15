FROM node:20-alpine

# Install Python and build tools required for node-gyp
RUN apk add --no-cache python3 build-base

# Set the working directory for the application
WORKDIR /usr/src/app

# Copy package definition and install dependencies for the backend
# This is done in a separate step to leverage Docker layer caching.
COPY backend/server/package*.json ./backend/server/
RUN cd backend/server && npm install

# Copy the entire project source code into the container
COPY . .

# The backend server runs on port 3001
EXPOSE 3001

# Command to run the backend server
CMD ["node", "backend/server/server.js"]
