#!/bin/bash

# Function to check internet connection
check_internet_connection() {
  if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    return 0 # Internet connection is available
  else
    return 1 # Internet connection is not available
  fi
}

# Change to the specified directory
cd "$HOME/Documents/SecondBrain" || exit 1

# Log file path
LOG_FILE="$HOME/Sync/backup-log/backup_$(date +%Y-%m-%d_%H-%M-%S).log"

# Check internet connection
if check_internet_connection; then
  # Internet connection is available, proceed with Git commands
  {
    echo "===== Backup log for $(date +%Y-%m-%d_%H:%M:%S) ====="
    git add .
    git commit -m "backup for $(date +%Y-%m-%d)"
    git push origin HEAD
  } >> "$LOG_FILE" 2>&1
else
  # Internet connection is not available, output message and skip backup
  echo "No internet connection, skipping this backup" >> "$LOG_FILE"
fi
