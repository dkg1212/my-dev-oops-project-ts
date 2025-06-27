# --- Stage 1: Build Stage ---
# Use a full Node.js image to get all the build tools
FROM node:18 AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and install ALL dependencies (including devDependencies)
COPY package*.json ./
RUN npm install

# Copy the rest of the source code
COPY . .

# Run the build script to compile TypeScript to JavaScript
RUN npm run build


# --- Stage 2: Production Stage ---
# Start with a lightweight, clean Node.js image
FROM node:18-alpine

WORKDIR /app

# Copy package.json and install ONLY production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy the compiled code from the 'builder' stage
COPY --from=builder /app/dist ./dist

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app
CMD ["node", "dist/index.js"]