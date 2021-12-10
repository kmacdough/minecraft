#!/bin/bash
# Run as root user
if [ $# -eq 0 ]; then
    echo "Usage: $0 {server_name}"
    exit 1
fi

mc_home=$(su - minecraft -c pwd)
instance_folder="$mc_home/instances/$1"
paper_url="https://papermc.io/api/v2/projects/paper/versions/1.18/builds/66/downloads/paper-1.18-66.jar"

su - minecraft -c "mkdir -p $instance_folder"
su - minecraft -c "curl $paper_url > $instance_folder/paper.jar"
su - minecraft -c "echo eula=true > $instance_folder/eula.txt"

# Start and enable (start after boot) the server.
systemctl start "minecraft@$1"
systemctl enable "minecraft@$1"
