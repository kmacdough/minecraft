#!/bin/bash
# Run as root user
if [ $# -eq 0 ]; then
    echo "Usage: $0 {server_name}"
    exit 1
fi

server_url="https://papermc.io/api/v2/projects/paper/versions/1.18/builds/66/downloads/paper-1.18-66.jar"

# Setup server directory
instance_folder="$(su - minecraft -c pwd)/instances/$1"
if [ -d "$instance_folder" ]; then
    echo "Instance already exists. Check status with:"
    echo "  systemctl status minecraft@$1"
else
    mkdir -p "$instance_folder"
    curl $server_url > "$instance_folder/server.jar"
    echo eula=true > "$instance_folder/eula.txt"
    chown -R minecraft:minecraft "$instance_folder"

    # Start and enable (start after boot) the server.
    systemctl start "minecraft@$1"
    systemctl enable "minecraft@$1"
fi
