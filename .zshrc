# For Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
# For Golang
[[ -z "$GOPATH" ]] && export GOPATH="$HOME/go"
[[ ! "$PATH" =~ "$GOPATH/bin" ]] && export PATH="$GOPATH/bin:$PATH"
# For gh
source ~/.ghtoken.env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # local binary (for rust-analyzer)
# export PATH="~/.local/bin:$PATH"

PS1="%T %~ %#"
