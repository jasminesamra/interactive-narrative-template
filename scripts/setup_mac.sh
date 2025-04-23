#!/bin/bash
# setup_mac.sh — Configures Git and adds VS Code to PATH for commit messages

LOG_FILE="scripts/setup_log.txt"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

log "/////////////// Starting setup_mac.sh | $(date) ///////////////" 

# ---------------------
# Git Configuration
# ---------------------
log "🔧 Configuring Git commit template..." 

# Commit template
if git config --get commit.template | grep -q '.gitmessage.txt'; then
  log "✔️  Git commit.template already set" 
else
  log "Setting Git commit.template to .gitmessage.txt" 
  git config commit.template .gitmessage.txt
fi

# VS Code as Git editor
if git config --get core.editor | grep -q 'code --wait'; then
  log "✔️  Git core.editor already set to VS Code" 
else
  log "Setting Git core.editor to VS Code"
  git config --global core.editor "code --wait"
fi

# ---------------------
# Install nvm
# ---------------------
log "🔧 Checking for nvm..."

if [ -d "$HOME/.nvm" ]; then
	log "✅ nvm already installed"
else
	log "📥 Installing nvm..."

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

	log "✅ nvm installation script run. Sourcing nvm..."

	# Add nvm to shell startup files (if not already there)
	if [[ $SHELL == *"zsh"* ]]; then
		if ! grep -q 'NVM_DIR' "$HOME/.zprofile"; then
			echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zprofile"
			echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.zprofile"
		fi
		source "$HOME/.zprofile"
	else
		if ! grep -q 'NVM_DIR' "$HOME/.bash_profile"; then
			echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.bash_profile"
			echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.bash_profile"
		fi
		source "$HOME/.bash_profile"
	fi
fi

# ---------------------
# VS Code CLI Setup
# ---------------------
log "🔧 Ensuring VS Code CLI is available..." 
VSCODE_PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

if [[ $SHELL == *"zsh"* ]]; then
  PROFILE="$HOME/.zprofile"
  log "Detected zsh shell" 
else
  PROFILE="$HOME/.bash_profile"
  log "Detected bash shell" 
fi

if ! grep -q "$VSCODE_PATH" "$PROFILE"; then
  log "Adding VS Code to PATH in $PROFILE" 
  echo -e "\n# Add VS Code CLI to PATH\nexport PATH=\"\$PATH:$VSCODE_PATH\"" >> "$PROFILE"
else
  log "VS Code PATH already exists in $PROFILE" 
fi

# Check if 'code' is now available
if command -v code >/dev/null 2>&1; then
  log "✅ 'code' command is available in PATH" 
else
  log "⚠️  'code' command not found. You may need to restart your terminal or run: source $PROFILE" 
fi

# ---------------------
# Install node and download dependencies
# ---------------------
nvm install node
npm install

log "/////////////// Finished running setup_mac.sh | $(date) ///////////////" 
log "🎉 Setup complete! Please restart your terminal window before continuing. 🎉"
