# First stage: node base image
FROM node:18 as node 

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Install AWS CDK
RUN npm install -g aws-cdk

# mkdir for aws credentials
RUN mkdir /root/.aws

# Set working directory
WORKDIR /app

# Copy aws credentials from dev login to container
# or copy them into the container once it is running

#COPY ./credentials /root/.aws/credentials
#COPY ./config  /root/.aws/config

# Install project dependencies (if any)
# RUN npm install

# Expose any necessary ports
EXPOSE 3000

# Run CDK commands
CMD ["cdk", "synth"]
