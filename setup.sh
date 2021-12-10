#!/bin/bash
# Setup for basic MC 1.18 paper server; should be rerunable w/o error
# Install Dependencies
sudo apt-get install screen
jdk_file="jdk-17_linux-x64_bin.deb"
jdk_url="https://download.oracle.com/java/17/latest/$jdk_file"
curl $jdk_url > $jdk_file && sudo apt install -y ./$jdk_file && rm $jdk_file
mkdir -p minecraft && cd minecraft
paper_url="https://papermc.io/api/v2/projects/paper/versions/1.18/builds/66/downloads/paper-1.18-66.jar"
curl $paper_url > paper.jar
echo "eula=true" > eula.txt
base_dir=$(pwd)
start_cmd="/usr/lib/jvm/jdk-17/bin/java -Xmx2048M -Xms2048M -jar $base_dir/paper.jar"
echo "cd $base_dir && screen -dmS minecraft $start_cmd" > start.sh && chmod u+x start.sh