#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install Apache2
echo "Installing Apache2..."
sudo apt install apache2 apache2-doc apache2-utils -y

# Check if Apache2 works
echo "Checking Apache2 status..."
sudo systemctl status apache2

# Check default page by opening it in the browser (optional, requires GUI environment)
# echo "Opening default Apache2 page..."
# xdg-open http://localhost

echo "Apache2 installation completed."