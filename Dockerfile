# Stage 1: Build the Angular application
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to install dependencies
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the Angular application in production mode
RUN npm run build --prod

# Stage 2: Serve the Angular app using Nginx
FROM nginx:alpine

# Copy the built Angular app from the build stage to Nginx's default folder
COPY --from=build /app/dist/e-commers /usr/share/nginx/html

# Expose port 80 to be accessible from outside the container
EXPOSE 8080

# Start Nginx to serve the Angular app
CMD ["nginx", "-g", "daemon off;"]
