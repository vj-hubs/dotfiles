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
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(pyenv init - zsh)"
source $ZSH/oh-my-zsh.sh
export PYENV_ROOT="$HOME/.pyenv"
# RPS1='$(kube_ps1)'
alias code='cursor'
alias dev='cd $HOME/Work/Git'
alias de='cd $HOME/Work/Git/data-engineering'
alias repos='cd $HOME/Work/Git/repos'
alias learn='cd $HOME/Work/Git/development'
alias sts='sh $HOME/Work/Git/aws_sts.sh'
alias refresh='source ~/.zshrc'
alias k='kubecolor'
alias kx='kubectx'
alias tg='terragrunt'
alias tgfmt='terragrunt hclfmt --terragrunt-check --terragrunt-diff'
alias tf='terraform'
alias spyder='nohup spyder --new-instance option & disown'
alias notebook='nohup jupyter-notebook & disown'
alias jupyter='docker rm pyspark && docker run -d -p 8888:8888 -e NB_UID=1000 -e GRANT_SUDO=yes --user root --name pyspark -v $HOME/Work/Git:/home/jovyan/work jupyter/pyspark-notebook && docker logs pyspark'export PATH="/usr/local/opt/libpq/bin:$PATH"
alias activate_poetry="source \"\$(poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate\""

export PATH="/usr/local/opt/libpq/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"
export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ns() {
    kubectl config set-context --current --namespace=$1
}

# vs() {
#     # cd $1
#     cursor $1
# }

# vsc() {
#     local REPO_DIR=$HOME/Work/Git/

#     if [[ -d "$REPO_DIR/$1" ]]; then
#         cd "$REPO_DIR/$1" || return
#         cursor .
#     else
#         echo "Repository '$1' not found in $REPO_DIR"
#     fi
# }

# Zsh completion function
# _vs_completion() {
#     local REPO_DIR=$HOME/Work/Git/ops
#     compadd $(ls -d $REPO_DIR/*/ 2>/dev/null | xargs -n 1 basename)
# }

# compdef _vs_completion vsc

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
