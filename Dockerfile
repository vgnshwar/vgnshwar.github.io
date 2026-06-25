FROM alpine:latest

# Install bash, curl, git, and hugo
RUN apk add --no-cache \
    bash \
    curl \
    git \
    hugo

WORKDIR /site

# Copy the project files
COPY . /site/

# Expose the default Hugo port
EXPOSE 1313

# Run the Hugo server
CMD ["hugo", "server", "--bind", "0.0.0.0"]
