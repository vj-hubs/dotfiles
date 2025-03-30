# Homebrew Configuration

This directory contains Homebrew package management configuration.

## Brewfile

The Brewfile is a list of all Homebrew packages, casks, and taps that should be installed.

### Generate Brewfile
To create/update the Brewfile from your current installations:
```bash
# Export all currently installed formulae, casks, and taps
brew bundle dump --force
```

### Install from Brewfile
To install all packages listed in the Brewfile:
```bash
# Install everything from Brewfile
brew bundle

# Or install with verbose output
brew bundle --verbose
```

### Check Brewfile Status
To verify if all dependencies are installed:
```bash
brew bundle check
```

### Clean Up
To remove packages not listed in Brewfile:
```bash
# Show what would be uninstalled
brew bundle cleanup

# Actually uninstall
brew bundle cleanup --force
```

## List Current Installations

To get a list of currently installed packages:
```bash
# List all installed formulae
brew list

# List all installed casks
brew list --cask

# List all taps
brew tap
```

## Update Packages

To update all packages:
```bash
# Update Homebrew itself
brew update

# Upgrade all packages
brew upgrade

# Cleanup old versions
brew cleanup
``` 