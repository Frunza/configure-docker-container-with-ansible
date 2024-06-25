FROM alpine:3.18.0

# Install OpenSSH
RUN apk add --no-cache openssh

# Define the environment variable
ARG SSH_PRIVATE_KEY
# Create the .ssh directory if it doesn't exist
RUN mkdir -p /root/.ssh
# Write the private key content to id_rsa file
RUN echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

# Install ansible
RUN apk --no-cache add ansible=7.5.0-r0

# Copy scripts to the expected location
COPY ./scripts /app
# Copy ansible files to the expected location
COPY ./ansible /app/ansible

CMD ["sh"]
