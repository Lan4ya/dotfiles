# zmodload zsh/zprof  # Load the profiling module
# ----------------------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Download Zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k 
zinit ice depth=1;
zinit light romkatv/powerlevel10k

# Use "zinit ice wait lucid" to lazy load plugins & snippets 

# Add zsh snippets 

zinit ice wait lucid 
zinit snippet OMZP::git # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git

zinit ice wait lucid
zinit snippet OMZP::command-not-found

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-completions

# zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Run a quiet parallel update automatically once every 7 days
local zinit_update_stamp="${ZINIT_HOME}/._last_auto_update"
if [[ -n "$ZINIT_HOME" && -n "$zinit_update_stamp"(#qN.mh+168) ]]; then
  (zinit self-update -q && zinit update --parallel -q && touch "$zinit_update_stamp") &!
elif [[ ! -f "$zinit_update_stamp" ]]; then
  touch "$zinit_update_stamp"
fi

# Compinit cache 
setopt extendedglob
local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n "$zcompdump"(#qN.mh+24) ]]; then
  autoload -Uz compinit && compinit -d "$zcompdump"
else
  autoload -Uz compinit && compinit -C -d "$zcompdump"
fi

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Tmux sessionizers 
# bindkey -s '\el' "tms\n" 
bindkey -s '\e0' "session-0\n" 
bindkey -s '\ed' "tms switch\n" 
bindkey -s '\ef' 'tmux-sessionizer\n' 

# Emacs Mode 
# bindkey -e  

# Useful emacs bindings for nav/editing: 
# M-b → move backward word
# M-f → move forward word
# M-d → del word after cursor

# "C-a: Move to BOL
# "C-e: Move to EOL
# "C-k: Delete from cursor to EOL
# "C-y: Paste the previously deleted text."

# Built in tty bindings:
# "C-w: Delete word beofre cursor 
# "C-u: Delete from cursor to BOL 

# Vi Mode 
bindkey -v   

# Make word movements (w/W/e/E/b/B) consistent like vim
autoload -U select-word-style
select-word-style bash  

# Custom functions for better vimming
move-to-middle-of-line() {
  local line=$BUFFER
  local len=${#line}
  CURSOR=$(( len / 2 ))
}

yank_to_clipboard() {
  zle vi-yank # yank normally
  print -rn -- "$CUTBUFFER" | wl-copy # yank also to clipboard (use xclip for x11)  
}

yank_eol_to_clipboard() {
  zle vi-yank-eol
  print -rn -- "$CUTBUFFER" | wl-copy 
}

paste_from_clipboard_put_before() {
  local clip
  clip=$(wl-paste 2>/dev/null) || return 1
  LBUFFER+="$clip"
}

paste_from_clipboard_put_after() {
  local clip
  clip=$(wl-paste 2>/dev/null) || return 1
  # if not at end, move over one char
  (( CURSOR < ${#BUFFER} )) && zle vi-forward-char
  LBUFFER+="$clip"
}

# this is so good it's criminal
edit_cli_in_nvim() {
  local tmpfile=$(mktemp /tmp/nvedit.XXXXXX)

  # Dump current buffer (what you typed so far) into tmpfile
  print -rn -- "$BUFFER" > "$tmpfile"

  # Open in nvim (blocking)
  nvim "$tmpfile"

  # Load back into ZLE buffer
  BUFFER=$(<"$tmpfile")
  CURSOR=${#BUFFER}

  rm -f "$tmpfile"
  zle reset-prompt
}

zle -N edit_cli_in_nvim
zle -N paste_from_clipboard_put_before
zle -N paste_from_clipboard_put_after
zle -N move-to-middle-of-line
zle -N yank_to_clipboard
zle -N yank_eol_to_clipboard

# Normal Mode:
# bindkey -M vicmd b vi-backward-word        
# bindkey -M vicmd B vi-backward-blank-word  
#
# bindkey -M vicmd p vi-repeat-search        
# bindkey -M vicmd P vi-rev-repeat-search    

bindkey -M vicmd 'j' backward-char
bindkey -M vicmd 'k' down-line-or-history
bindkey -M vicmd 'l' up-line-or-history
bindkey -M vicmd 'p' forward-char

bindkey -M vicmd 'J' beginning-of-line
bindkey -M vicmd 'L' move-to-middle-of-line 
bindkey -M vicmd 'P' end-of-line

bindkey -M vicmd ',' vi-repeat-find
bindkey -M vicmd ';' execute-named-cmd
bindkey -M vicmd ':' vi-rev-repeat-find

# bindkey -M vicmd 'h' vi-put-after    
# bindkey -M vicmd 'H' vi-put-before
bindkey -M vicmd 'h' paste_from_clipboard_put_after 
bindkey -M vicmd 'H' paste_from_clipboard_put_before 

# bindkey -M vicmd '\eh' paste_from_clipboard_put_after
# bindkey -M vicmd '\eH' paste_from_clipboard_put_before

bindkey -M vicmd 'o' yank_to_clipboard 
bindkey -M vicmd 'O' yank_eol_to_clipboard 

bindkey -M vicmd 'm' vi-open-line-below
bindkey -M vicmd 'M' vi-open-line-above

bindkey -M vicmd 'y' set-mark-command
bindkey -M vicmd 'Y' vi-join

bindkey -M vicmd '\er' redo # C-r is used by fzf-history-widget, so alt-r instead

bindkey -M vicmd "gn" edit_cli_in_nvim 

# Visual Mode:
bindkey -M visual 'j' vi-backward-char
bindkey -M visual 'k' down-line
bindkey -M visual 'l' up-line
bindkey -M visual 'p' vi-forward-char

bindkey -M visual 'J' beginning-of-line
bindkey -M visual 'L' move-to-middle-line #  custom widget
bindkey -M visual 'P' end-of-line

bindkey -M visual 'o' yank_to_clipboard #  custom widget

# Emacs binding addons:
bindkey -M viins '^P' history-search-backward
bindkey -M viins '^N' history-search-forward
bindkey -M viins '\ed' kill-word # del word after cursor
bindkey -M viins '^K' kill-line # del line after cursor
# Terminals/tty's already have ^W for del word before cursor and ^U for del line before cursor

# --------------------------------------------------------------------------

export KEYTIMEOUT=1 # Reduce timeout for escape sequences
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
setopt NO_FLOW_CONTROL # Disabled legacy TTY flow monitoring 
setopt HASH_CMDS # Application command caching
setopt appendhistory
setopt sharehistory
setopt auto_cd
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias nz='nvim ~/.zshrc'
alias sc='source ~/.config/zsh/.zshrc'
alias c='clear'
alias off='poweroff'
alias lv='ls -1 --color'
alias ls='ls --color'
alias sl='ls --color' # iykyk
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias yaycleanf='yay -Sc --noconfirm' 
alias parucleanf='paru -Sc --noconfirm' 
alias cleanf='sudo pacman -Sc --noconfirm' 
alias t='thunar' 
alias a='tmux a'
alias j='nvim' 
alias nv='NVIM_APPNAME=nvim-minimal nvim' 
alias sn='sudo -E nvim' 
alias code='code --use-gl=desktop'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f "$HOME/.github_pat" ]; then
    source "$HOME/.github_pat"
fi

# Start/reuse a persistent SSH agent
AGENT_SOCK="$HOME/.ssh/agent.sock"

if [ ! -S "$AGENT_SOCK" ]; then
    eval "$(ssh-agent -s -a "$AGENT_SOCK")" >/dev/null &! 
fi

export SSH_AUTH_SOCK="$AGENT_SOCK"

if ! ssh-add -l >/dev/null 2>&1; then
  ssh-add 2>/dev/null
fi

# View man pages with vim
export MANPAGER="vim -M +MANPAGER -"

typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.local/scripts"
  "$HOME/.cargo/bin"
  "/usr/local/mysql/bin"
  "/usr/local/share/mysql/bin"
  $path
)

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd z zsh)"
eval "$(mise env zsh)"
# eval "$(starship init zsh)" 

# ------------------------------------------------------------
# zprof | head -n 30  # Display the profiling report
