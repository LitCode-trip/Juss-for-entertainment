#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Docker and Docker Compose installation on Ubuntu 20.04..."

# --- Get current user ---
CURRENT_USER=$(whoami)

# 1. Update the apt package index
echo "Updating apt package index..."
sudo apt update

# 2. Install necessary dependencies
echo "Installing necessary dependencies (ca-certificates, curl, gnupg, lsb-release)..."
sudo apt install -y ca-certificates curl gnupg lsb-release

# 3. Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
# Create the directory for the keyring if it doesn't exist and set correct permissions
sudo install -m 0755 -d /etc/apt/keyrings
# Download the GPG key and dearmor it to the keyrings directory
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# Set read permissions for the GPG key file
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 4. Set up the stable Docker repository
echo "Setting up the stable Docker repository for Ubuntu 20.04..."
# Get the Ubuntu codename (which will be 'focal' for 20.04)
UBUNTU_CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $UBUNTU_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Update apt package index again after adding Docker repo
echo "Updating apt package index after adding Docker repository..."
sudo apt update

# 6. Install Docker Engine, containerd, and Docker Compose Plugin
echo "Installing Docker Engine, containerd, Docker Buildx, and Docker Compose Plugin..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 7. Add the current user to the 'docker' group
# This allows running docker commands without sudo
echo "Adding user '$CURRENT_USER' to the 'docker' group..."
sudo usermod -aG docker "$CURRENT_USER"

echo "Docker and Docker Compose installation script finished."
echo "************************************************************************"
echo "IMPORTANT: Please log out and log back in (or restart your terminal/SSH session)"
echo "for the group changes to take effect and to run Docker commands without 'sudo'."
echo "************************************************************************"

# 8. Verify installation (optional - will run after re-login/restart for non-sudo)
echo "Attempting to verify Docker installation (may require re-login for non-sudo access)..."
docker --version || echo "Docker not immediately available without re-login. Try 'sudo docker --version'."
docker compose version # This is the modern command
sudo docker run hello-world # Test with sudo for immediate check

