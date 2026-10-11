#!/usr/bin/env bash
set -euo pipefail

ADDON_NAME="zul-reset-calculator"
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    cat <<EOF
Usage: $0 <WoW AddOns directory>

Install ${ADDON_NAME} into an existing World of Warcraft AddOns directory.
Example: $0 "\$HOME/Games/World of Warcraft/_classic_/Interface/AddOns"
EOF
}

if [[ "${1-}" == "-h" || "${1-}" == "--help" ]]; then
    if [[ "$#" -ne 1 ]]; then
        echo "Error: help cannot be combined with other arguments." >&2
        usage >&2
        exit 2
    fi
    usage
    exit 0
fi

if [[ "$#" -ne 1 ]]; then
    echo "Error: expected exactly one WoW AddOns directory." >&2
    usage >&2
    exit 2
fi

if [[ "$1" == -* ]]; then
    echo "Error: unknown option: $1" >&2
    usage >&2
    exit 2
fi

WOW_ADDON_DIR="$1"
if [[ ! -d "${WOW_ADDON_DIR}" ]]; then
    printf 'Error: invalid WoW AddOns directory: %s\n' \
        "${WOW_ADDON_DIR}" >&2
    exit 2
fi

LOCAL_ADDON_DIR="${DIR}"
INSTALL_DIR="${WOW_ADDON_DIR%/}/${ADDON_NAME}"

TOC_SUFFIXES=(
    "Mainline"
    "Vanilla"
    "Mists"
    "Forever"
)

SOURCE_FILES=("${LOCAL_ADDON_DIR}/${ADDON_NAME}.lua")
for TOC_SUFFIX in "${TOC_SUFFIXES[@]}"; do
    SOURCE_FILES+=("${LOCAL_ADDON_DIR}/${ADDON_NAME}_${TOC_SUFFIX}.toc")
done

for SOURCE_FILE in "${SOURCE_FILES[@]}"; do
    if [[ ! -f "${SOURCE_FILE}" ]]; then
        echo "Error: required addon file is missing: ${SOURCE_FILE}" >&2
        exit 1
    fi
done

if [[ -d "${INSTALL_DIR}" ]]; then
    echo "Cleaning existing addon"
    rm -r -- "${INSTALL_DIR}"
fi

echo "Installing addon"
mkdir -p -- "${INSTALL_DIR}"
for SOURCE_FILE in "${SOURCE_FILES[@]}"; do
    cp -- "${SOURCE_FILE}" "${INSTALL_DIR}/"
done

echo "Installed ${ADDON_NAME} to ${INSTALL_DIR}"
