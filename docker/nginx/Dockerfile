FROM nginx:1.22.1

# Install extras to support sub_filter
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apache2-utils \
        dos2unix \
        nginx-extras \
        bash && \
    rm -rf /var/lib/apt/lists/*

# Copy custom NGINX configuration
COPY ./configs/nginx/nginx.conf /etc/nginx/nginx.conf

# Copy auth script
COPY ./commands/set_nginx_basic_auth.sh /commands/set_nginx_basic_auth.sh

# Fix line endings and set permissions
RUN dos2unix /commands/*.sh && chmod +x /commands/*.sh

# Run script before nginx starts
ENTRYPOINT ["/commands/set_nginx_basic_auth.sh"]

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
