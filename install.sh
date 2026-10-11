#!/usr/bin/env bash

set -euo pipefail

ADDON_NAME="zul-reset-calculator"
LOCAL_ADDON_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ $# -ne 1 || -z "$1" ]]; then
    echo "Usage: $0 /path/to/World of Warcraft/Interface/AddOns" >&2
    exit 2
fi

WOW_ADDON_DIR="$1"
INSTALL_DIR="${WOW_ADDON_DIR%/}/${ADDON_NAME}"
if [[ "$WOW_ADDON_DIR" == "/" ]]; then
    INSTALL_DIR="/${ADDON_NAME}"
fi

mkdir -p -- "$INSTALL_DIR"
cp -- "${LOCAL_ADDON_DIR}/${ADDON_NAME}.lua" "$INSTALL_DIR/"

for toc_suffix in Mainline Vanilla Mists WoWForever; do
    cp -- "${LOCAL_ADDON_DIR}/${ADDON_NAME}_${toc_suffix}.toc" "$INSTALL_DIR/"
done

# Remove the old expansion TOC when upgrading an existing installation.
rm -f -- "${INSTALL_DIR}/${ADDON_NAME}_Wrath.toc"

echo "Installed ${ADDON_NAME} to ${INSTALL_DIR}"
