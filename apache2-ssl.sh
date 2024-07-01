#!/bin/bash

# Update the package list and install Certbot and the Apache plugin
echo "Installing Certbot and the Apache plugin..."
sudo apt update
sudo apt install certbot python3-certbot-apache -y

# Prompt user for website domain name
read -p "Enter the domain name for SSL configuration (e.g., example.com): " domain_name

# Configure SSL for the website
echo "Configuring SSL for $domain_name..."
sudo certbot --apache -d $domain_name

echo "SSL configuration for $domain_name completed."
