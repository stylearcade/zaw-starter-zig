#!/bin/bash
set -e

echo "Checking Zig installation..."

# Check if zig is installed
if ! command -v zig &> /dev/null; then
    echo "Zig is not installed. Installing Zig..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo brew install zig
    else
        sudo snap install zig --classic --beta
    fi
else
    # Check Zig version
    ZIG_VERSION=$(zig version)
    echo "Current Zig version: $ZIG_VERSION"
    
    # Check if version is >= 0.14
    MAJOR_VERSION=$(echo $ZIG_VERSION | cut -d. -f1)
    MINOR_VERSION=$(echo $ZIG_VERSION | cut -d. -f2)
    
    if [[ $MAJOR_VERSION -eq 0 && $MINOR_VERSION -lt 14 ]]; then
        echo "Zig version $ZIG_VERSION is below required version 0.14"
        read -p "Would you like to upgrade? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sudo brew upgrade zig
            else
                sudo snap refresh zig --beta
            fi
        else
            echo "Warning: You may encounter compatibility issues with Zig version < 0.14"
        fi
    else
        echo "Zig version is compatible"
    fi
fi

echo "Zig installation check complete"