# Use the official PostgreSQL image
FROM postgres:latest

# Copy the initialization script into the container
COPY words.sql /docker-entrypoint-initdb.d/

# Set environment variable to allow all connections (for simplicity)
ENV POSTGRES_HOST_AUTH_METHOD trust

# Expose PostgreSQL port
EXPOSE 5432
