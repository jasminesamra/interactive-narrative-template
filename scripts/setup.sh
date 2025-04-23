#!/bin/bash

LOG_FILE="scripts/setup_log.txt"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

log "/////////////// Starting setup.sh | $(date) ///////////////" 

# ---------------------
# Git Configuration
# ---------------------
log "🔧 Configuring Git..." 

# Commit template
if git config --get commit.template | grep -q '.gitmessage.txt'; then
  log "✔️  Git commit.template already set" 
else
  log "Setting Git commit.template to .gitmessage.txt" 
  git config commit.template .gitmessage.txt
fi

log "/////////////// Finished running setup.sh | $(date) ///////////////" 
log "🎉 Setup complete! Please restart your terminal window before continuing. 🎉"