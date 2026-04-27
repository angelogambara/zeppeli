#!/bin/zsh
# Backup files and directories
bak() {
  if [ "$#" -eq 0 ]; then
    echo >&2 'Usage: bak <file(s)>'
    return 1
  fi

  now=$(date +"%Y%m%d-%H%M%S")

  for f in "$@"; do
    f=${f%/} # strip trailing /

    if [ ! -e "$f" ]; then
      echo >&2 "Error: '$f': No such file or directory"
      continue
    fi

    cp -a -- "$f" "$f.$now.bak"
  done
}

# Rename files and directories (also works wtih one missing)
swp() {
  file1=${1%/} # strip trailing /
  file2=${2%/} # strip trailing /

  # Exit if 2 arguments are not provided.
  if [ "$#" -ne 2 ]; then
    echo >&2 "Usage: ${0##*/} <file1> <file2>"
    return 1
  fi

  # File can be missing. If it exists it must be writable.
  if [ -e "$file1" ] && [ ! -w "$file1" ]; then
    echo >&2 "Error: '$file1': No write access to file or directory"
    return 1
  fi

  # File can be missing. If it exists it must be writable.
  if [ -e "$file2" ] && [ ! -w "$file2" ]; then
    echo >&2 "Error: '$file2': No write access to file or directory"
    return 1
  fi

  # Exit if both files are missing.
  if [ ! -e "$file1" ] && [ ! -e "$file2" ]; then
    echo "Error: '$file1': No such file or directory" >&2
    echo "Error: '$file2': No such file or directory" >&2
    return 1
  fi

  # Ensure that the destination does never exist. Plus, silence the
  # output because I don't care if one file is missing.
  [ -e "$file1.tmp.$$" ] || mv -- "$file1" "$file1.tmp.$$" 2>/dev/null
  [ -e "$file1" ] || mv -- "$file2" "$file1" 2>/dev/null
  [ -e "$file2" ] || mv -- "$file1.tmp.$$" "$file2" 2>/dev/null

  # Return successful, unless the temp file still exists.
  [ -e "$file1.tmp.$$" ] || return 0
}

# Copy and go to the directory
cpg() {
  if cp -- "$1" "$2"; then
    [ -d "$2" ] && cd -- "$2" || return 1
  fi
}

# Move and go to the directory
mvg() {
  if mv -- "$1" "$2"; then
    [ -d "$2" ] && cd -- "$2" || return 1
  fi
}

# Make and go to the directory
mkdirg() {
  mkdir -p -- "$1" && cd -- "$1" || return 1
}

# Manage files in 'lf' and preview with 'ueberzug'
lf() {
  # --- 1. SETUP: Temporary directory and file ---
  temp_dir=${XDG_RUNTIME_DIR:-/tmp}

  if [ ! -d "$temp_dir" ] || [ ! -w "$temp_dir" ]; then
    echo >&2 "Error: Cannot write to temporary directory: $temp_dir"
    return 1
  fi

  last_dir_file=$(mktemp "$temp_dir"/last_dir.XXXXXXXXXX)

  # --- 2. SETUP: Ueberzug ---
  if [ -z "$SSH_CLIENT" ]; then
    export FIFO_UEBERZUG=$temp_dir/ueberzug-$$

    mkfifo "$FIFO_UEBERZUG" || {
      echo >&2 "Error: Cannot create Ueberzug FIFO: $FIFO_UEBERZUG"
      return 1
    }

    # Fork ueberzug reading input from the FIFO
    ueberzug layer -s -p json --no-opencv <"$FIFO_UEBERZUG" &
    exec 3>"$FIFO_UEBERZUG"

    # Ensure the cleanup function runs on any failure
    trap ueberzug_cleanup HUP INT QUIT TERM EXIT

    # --- 3. EXECUTION ---
    lf -last-dir-path="$last_dir_file" "$@" 3>&-
  else
    lf -last-dir-path="$last_dir_file" "$@"
  fi

  # --- 4. FINALIZE: Change Directory ---
  if [ -f "$last_dir_file" ]; then
    target_dir=$(cat "$last_dir_file")
    rm -f -- "$last_dir_file"

    # If the target is a valid directory, cd into it
    [ -d "$target_dir" ] && cd "$target_dir"/
  fi
}

# Gracefully stop Ueberzug
ueberzug_cleanup() {
  # Close file descriptor
  exec 3>&-
  # Remove the named pipe
  [ -e "$FIFO_UEBERZUG" ] && rm "$FIFO_UEBERZUG"
}
