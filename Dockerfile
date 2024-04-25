FROM node:18

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

