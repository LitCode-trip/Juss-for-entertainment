#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Docker and Docker Compose installation on Ubuntu 25.04..."

# 1. Update the apt package index
echo "Updating apt package index..."
sudo apt update

# 2. Install necessary dependencies
echo "Installing necessary dependencies..."
sudo apt install -y ca-certificates curl gnupg lsb-release

# 3. Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 4. Set up the stable Docker repository
echo "Setting up the stable Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Update apt package index again after adding Docker repo
echo "Updating apt package index after adding Docker repository..."
sudo apt update

# 6. Install Docker Engine, containerd, and Docker Compose (docker-ce-cli includes it)
echo "Installing Docker Engine, containerd, and Docker Compose..."
# For Ubuntu 25.04, docker-compose is typically bundled with docker-ce-cli
# If it's not, you'd install docker-compose-plugin separately.
# This command should cover it.
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 7. Add the current user to the 'docker' group
# This allows running docker commands without sudo
echo "Adding current user to the 'docker' group..."
sudo usermod -aG docker "$USER"

echo "Docker and Docker Compose installation script finished."
echo "Please log out and log back in (or restart your terminal session) for the group changes to take effect."

# 8. Verify installation (optional - will run after re-login/restart for non-sudo)
echo "Attempting to verify Docker installation (may require re-login for non-sudo access)..."
docker --version
docker compose version # Note: 'docker compose' is the new command, not 'docker-compose'
