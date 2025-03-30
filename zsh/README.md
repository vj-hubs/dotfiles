# ZSH Configuration

This directory contains configuration files for ZSH shell.

## File Locations

The configuration files are stored in the home directory:
```bash
~/.zshrc           # Main ZSH configuration
~/.zsh_history     # Command history
```

## Files

### .zshrc
- **Purpose**: Main ZSH configuration including aliases, functions, and plugin settings
- **Export Command**:
```bash
cp ~/.zshrc ./zshrc
```
- **Import Command**:
```bash
cp ./zshrc ~/.zshrc
source ~/.zshrc  # Reload configuration
```

### Generating Configuration Files
To recreate these configurations on a new machine:

1. Install Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Install required plugins:
```bash
# Example plugins mentioned in .zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

3. Copy the configuration:
```bash
cp ./zshrc ~/.zshrc
source ~/.zshrc
```

## Command History

To export command history for documentation:
```bash
# Export last 1000 commands
fc -l -n -1000 > command_history.txt
```

## Related Tools

The .zshrc configuration assumes the following tools are installed:
- Oh My Zsh
- Starship prompt
- pyenv
- nvm (Node Version Manager)
- Docker
- kubectl
- aws-cli

These can be installed using the Brewfile in the root directory. 