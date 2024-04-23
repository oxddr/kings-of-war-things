#!/bin/bash

set -euo pipefail

# Function to recursively rename directories to Camel Case and replace _ with spaces
rename_directories() {
  local target_directory="$1"

  if [ -z "$target_directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
  fi

  if [ ! -d "$target_directory" ]; then
    echo "Error: '$target_directory' is not a valid directory."
    exit 1
  fi

  find "$target_directory" -depth -type d -not -name "$target_directory" -exec bash -c '
    for dirpath do
      # Get the base directory name
      dirname=$(basename "$dirpath")

      # Convert to Camel Case and replace underscores with spaces
      newname=$(echo "$dirname" | tr _ " " | tr - " " | awk '\''{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1'\'')

      # Check if the new name is different
      if [ "$dirname" != "$newname" ]; then
        # Rename the directory
        mv "$dirpath" "$(dirname "$dirpath")/$newname"
        echo "Renamed: $dirpath -> $(dirname "$dirpath")/$newname"
      fi
    done
  ' bash {} +
}

# Function to copy files with ".stl" and ".svg" extensions recursively
copy_stl_and_svg_files() {
  local source_directory="$1"
  local destination_directory="$2"

  if [ -z "$source_directory" ] || [ -z "$destination_directory" ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
  fi

  if [ -L "$source_directory" ]; then
    # Resolve symlink if the source is a symlink
    source_directory=$(readlink -f "$source_directory")
  fi

  if [ ! -d "$source_directory" ]; then
    echo "Error: '$source_directory' is not a valid directory."
    exit 1
  fi

  # Create destination directory if it doesn't exist
  mkdir -p "$destination_directory"

  rsync -r --prune-empty-dirs \
    --include='*/' --exclude='*non_normalized.stl' --include='*.stl' --include='*.svg' --exclude='*' \
    --chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r \
    "$source_directory/" "$destination_directory"
  echo "STL and SVG files copied from '$source_directory' to '$destination_directory'"
}

copy_and_delete() {
  local source_directory="$1"
  local destination_directory="$2"

  if [ -z "$source_directory" ] || [ -z "$destination_directory" ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
  fi

  if [ ! -d "$source_directory" ]; then
    echo "Error: '$source_directory' is not a valid directory."
    exit 1
  fi

  # Create destination directory if it doesn't exist
  mkdir -p "$destination_directory"

  # Copy files and directories recursively to the destination
  cp -rf "$source_directory"/* "$destination_directory"

  # Check if the copy was successful
  if [ $? -eq 0 ]; then
    # Delete the source directory
    rm -rf "$source_directory"
    echo "Content from '$source_directory' copied to '$destination_directory' and source directory deleted."
  else
    echo "Error: Copying files from '$source_directory' to '$destination_directory' failed."
  fi
}

# Check if source and destination directories are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

# Change the current working directory to the directory where the script is located
cd "$(dirname "$0")" || exit 1

bazel build ...
copy_stl_and_svg_files "$1" "tmp-export"
rename_directories "tmp-export"
copy_and_delete "tmp-export" "$2"
