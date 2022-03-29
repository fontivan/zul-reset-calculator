#!/usr/bin/env bash

# The current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

# The name of the addon
ADDON_NAME="zul-reset-calculator"

# The path to the WoW addon directory you want to install to
WOW_ADDON_DIR="${1}"

# The local directory in this repository
LOCAL_ADDON_DIR="${DIR}/src/${ADDON_NAME}"

# The addon directory inside the provided WoW addon folder
INSTALL_DIR="${WOW_ADDON_DIR}/${ADDON_NAME}"

# If the addon already exists then delete it
if [[ -d "${INSTALL_DIR}" ]]
then
    echo "Cleaning existing addon"
    rm -r "${INSTALL_DIR}"
fi

# Install the addon
echo "Installing addon"
cp -r "${LOCAL_ADDON_DIR}" "${INSTALL_DIR}"
