#!/bin/bash

# Update package lists
sudo apt update

# Install XFCE and its components
sudo apt install -y xfce4 xfce4-goodies

# Download and install NoMachine
wget https://download.nomachine.com/download/8.16/Linux/nomachine_8.16.1_1_amd64.deb
sudo dpkg -i nomachine_8.16.1_1_amd64.deb


echo "exec startxfce4" > ~/.xsession  
chmod +x ~/.xsession  
ls /usr/share/xsessions/

# Install Chromium browser
sudo apt install -y chromium-browser

# Create Chromium shortcut on Desktop
cat <<EOL > ~/Desktop/chromium-browser.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Chromium Browser
Comment=Launch Chromium with custom options
Exec=chromium-browser --no-sandbox --disable-gpu --disable-software-rasterizer --gtk-version=4 --password-store=basic
Icon=chromium-browser
Terminal=false
Categories=Network;WebBrowser;
EOL

# Make Desktop shortcut executable
chmod +x ~/Desktop/chromium-browser.desktop

# Create system-wide Chromium shortcut
sudo bash -c 'cat <<EOL > /usr/share/applications/chromium-browser-custom.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Chromium Browser (Custom)
Comment=Launch Chromium with custom options
Exec=chromium-browser --no-sandbox --disable-gpu --disable-software-rasterizer --gtk-version=4 --password-store=basic
Icon=chromium-browser
Terminal=false
Categories=Network;WebBrowser;
EOL'

# Clean up
rm nomachine_8.16.1_1_amd64.deb

echo "Installation completed successfully!"

