# My Fishy conf
# Starship prompt
starship init fish | source

# Greetings my good sir
function fish_greeting
   printf '\n\n'
   fortune 
end

funcsave fish_greeting

# Aliases
alias gst='git status'
alias k='kubectl'
alias kgp='kubectl get pods'

# VSCode
function code
  set location "$PWD/$argv"
  open -n -b "com.microsoft.VSCode" --args $location
end

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/madavid/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/madavid/.ghcup/bin $PATH

# Go env
set -x GOPATH "/Users/madavid/go"
set -x GOBIN "/Users/madavid/go/bin"

# Ripgrep&FZF
# RTFM man fzf
set -x FZF_DEFAULT_COMMAND "rg --files --hidden"

# Artylab
set -x ARTY_LAB "public-docker-virtual.artylab.expedia.biz"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/madavid/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/madavid/Downloads/google-cloud-sdk/path.fish.inc'; end
