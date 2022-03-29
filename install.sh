#!/usr/bin/env bash

DIR="$( cd "$( dirname "$0" )" && pwd )"


ADDON_NAME="zul-reset-calculator"
WOW_ADDON_DIR="${1}"

LOCAL_ADDON_DIR="${DIR}/${ADDON_NAME}"
INSTALL_DIR="${WOW_ADDON_DIR}/${ADDON_NAME}"

if [[ -d "${INSTALL_DIR}" ]]
then
    echo "Cleaning existing addon"
    rm -r "${INSTALL_DIR}"
fi

echo "Installing addon"
cp -r "${DIR}/zul-reset-calculator/" "${INSTALL_DIR}"
