#!/bin/bash

# Remove the running containers with volumes
docker compose down -v

# Comment line 11 of the docker-compose.yml file
sed -i '' '/foetapp360/ s/^/#/' docker-compose.yml

# Start the containers
docker compose up -d

# Sleep for 60 seconds

sleep 65

# Stop the containers
docker compose down

# Uncomment line 11 of the docker-compose.yml file

sed -i '' '/foetapp360/ s/^#//' docker-compose.yml


# Start the containers
docker compose up -d