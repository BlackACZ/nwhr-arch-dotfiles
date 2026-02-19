# ============================================
# NWHR Zsh Config
# Lightweight, fast, clean
# ============================================

# -- History -- #
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt share_history

# -- Prompt -- #
# Arch icon: blue for user, red for root
if [ "$(id -u)" -eq 0 ]; then
    ARCH_ICON="%F{red} %f"
    PROMPT_COLOR="red"
else
    ARCH_ICON="%F{blue} %f"
    PROMPT_COLOR="blue"
fi

# icon | host | user | dir
# dir: house if home, folder + name if elsewhere
PROMPT='${ARCH_ICON}%F{white}│%f %F{cyan}%m%f %F{white}│%f %F{green}%n%f %F{white}│%f %(~.%F{yellow} ~%f.%F{yellow} %1~%f) %F{white}❯%f '

# -- Aliases -- #
alias ls='lsd -l'
alias la='lsd -la'
alias ll='lsd -l'
alias lt='lsd --tree'
alias cat='bat --color=always --style=plain'

alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias cls='clear'
alias q='exit'

# -- Target aliases -- #
alias set-target='$HOME/bin/set-target'
alias clear-target='$HOME/bin/clear-target'
alias targets='cat $HOME/.targets 2>/dev/null || echo "No targets saved"'

# -- Path -- #
export PATH="$HOME/bin:$PATH"

# -- Plugins (lightweight) -- #
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# -- Autosuggestion color (gray, not distracting) -- #
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#555555'

# -- Key bindings -- #
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# -- Completion -- #
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
