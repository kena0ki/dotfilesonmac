# For Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
# For Golang
[[ -z "$GOPATH" ]] && export GOPATH="$HOME/go"
[[ ! "$PATH" =~ "$GOPATH/bin" ]] && export PATH="$PATH:$GOPATH/bin"
