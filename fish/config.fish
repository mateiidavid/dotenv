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
