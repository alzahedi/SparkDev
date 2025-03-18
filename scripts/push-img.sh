#!/bin/bash

# Set variables
IMAGE_NAME="sparkdev"
ACR_NAME="sparkdevcontainer"
DEVCONTAINER_DIR=".devcontainer"
ACR_REPO="$ACR_NAME.azurecr.io/$IMAGE_NAME"
HASH_FILE="$DEVCONTAINER_DIR/.devcontainer-hash.txt"
DEVCONTAINER_JSON="$DEVCONTAINER_DIR/devcontainer.json"

echo "Logging into Azure Container Registry..."
az acr login --name "$ACR_NAME"

# Read hash from file
HASH=$(cat "$HASH_FILE" | tr -d '[:space:]')

# Push the image to Azure Container Registry
echo "Pushing image to ACR..."
docker push "${ACR_REPO}:${HASH}"

echo "Image pushed successfully: ${ACR_REPO}:${HASH}"

# Update devcontainer.json with the new image tag using sed
echo "Updating $DEVCONTAINER_JSON with new image tag..."
sed -i "s|\"image\": \".*\"|\"image\": \"${ACR_REPO}:${HASH}\"|" "$DEVCONTAINER_JSON"

echo "Updated devcontainer.json:"
cat "$DEVCONTAINER_JSON"
