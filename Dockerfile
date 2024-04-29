# First stage: node base image
FROM node:18 as node 

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Install AWS CDK
RUN npm install -g aws-cdk

# Set working directory
WORKDIR /app

# Copy CDK project files
COPY . .

# Install project dependencies (if any)
# RUN npm install

# Expose any necessary ports
EXPOSE 3000

# Run CDK commands
CMD ["cdk", "synth"]

