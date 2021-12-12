#!/bin/bash
# NOTE: Run as root user
if [ $# -eq 0 ]; then
    echo "Usage: $0 server_name [java_args...]"
    exit 1
fi

# TODO factor out somewhere better
server_url="https://papermc.io/api/v2/projects/paper/versions/1.18/builds/66/downloads/paper-1.18-66.jar"

# Check if server already provisioned
instance_folder="$(su - minecraft -c pwd)/instances/$1"
if [ -d "$instance_folder" ]; then
    echo "Instance already exists. Check status with:"
    echo "  systemctl status minecraft@$1"
else
    # Setup server directory w/ server (grabbed from $server_url), signed eula.txt and a start.sh
    mkdir -p "$instance_folder"
    curl $server_url > "$instance_folder/server.jar"
    echo eula=true > "$instance_folder/eula.txt"
    echo "/usr/bin/java ${@:2} -jar server.jar nogui" > "$instance_folder/start.sh"
    chmod u+x "$instance_folder/start.sh"
    # Give ownership to minecraft user so it can be run
    chown -R minecraft:minecraft "$instance_folder"

    echo "Created server in $instance_folder. Check that start.sh has preferred arguments"
    echo "Control server with: systemctl start|stop|restart|enable|disable|status minecraft@$1"
fi
