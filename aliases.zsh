# Shortcuts
alias ll="ls -lah"
alias ..="cd .."
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadcli="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias c="clear"
alias path="echo $PATH | sed 's/:/\'$'\n/g'"
alias edal="vim $DOTFILES/aliases.zsh"

# Folders
alias proj="cd $HOME/projects"
alias dotfiles="cd $DOTFILES"

# Development
alias a="php artisan"
alias cfresh="rm -rf vendor/ && composer install"
alias bps="brew-php-switcher"

# Docker
alias dx="docker-compose"
