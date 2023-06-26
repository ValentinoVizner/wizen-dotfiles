For each tool that does not use the default settings, here will be a dedicated header with the configuration file.
## ZSHRC
```zsh fold file:.zshrc !tangle:~/.zshrc
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# need to disable in order for exa ls alias to work
DISABLE_LS_COLORS="true"
# FZF settings
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# Enable vi mode
bindkey -v

autoload -Uz compinit
compinit


source /Users/valentinovizner/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

plugins=(
    zsh-syntax-highlighting 
    zsh-autosuggestions
    fzf
    kubectl
    web-search
    zoxide
    rust
    ripgrep
    zsh-vi-mode
    fd
    zsh-bat
)
source $ZSH/oh-my-zsh.sh
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias w="NVIM_APPNAME=Wizen nvim"
alias shark="NVIM_APPNAME=shark nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
items=("default" "shark" "LazyVim" "NvChad" "AstroNvim")
config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
elif [[ $config == "default" ]]; then
    config=""
fi
NVIM_APPNAME=$config nvim $@
}


export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
# broot #
alias kubectl="kubecolor"
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

# Changing "ls" to "exa"
alias ls='exa -al --icons --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias kgn='kubectl get namespaces'

# Git aliases
alias guc='git reset --hard HEAD~1'


alias bat='bat --theme=ansi'
alias cat='bat --pager=never'

export PATH=/usr/local/bin:$PATH
export STARSHIP_CONFIG=~/.config/starship.toml
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

function gls { ls | rg "$1" }

source /Users/valentinovizner/.config/broot/launcher/bash/br

eval "$(starship init zsh)"
eval $(thefuck --alias)
eval "$(zoxide init zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"
zvm_after_init_commands+=(eval "$(atuin init zsh)")
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

## Starship
```toml fold file:starship.toml  !tangle:~/.config/starship.toml
format = """
[╭─ PC──── |](bold red) $battery$cmd_duration$memory_usage $time
[┣─ dir-env|](bold bright-white) $directory$kubernetes
[┣─ project|](bold bright-white) $git_branch$git_state$git_status $package$rust$golang$terraform$docker_context$python$docker_context$nodejs$lua$java
[╰─ cmd─── |](#114598) $character
"""


[aws]
style = "bold blue"

[aws.region_aliases]
eu-central-1 = "euc-1"
eu-west-1 = "euw-1"

[battery]
full_symbol = "🔋"
charging_symbol = "🔌"
discharging_symbol = '💀'

[[battery.display]]
threshold = 30
style = "bg:34A4E1"


[character]
success_symbol = "[❯❯](bold green)"
error_symbol = "[✖](bold red) "

[cmd_duration]
min_time = 10_000                    # Show command duration over 10,000 milliseconds (=10 sec)
format = " took [$duration]($style)"
style = "bg:#34A4E1"

[directory]
style = "bg:#34A4E1"
format = "[ $path ]($style)"
truncation_length = 4
truncation_symbol = "…/"
read_only = " "


# [directory]
# style = "bg:#DA627D"
# format = "[ $path ]($style)"
# truncation_length = 3
# truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "📄 "
"Downloads" = "📥 "
"Pictures" = "📷 "

[docker_context]
symbol = "🐳 "
style = "bg:#06969A"
format = '[[ $symbol $context ](bg:#06969A)]($style) $path'


[git_branch]
format = "[$symbol$branch]($style)"
symbol = "🌱"
style = "bg:#B7410E"

[git_commit]
# disabled = true
style = "bg:#E58F73 fg:#111111"
commit_hash_length = 4
# only_detached = true

[git_state]
style = "bg:#B7410E"
format = "[$state( $progress_current/$progress_total) ]($style)"
rebase = "rebase"
merge = "merge"
revert = "revert"
cherry_pick = "cherry"
bisect = "bisect"
am = "am"
am_or_rebase = "am/rebase"


[git_status]
conflicted = "⚔️ "
ahead = "🏎️ 💨 ×${count}"
behind = "🐢 ×${count}"
diverged = "🔱 🏎️ 💨 ×${ahead_count} 🐢 ×${behind_count}"
untracked = "🛤️  ×${count}"
stashed = "📦 "
modified = "📝 ×${count}"
staged = "🗃️  ×${count}"
renamed = "📛 ×${count}"
deleted = "🗑️  ×${count}"
style = "bg:#B7410E"
format = "[$all_status$ahead_behind]($style)"

[golang]
symbol = "ﳑ"
format = '[ $symbol ($version) ]($style)'


[helm]
# disabled = true
symbol = "⎈"


[kubernetes]
disabled = false
format = 'on [☸︎ in $context \($namespace\)](dimmed blue) '
detect_files = ['k8s']


[kubernetes.context_aliases]
".*dev.incubator*." = "dev-incubator"
".*qa.incubator*." = "qa-incubator"
".*stage.incubator*." = "stage-incubator"
".*production.incubator*." = "prod-incubator"


[memory_usage]
format = "$symbol[${ram}( | ${swap})]($style)"
threshold = 70
symbol = ""
disabled = false

[package]
disabled = true

[python]
symbol = "🐍 "
pyenv_version_name = true
format = ' [${symbol}python (${version} )(\($virtualenv\) )]($style)'
style = "bold yellow"
pyenv_prefix = "venv "
python_binary = ["./venv/bin/python", "python", "python3", "python2"]
detect_extensions = ["py"]
version_format = "v${raw}"

[rust]
# disabled = true
symbol = "🦀"
format = '[ $symbol ($version) ]($style)'

[time]
time_format = "%R"           # Hour:Minute Format
format = '[🕙 $time]($style)'
disabled = false

# [username]
# style_user = "fg:black bg:#D0F7FA"
# format = '[ $user ]($style)'
# show_always = true

[nodejs]
format = " [ Node.js $version](bold green) "
detect_files = ["package.json", ".node-version"]
detect_folders = ["node_modules"]

```
