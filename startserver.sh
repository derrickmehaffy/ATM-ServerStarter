#!/bin/bash
set -eu
FORGE_VERSION=43.2.3
MINECRAFT_VERSION=1.19.2
PACK_VERSION=8
ATM_RESTART_DELAY=10
MIRROR="https://maven.allthehosting.com/releases/"
# To use a specific Java runtime, set an environment variable named ATM_JAVA to the full path of java executable.
# ATM_JAVA=/custom/path/to/java

# To disable automatic restarts, set an environment variable named ATM_RESTART to false.
# ATM_RESTART=false

# To install the pack without starting the server, set an environment variable named ATM_INSTALL_ONLY to true.
#ATM_INSTALL_ONLY=true

INSTALLER="forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar"
FORGE_URL="${MIRROR}net/minecraftforge/forge/$MINECRAFT_VERSION-$FORGE_VERSION/forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar"

pause() {
  printf "%s\n" "Press enter to continue..."
  read ans
}

if ! command -v "${ATM_JAVA:-java}" >/dev/null 2>&1; then
  echo "Minecraft $MINECRAFT_VERSION requires Java 17 - Java not found"
  pause
  exit 1
fi

cd "$(dirname "$0")"
if [ ! -d libraries ]; then
  echo "Forge not installed, installing now."
  if [ ! -f "$INSTALLER" ]; then
    echo "No Forge installer found, downloading now."
    if command -v wget >/dev/null 2>&1; then
      echo "DEBUG: (wget) Downloading $FORGE_URL"
      wget -O "$INSTALLER" "$FORGE_URL"
    else
      if command -v curl >/dev/null 2>&1; then
        echo "DEBUG: (curl) Downloading $FORGE_URL"
        curl -o "$INSTALLER" -L "$FORGE_URL"
      else
        echo "Neither wget or curl were found on your system. Please install one and try again"
        pause
        exit 1
      fi
    fi
  fi

  echo "Running Forge installer."
  "${ATM_JAVA:-java}" -jar "$INSTALLER" -installServer
fi

if [ ! -e server.properties ]; then
  printf "allow-flight=true\nmotd=All the Mods $PACK_VERSION\nmax-tick-time=180000" >server.properties
fi

if [ "${ATM_INSTALL_ONLY:-false}" = "true" ]; then
  echo "INSTALL_ONLY: complete"
  exit 0
fi

JAVA_VERSION=$("${ATM_JAVA:-java}" -fullversion 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ ! "$JAVA_VERSION" -ge 17 ]; then
  echo "Minecraft $MINECRAFT_VERSION requires Java 17 - found Java $JAVA_VERSION"
  pause
  exit 1
fi

while true; do
  "${ATM_JAVA:-java}" @user_jvm_args.txt @libraries/net/minecraftforge/forge/$MINECRAFT_VERSION-$FORGE_VERSION/unix_args.txt nogui

  if [ "${ATM_RESTART:-true}" = "false" ]; then
    exit 0
  fi

  echo "Restarting automatically in $ATM_RESTART_DELAY seconds (press Ctrl + C to cancel)"
  sleep $ATM_RESTART_DELAY
done
