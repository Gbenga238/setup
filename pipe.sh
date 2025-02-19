# download the compiled pop binary
curl -L -o pop "https://dl.pipecdn.app/v0.2.5/pop"
# assign executable permission to pop binary
chmod +x pop
# create folder to be used for download cache
mkdir download_cache

sudo ufw allow 8003/tcp


sudo tee /etc/systemd/system/pop.service << 'EOF'
[Unit]
Description=POP Service
After=network.target
Wants=network-online.target

[Service]
# Set working directory
WorkingDirectory=/root/pipe

# Use absolute path for the executable
ExecStart=/root/pipe/pop --ram 10 --max-disk 100 --cache-dir /root/pipe/data --pubKey FU14V3D641ydEukzuNsaKzZv7KPdGzJPNzGaYVcNCV3E --signup-by-referral-route beec35b8db359035

# Restart policy (ensures it always runs)
Restart=always
RestartSec=5

# Resource limits (adjust if needed)
LimitNOFILE=65536
LimitNPROC=4096

# Logging (journalctl)
StandardOutput=journal
StandardError=journal
SyslogIdentifier=pop-service

[Install]
WantedBy=multi-user.target
EOF


# Reload systemd
sudo systemctl daemon-reload

# Enable the service (starts on boot)
sudo systemctl enable pop

# Start the service now
sudo systemctl start pop

# Check status
sudo systemctl status pop


/root/pipe/pop --status

cat /root/pipe/node_info.json