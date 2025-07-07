export ZSH="$HOME/.oh-my-zsh"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export TERRAGRUNT_TFPATH="terraform"
export TERRAGRUNT_PROVIDER_CACHE=1
export TERRAGRUNT_NON_INTERACTIVE=true
export TERRAGRUNT_IGNORE_EXTERNAL_DEPENDENCIES=true
export TERRAGRUNT_FETCH_DEPENDENCY_OUTPUT_FROM_STATE=true
export TF_CLI_CONFIG_FILE="$HOME/.terraform.d/terraform.rc"
export DOCKER_DEFAULT_PLATFORM="linux/amd64"
plugins=(git
        z
        aliases
        #kube-ps1
        zsh-autosuggestions
        #zsh-autocomplete
        #fzf-zsh-plugin
        )
eval "$(starship init zsh)"
source $ZSH/oh-my-zsh.sh
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
# RPS1='$(kube_ps1)'
export AWS_CONFIG_FILE="/Users/vj/Work/Git/coreops/devops/config/aws-vault.cfg"
export AWS_DEFAULT_REGION="eu-west-1"
alias code='cursor'
alias aws-prod-data='unset AWS_VAULT && aws-vault exec hubs-prod_data'
alias dev='cd /Users/vj/Work/Git'
alias main='git checkout main && git pull'
alias pull='git pull'
alias push='git push'
alias de='cd /Users/vj/Work/Git/data-engineering'
alias ops='cd /Users/vj/Work/Git/coreops'
alias infra='cd /Users/vj/Work/Git/coreops/infra'
alias repos='cd /Users/vj/Work/Git/repos'
alias learn='cd /Users/vj/Work/Git/development'
alias sts='sh /Users/vj/Work/Git/aws_sts.sh'
alias refresh='source ~/.zshrc'
alias k='kubecolor'
alias kx='kubectx'
alias aws-prod='kubectl config use-context hubs-prod/web/admin && aws-vault exec hubs-prod_admin'
alias aws-stage='kubectl config use-context hubs-stage/web/admin && aws-vault exec hubs-stage_admin'
alias aws-dev='kubectl config use-context hubs-dev/web/admin && aws-vault exec hubs-dev_admin'
alias aws-mgmt='aws-vault exec 3dhubs-management_admin'
alias tg='terragrunt'
alias tgfmt='terragrunt hclfmt --terragrunt-check --terragrunt-diff'
alias tf='terraform'
alias spyder='nohup spyder --new-instance option & disown'
alias cmds='cursor "/Users/vj/Library/CloudStorage/OneDrive-ProtoLabs,Inc/Backup/cmds.txt"'
alias notebook='nohup jupyter-notebook & disown'
alias jupyter='docker rm pyspark && docker run -d -p 8888:8888 -e NB_UID=1000 -e GRANT_SUDO=yes --user root --name pyspark -v /Users/vj/Work/Git:/home/jovyan/work jupyter/pyspark-notebook && docker logs pyspark'export PATH="/usr/local/opt/libpq/bin:$PATH"
alias activate_poetry="source \"\$(poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate\""
ns() {
    kubectl config set-context --current --namespace=$1
}

vs() {
    cd $1
    cursor .
}

# vsc() {
#     local REPO_DIR=~/Work/Git/coreops

#     if [[ -d "$REPO_DIR/$1" ]]; then
#         cd "$REPO_DIR/$1" || return
#         cursor .
#     else
#         echo "Repository '$1' not found in $REPO_DIR"
#     fi
# }

# Zsh completion function
# _vs_completion() {
#     local REPO_DIR=~/Work/Git/coreops
#     compadd $(ls -d $REPO_DIR/*/ 2>/dev/null | xargs -n 1 basename)
# }

# compdef _vs_completion vsc

export PATH="/usr/local/opt/libpq/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"
export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"

# >>> Added by Spyder >>>
alias uninstall-spyder=/Users/vj/Library/spyder-6/uninstall-spyder.sh
# <<< Added by Spyder <<<
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
# fpath=(/Users/vj/.docker/completions $fpath)
# autoload -Uz compinit
# compinit
# End of Docker CLI completions

cp ~/.zshrc "/Users/vj/Library/CloudStorage/OneDrive-ProtoLabs,Inc/Backup/zshrc"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# [[ -f ~/.inshellisense/zsh/init.zsh ]] && source ~/.inshellisense/zsh/init.zsh

# if [[ -z "$LOLCAT_ACTIVE" && -t 1 && -x "$(command -v lolcat)" && -x "$(command -v script)" ]]; then
#     export LOLCAT_ACTIVE=1
#     script -q /dev/null zsh | lolcat -f
#     exit $?
# fi


# Pipe command output to lolcat
_lc() {
    "$@" | lolcat
}
alias lc='_lc '
