#!/bin/bash

# Usage: ./update_files.sh <string_to_add>

echo " "
echo "...[UPDATING-INFRA-FILES]"
echo " "

# Default values
# DEFAULT_STRING="// @dart=3.0"
DEFAULT_STRING="// @dart=3.5"
DEFAULT_DIRECTORIES=("../infra_sdk/auth/lib" "../infra_sdk/account/lib" "../infra_sdk/engagement/lib")
# DEFAULT_DIRECTORIES=("../infra_sdk/auth/lib" "../infra_sdk/account/lib" "../infra_sdk/engagement/lib" "../infra_sdk/marketplace/lib" "../infra_sdk/vendor/lib" "../infra_sdk/communication/lib")

DEFAULT_DIO_VERSION="^5.3.3"
DEFAULT_SDK_VERSION="^3.5.3"
# DEFAULT_SDK_VERSION=">=3.0.2 <4.0.0"
PUBSPEC_FILES=("../infra_sdk/auth/pubspec.yaml" "../infra_sdk/account/pubspec.yaml" "../infra_sdk/engagement/pubspec.yaml")

# Names to be updated in pubspec.yaml
NAMES=("auth" "account" "engagement")

# Use provided argument or fall back to default string
STRING_TO_ADD=${1:-$DEFAULT_STRING}

SDK_VERSION=$DEFAULT_SDK_VERSION
DIO_VERSION=$DEFAULT_DIO_VERSION

echo "...[UPDATE-INFRA-PUBSPEC-YAML-PROCESSING]"
echo " "

# Loop through each pubspec.yaml file and update SDK, DIO versions, and name
for i in "${!PUBSPEC_FILES[@]}"; do
    PUBSPEC_FILE=${PUBSPEC_FILES[$i]}
    NEW_NAME=${NAMES[$i]}

    # Check if the file exists
    if [ ! -f "$PUBSPEC_FILE" ]; then
        echo "File $PUBSPEC_FILE does not exist: $PUBSPEC_FILE"
        continue
    fi

    # Update the SDK version
    sed -i.bak -E "s/sdk: '>=([^']*)'/sdk: '$SDK_VERSION'/" "$PUBSPEC_FILE"
    # Update the DIO version
    sed -i.bak -E "s/dio: '\^[^']*'/dio: '$DIO_VERSION'/" "$PUBSPEC_FILE"
    # Update the name (e.g., name: openapi -> name: auth/account/donor)
    # sed -i.bak -E "s/name: openapi/name: $NEW_NAME/" "$PUBSPEC_FILE"

    echo "[UPDATED PUBSPEC] => $PUBSPEC_FILE"
done

echo "...[UPDATE-INFRA-PUBSPEC-YAML-SUCCESS]"
echo " "

echo "...[UPDATING-INFRA-FILES-DART-SDK-VERSIONS-PROCESSING]"
echo " "

# Loop through each directory and update Dart SDK versions
for DIRECTORY in "${DEFAULT_DIRECTORIES[@]}"; do
    # Ensure the directory exists
    if [ ! -d "$DIRECTORY" ]; then
        echo "Directory $DIRECTORY does not exist."
        continue
    fi

    # Find and loop through all files in the directory and subdirectories
    find "$DIRECTORY" -type f | while read -r FILE; do
        # Skip pubspec.yaml files as they have already been processed
        if [[ "$FILE" == *"pubspec.yaml"* ]]; then
            continue
        fi

        # Add // @dart=3.0 to the top of other files
        (echo "$STRING_TO_ADD"; cat "$FILE") > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
        echo "[UPDATED] => $FILE"
    done
done

echo " "
echo "...[UPDATING-INFRA-FILES-DART-SDK-VERSIONS-SUCCESS]"
echo " "
