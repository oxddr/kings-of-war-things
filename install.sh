#!/bin/bash

set -euo pipefail

# Check if the operating system is macOS
if [[ $(uname) != "Darwin" ]]; then
    echo "This script is intended to run on macOS only."
    exit 1
fi

mkdir -p $HOME/Documents/OpenSCAD/libraries

libraries=$(bazel query 'labels("srcs", kind("openscad_library", //...))' 2>/dev/null | tr -d "/" | tr ":" "/")

for library in $libraries; do
    mkdir -p $HOME/Documents/OpenSCAD/libraries/$(dirname $library)
    ln -sf $PWD/$library $HOME/Documents/OpenSCAD/libraries/$library
    # Print the target and linked file using ln in the line above
    echo "Linked $PWD/$library to $HOME/Documents/OpenSCAD/libraries/$library"
done
