#!/bin/bash
set -euo pipefail

APP_NAME="YC X26 countdown"
APP_PATH="/Applications/${APP_NAME}.app"
VERSION="${1:-1.0}"
DMG_NAME="YC-X26-countdown-${VERSION}.dmg"
DIST_DIR="dist"
STAGING_DIR=$(mktemp -d)

# Verify the app exists
if [ ! -d "$APP_PATH" ]; then
    echo "Error: ${APP_PATH} not found" >&2
    exit 1
fi

# Verify code signing
echo "Verifying code signing..."
codesign --verify --deep --strict "$APP_PATH"
echo "Code signing: OK"

# Verify notarization
echo "Verifying notarization..."
spctl --assess --type execute --verbose "$APP_PATH" 2>&1 | grep -q "accepted"
echo "Notarization: OK"

# Create staging directory with app and Applications symlink
echo "Staging DMG contents..."
cp -R "$APP_PATH" "${STAGING_DIR}/${APP_NAME}.app"
ln -s /Applications "${STAGING_DIR}/Applications"

# Create dist directory
mkdir -p "$DIST_DIR"

# Create DMG
echo "Creating DMG..."
hdiutil create \
    -volname "$APP_NAME" \
    -srcfolder "$STAGING_DIR" \
    -ov \
    -format UDZO \
    "${DIST_DIR}/${DMG_NAME}"

# Clean up staging directory
rm -rf "$STAGING_DIR"

# Print SHA256
echo ""
echo "DMG created: ${DIST_DIR}/${DMG_NAME}"
SHA=$(shasum -a 256 "${DIST_DIR}/${DMG_NAME}" | awk '{print $1}')
echo "SHA256: ${SHA}"
