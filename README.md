# Simple Debian Minecraft Server Setup

A minimalist set of scripts to create multiple auto-starting minecraft servers on a debian-based machine.

Designed to be easy to clone & tweak to fit your needs.

* `git clone git@github.com:kmacdough/minecraft.git`: Grab files
* `cd minecraft`
* `sudo ./setup.sh`: Install dependencies & setup environment.
* `sudo ./provision.sh my_server -Mmx2G -Mms2G`: Provision a new server with 2G RAM.
* `systemctl start|stop minecraft@my_server`: Start/stop server.
* `systemctl enable|disable minecraft@my_server`: Enable/disable starting server on boot.