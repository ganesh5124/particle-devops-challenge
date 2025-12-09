# Use a lightweight Node.js runtime
FROM node:22-alpine

# Create a non-root user: "nodeapp"
RUN addgroup -S nodeapp && adduser -S nodeapp -G nodeapp

# Set working directory
WORKDIR /app

# Copy package files first to leverage caching
COPY package.json package-lock.json* ./

# Install only production dependencies
RUN npm install --only=production

# Copy the app code
COPY app.js .

# Change ownership to the non-root user
RUN chown -R nodeapp:nodeapp /app

# 🔑 Switch to the non-root user
USER nodeapp

# Expose port 8000 for runtime
EXPOSE 8000

# Run the app
CMD ["node", "app.js"]

