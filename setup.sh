#!/bin/bash
# Setup for basic MC 1.18 paper server; should be rerunable w/o error

# Install Dependencies
sudo apt-get install screen
jdk_url="https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb"
jdk_file=$(basename $jdk_url)
jdk_pkg=$(echo "$jdk_file" | sed -E "s/^([^_]*)_.*$/\1/") # e.g. jdk-17 from jdk-17_linux-x64_bin.deb
curl -O $jdk_url && sudo apt install -y ./$jdk_file && rm $jdk_file
ln -s "/usr/lib/jvm/$jdk_pkg/bin/java" /usr/bin/java

# Setup systemd service
cp minecraft@.service /etc/systemd/system/

# Add user
if ! id minecraft &>/dev/null; then
    useradd -rmd /opt/minecraft minecraft
fi
