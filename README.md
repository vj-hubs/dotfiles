# Personal Development Environment Configuration

This repository contains my personal development environment configuration files for various tools and applications.

## Directory Structure

```
dotfiles/
├── brew/
│   ├── Brewfile         # Homebrew packages and applications
│   └── README.md        # Homebrew configuration documentation
├── cursor/
│   ├── keybindings.json   # Cursor IDE keyboard shortcuts
│   ├── settings.json      # Cursor IDE settings
│   ├── extensions.json    # Recommended Cursor extensions
│   ├── tasks.json         # Cursor IDE task configurations
│   └── README.md          # Cursor configuration documentation
├── starship/
│   ├── starship.toml     # Starship prompt configuration
│   └── README.md         # Starship configuration documentation
├── zsh/
│   ├── .zshrc            # ZSH shell configuration
│   └── README.md         # ZSH configuration documentation
```

## Setup Instructions

### Cursor IDE Setup
1. Copy the files from `cursor/` to:
   ```
   ~/Library/Application Support/Cursor/User/
   ```
   - `settings.json`: Includes theme settings (August - Gruvbox), font configurations (Fira Code), and terminal customizations
   - `keybindings.json`: Custom keyboard shortcuts
   - `tasks.json`: Custom task configurations
   - `extensions.json`: Recommended extensions for development

### ZSH Setup
1. Copy `.zshrc` to your home directory:
   ```bash
   cp zsh/.zshrc ~/.zshrc
   ```
2. The `.zshrc` includes:
   - Oh My ZSH configuration
   - Starship prompt configuration
   - Python environment settings (pyenv)
   - AWS configurations
   - Kubernetes aliases and functions
   - Custom aliases and functions for development
   - Docker completions
   - NVM (Node Version Manager) setup

### Starship Setup
1. Install Starship (included in Brewfile):
   ```bash
   brew install starship
   ```
2. Copy configuration:
   ```bash
   mkdir -p ~/.config
   cp starship/starship.toml ~/.config/starship.toml
   ```
3. The configuration includes:
   - Custom prompt styling
   - Git integration
   - Python environment display
   - Kubernetes context
   - AWS profile
   - Command duration
   - Directory truncation

### Dependencies
- [Oh My ZSH](https://ohmyz.sh/)
- [Starship Prompt](https://starship.rs/)
- [pyenv](https://github.com/pyenv/pyenv)
- [Cursor IDE](https://cursor.sh/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [aws-vault](https://github.com/99designs/aws-vault)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [kubectx](https://github.com/ahmetb/kubectx)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [terraform](https://www.terraform.io/)

### Homebrew Setup
1. Install Homebrew if not already installed:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. Install all packages from Brewfile:
   ```bash
   cd brew && brew bundle
   ```

### Homebrew Packages
You can install all packages at once using the Brewfile:
```bash
cd brew && brew bundle
```

Or install individual packages using: `brew install <package-name>`

#### Kubernetes Tools
- `k9s` - Terminal UI to interact with Kubernetes clusters
- `kubecolor` - Colorized kubectl output
- `kubectx` - Switch between Kubernetes contexts
- `kubernetes-cli` - Kubernetes command-line tool
- `helm` - Kubernetes package manager
- `kind` - Run local Kubernetes clusters

#### Infrastructure Tools
- `terraform` - Infrastructure as Code
- `terragrunt` - Terraform wrapper for keeping configurations DRY
- `aws-vault` - Securely store and access AWS credentials
- `aws-cli` - Amazon Web Services CLI
- `azure-cli` - Microsoft Azure CLI
- `pomerium-cli` - Identity-aware proxy CLI

#### Development Tools
- `gh` - GitHub CLI
- `git` - Version control system
- `jq` - Command-line JSON processor
- `direnv` - Environment variable manager
- `starship` - Cross-shell prompt
- `shellcheck` - Shell script static analysis
- `tree` - Directory listing
- `pgcli` - PostgreSQL CLI with auto-completion
- `postgresql@14` - PostgreSQL database

#### Python Tools
- `pyenv` - Python version manager
- `python@3.12` - Python runtime

#### Fonts and UI
- `font-fira-code` - Monospaced font with programming ligatures

## Features

### Terminal Customization
- Green cursor and text in terminal
- Fira Code font with ligatures
- Custom prompt using Starship

### Development Tools
- Python development environment with pyenv
- AWS configuration with aws-vault
- Kubernetes management with aliases and functions
- Terraform and Terragrunt configurations
- Docker integration
- Node.js management with NVM

### Custom Functions
- `ns()`: Quick namespace switching in Kubernetes
- `vs()`: Open directory in Cursor IDE
- `vsc()`: Navigate to and open CoreOps repositories

### Useful Aliases
- `dev`: Navigate to Git projects directory
- `refresh`: Reload ZSH configuration
- `k`: Shorthand for kubecolor
- `kx`: Shorthand for kubectx
- Various AWS profile shortcuts
- Git shortcuts (pull, push, main)
- Project directory navigation shortcuts

## Maintenance
Remember to periodically update this repository when making significant changes to your development environment configuration.
