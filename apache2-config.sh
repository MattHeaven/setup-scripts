#!/bin/bash

# Disable the default site
echo "Disabling the default site..."
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

# Firewall configuration
echo "Configuring the firewall..."
sudo ufw app list
sudo ufw allow 'Apache Full'
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status

# Create website directories and sample index.html
read -p "Enter the website name: " website_name
echo "Creating website directories for $website_name..."

sudo mkdir -p /var/www/html/$website_name/{public_html,logs,backups}
sudo touch /var/www/html/$website_name/public_html/index.html

# Add sample code to the webpage
echo "<!DOCTYPE html>
<html>
<head>
    <title>Welcome to $website_name</title>
</head>
<body>
    <h1>Success! The $website_name server block is working!</h1>
</body>
</html>" | sudo tee /var/www/html/$website_name/public_html/index.html

# Create the site configuration file
echo "Creating the site configuration for $website_name..."
sudo touch /etc/apache2/sites-available/$website_name.conf

echo "<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName $website_name
    ServerAlias www.$website_name
    DocumentRoot /var/www/html/$website_name/public_html
    ErrorLog /var/www/html/$website_name/logs/error.log
    CustomLog /var/www/html/$website_name/logs/access.log combined
</VirtualHost>" | sudo tee /etc/apache2/sites-available/$website_name.conf

# Enable the new site configuration
echo "Enabling the site configuration for $website_name..."
sudo a2ensite $website_name.conf
sudo systemctl reload apache2

echo "Configuration for $website_name completed."
