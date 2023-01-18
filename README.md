# All the Mods Server Starter Script

This script is designed to make it easy to start a server for All the Mods packs. It will download the server files, install the required libraries, and start the server.

## Pre-word

This script was forked from the script that the AllTheMods Team provides. I have made some changes to make it easier to use and to make it more flexible. The goal was to generalize the script so it will work with all ATM pack versions from ATM7+.

## Requirements

1. Java 17 or higher
2. Curl or Wget installed
3. Existing ATM server files

## Usage

1. Download the script to the ATM server directory
2. Change the permissions to allow for execution: `chmod +x startserver.sh`
3. Run the Script

## Variables and Settings

| Variable          | Description                                                      | Default       | Required |
|-------------------|------------------------------------------------------------------|---------------|----------|
| ATM_JAVA          | The exact path to the java executable                            | /usr/bin/java | No       |
| ATM_RESTART       | Boolean to enable auto restarting                                | true          | Yes      |
| ATM_RESTART_DELAY | The delay in seconds between restarts in seconds                 | 10            | Yes      |
| ATM_INSTALL_ONLY  | If set to true, the script will only install the server and exit | false         | No       |
| FORGE_VERSION     | The version of Forge to use                                      | 43.2.3        | Yes      |
| MINECRAFT_VERSION | The version of Minecraft to use                                  | 1.19.2        | Yes      |
| PACK_VERSION      | The version of the pack to use                                   | 8             | Yes      |

## What the script does

1. Downloads the Minecraft libraries
2. Downloads the Forge installer
3. Installs the Forge server
4. Validates Java is properly installed
5. Modifies the server.properties file to enable flight, set the MOTD, and modifies the max tick time
6. Runs the ATM Server
7. Watches for server crashes or stops and restarts the server after the configured delay
8. (Optionally) Installs the server and exits

## Tested Packs

| Pack Version | Tested | Works | Date Tested |
|--------------|--------|-------|-------------|
| 8 (1.0.8)    | Yes    | Yes   | 2023-01-17  |
| 7 (0.4.34)   | Yes    | Yes   | 2023-01-17  |

## Contribution

I'm open to contributions. Please submit a pull request. Ideally the script should be able to work with all ATM pack versions from ATM7+ so anything that can help with that is appreciated.