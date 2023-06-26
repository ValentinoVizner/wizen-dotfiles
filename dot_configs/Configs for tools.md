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
[starship](https://starship.rs/) is customizable prompt for any shell, written in Rust.
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

## Zellij
[zellij](https://zellij.dev/) is Terminal multiplexer, alternative to Tmux, written in Rust
```kdl fold file:config.kdl  !tangle:~/.config/zellij/config.kdl
// copy_command: "xclip -selection clipboard" # x11
keybinds clear-defaults=false {
    normal {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl q" { Quit; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    locked {
        bind "Ctrl g" { SwitchToMode "normal"; }
    }
    pane {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl p" "Enter" "Space" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl q" { Quit; }
        bind "h" "Left" { MoveFocus "Left"; }
        bind "l" "Right" { MoveFocus "Right"; }
        bind "j" "Down" { MoveFocus "Down"; }
        bind "k" "Up" { MoveFocus "Up"; }
        bind "p" { SwitchFocus; }
        bind "n" { NewPane; SwitchToMode "normal"; }
        bind "d" { NewPane "Down"; SwitchToMode "normal"; }
        bind "r" { NewPane "Right"; SwitchToMode "normal"; }
        bind "x" { CloseFocus; SwitchToMode "normal"; }
        bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
        bind "z" { TogglePaneFrames; SwitchToMode "normal"; }
        bind "w" { ToggleFloatingPanes; SwitchToMode "normal"; }
        bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "normal"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0; }
    }
    tab {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl t" "Enter" "Space" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
        bind "Ctrl q" { Quit; }
        bind "h" "Left" "Up" "k" { GoToPreviousTab; }
        bind "l" "Right" "Down" "j" { GoToNextTab; }
        bind "n" { NewTab; SwitchToMode "normal"; }
        bind "x" { CloseTab; SwitchToMode "normal"; }
        bind "s" { ToggleActiveSyncTab; SwitchToMode "normal"; }
        bind "1" { GoToTab 1; SwitchToMode "normal"; }
        bind "2" { GoToTab 2; SwitchToMode "normal"; }
        bind "3" { GoToTab 3; SwitchToMode "normal"; }
        bind "4" { GoToTab 4; SwitchToMode "normal"; }
        bind "5" { GoToTab 5; SwitchToMode "normal"; }
        bind "6" { GoToTab 6; SwitchToMode "normal"; }
        bind "7" { GoToTab 7; SwitchToMode "normal"; }
        bind "8" { GoToTab 8; SwitchToMode "normal"; }
        bind "9" { GoToTab 9; SwitchToMode "normal"; }
        bind "Tab" { ToggleTab; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    resize {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl n" "Enter" "Space" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl q" { Quit; }
        bind "h" "Left" { Resize "Left"; }
        bind "j" "Down" { Resize "Down"; }
        bind "k" "Up" { Resize "Up"; }
        bind "l" "Right" { Resize "Right"; }
        bind "=" { Resize "Increase"; }
        bind "+" { Resize "Increase"; }
        bind "-" { Resize "Decrease"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    move {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl h" "Enter" "Space" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl q" { Quit; }
        bind "n" "Tab" { MovePane; }
        bind "h" "Left" { MovePane "Left"; }
        bind "j" "Down" { MovePane "Down"; }
        bind "k" "Up" { MovePane "Up"; }
        bind "l" "Right" { MovePane "Right"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    scroll {
        bind "e" { EditScrollback; SwitchToMode "normal"; }
        bind "Ctrl s" "Space" "Enter" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
        bind "Ctrl q" { Quit; }
        bind "j" "Down" { ScrollDown; }
        bind "k" "Up" { ScrollUp; }
        bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
        bind "d" { HalfPageScrollDown; }
        bind "u" { HalfPageScrollUp; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "s" { SwitchToMode "entersearch"; SearchInput 0; }
    }
    session {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl o" "Enter" "Space" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl q" { Quit; }
        bind "d" { Detach; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    search {
        bind "Ctrl s" "Space" "Enter" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl b" { SwitchToMode "tmux"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
        bind "Ctrl q" { Quit; }
        bind "j" "Down" { ScrollDown; }
        bind "k" "Up" { ScrollUp; }
        bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
        bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
        bind "d" { HalfPageScrollDown; }
        bind "u" { HalfPageScrollUp; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "s" { SwitchToMode "entersearch"; SearchInput 0; }
        bind "n" { Search "Down"; }
        bind "p" { Search "Up"; }
        bind "c" { SearchToggleOption "CaseSensitivity"; }
        bind "w" { SearchToggleOption "Wrap"; }
        bind "o" { SearchToggleOption "WholeWord"; }
    }
    entersearch {
        bind "Enter" { SwitchToMode "search"; }
        bind "Ctrl c" "Esc" { SearchInput 27; SwitchToMode "scroll"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    RenameTab {
        bind "Enter" "Ctrl c" "Esc" { SwitchToMode "normal"; }
        bind "Esc" { UndoRenameTab; SwitchToMode "tab"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    RenamePane {
        bind "Enter" "Ctrl c" "Esc" { SwitchToMode "normal"; }
        bind "Esc" { UndoRenamePane; SwitchToMode "pane"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
    }
    tmux {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl n" { SwitchToMode "resize"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl o" "Enter" "Space" "Esc" { SwitchToMode "normal"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "[" { SwitchToMode "scroll"; }
        bind "Ctrl q" { Quit; }
        bind "Ctrl b" { Write 2; SwitchToMode "normal"; }
        bind "\"" { NewPane "Down"; SwitchToMode "normal"; }
        bind "%" { NewPane "Right"; SwitchToMode "normal"; }
        bind "z" { ToggleFocusFullscreen; SwitchToMode "normal"; }
        bind "c" { NewTab; SwitchToMode "normal"; }
        bind "," { SwitchToMode "RenameTab"; TabNameInput 0; }
        bind "p" { GoToPreviousTab; SwitchToMode "normal"; }
        bind "n" { GoToNextTab; SwitchToMode "normal"; }
        bind "Left" { MoveFocus "Left"; SwitchToMode "normal"; }
        bind "Right" { MoveFocus "Right"; SwitchToMode "normal"; }
        bind "Down" { MoveFocus "Down"; SwitchToMode "normal"; }
        bind "Up" { MoveFocus "Up"; SwitchToMode "normal"; }
        bind "h" { MoveFocus "Left"; SwitchToMode "normal"; }
        bind "l" { MoveFocus "Right"; SwitchToMode "normal"; }
        bind "j" { MoveFocus "Down"; SwitchToMode "normal"; }
        bind "k" { MoveFocus "Up"; SwitchToMode "normal"; }
        bind "Alt n" { NewPane; }
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
        bind "Alt j" "Alt Down" { MoveFocus "Down"; }
        bind "Alt k" "Alt Up" { MoveFocus "Up"; }
        bind "o" { FocusNextPane; }
        bind "Alt =" { Resize "Increase"; }
        bind "Alt +" { Resize "Increase"; }
        bind "Alt -" { Resize "Decrease"; }
        bind "d" { Detach; }
    }
}

// Choose what to do when zellij receives SIGTERM, SIGINT, SIGQUIT or SIGHUP
// eg. when terminal window with an active zellij session is closed
// Options:
//   - detach (Default)
//   - quit
//
// on_force_close "quit"

// Send a request for a simplified ui (without arrow fonts) to plugins
// Options:
//   - true
//   - false (Default)
//
simplified_ui true

// Choose the path to the default shell that zellij will use for opening new panes
// Default: $SHELL
//
default_shell "zsh"

// Toggle between having pane frames around the panes
// Options:
//   - true (default)
//   - false
//
// pane_frames true

// Choose the theme that is specified in the themes section.
// Default: default
//

//themes {
//   everforest-dark {
//        bg "#2b3339"
//        fg "#d3c6aa"
//        black "#4b565c"
//        red "#e67e80"
//        green "#a7c080"
//        yellow "#dbbc7f"
//        blue "#7fbbb3"
//        magenta "#d699b6"
//        cyan "#83c092"
//        white "#d3c6aa"
//        orange "#FF9E64"
//    }
//}
themes {
    catppuccin-mocha {
    bg "#585b70"
    fg "#cdd6f4"
    red "#f38ba8"
    green "#a6e3a1"
    blue "#89b4fa"
    yellow "#f9e2af"
    magenta "#f5c2e7"
    orange "#fab387"
    cyan "#89dceb"
    black "#181825"
    white "#cdd6f4"
    }
}


theme "catppuccin-mocha" 

// The name of the default layout to load on startup
// Default: "default"
//
// default_layout "compact"

// Choose the mode that zellij uses when starting up.
// Default: normal
//
// default_mode "locked"

// Toggle enabling the mouse mode.
// On certain configurations, or terminals this could
// potentially interfere with copying text.
// Options:
//   - true (default)
//   - false
//
// mouse_mode false

// Configure the scroll back buffer size
// This is the number of lines zellij stores for each pane in the scroll back
// buffer. Excess number of lines are discarded in a FIFO fashion.
// Valid values: positive integers
// Default value: 10000
//
// scroll_buffer_size 10000

// Provide a command to execute when copying text. The text will be piped to
// the stdin of the program to perform the copy. This can be used with
// terminal emulators which do not support the OSC 52 ANSI control sequence
// that will be used by default if this option is not set.
// Examples:
//
// copy_command "xclip -selection clipboard" // x11
// copy_command "wl-copy"                    // wayland
// copy_command "pbcopy"                     // osx

// Choose the destination for copied text
// Allows using the primary selection buffer (on x11/wayland) instead of the system clipboard.
// Does not apply when using copy_command.
// Options:
//   - system (default)
//   - primary
//
copy_clipboard "primary"

// Enable or disable automatic copy (and clear) of selection when releasing mouse
// Default: true
//
copy_on_select false

// Path to the default editor to use to edit pane scrollbuffer
// Default: $EDITOR or $VISUAL
//
scrollback_editor "/usr/local/bin/nvim"

// When attaching to an existing session with other users,
// should the session be mirrored (true)
// or should each user have their own cursor (false)
// Default: false
//
// mirror_session true

// The folder in which Zellij will look for layouts
//
// layout_dir /path/to/my/layout_dir

// The folder in which Zellij will look for themes
//
// theme_dir "/path/to/my/theme_dir"

plugins {
    tab-bar { path "tab-bar"; }
    status-bar { path "status-bar"; }
    strider { path "strider"; }
    compact-bar { path "compact-bar"; }
}


themes {
  default {
    fg "#C0CAF5"
    bg "#1A1B26"
    black "#15161E"
    red "#F7768E"
    green "#9ECE6A"
    yellow "#E0AF68"
    blue "#7AA2F7"
    magenta "#BB9AF7"
    cyan "#7DCFFF"
    white "#C0CAF5"
    orange "#FF9E64"
  }
}

ui {
  pane_frames {
    rounded_corners true
  }
}

```

## Wezterm
[wezterm](https://wezfurlong.org/wezterm/) A GPU-accelerated cross-platform terminal emulator and multiplexer, written in Rust.
For me the selling point is the configuration file that in Lua format, which is handy since Neovim is in Lua mostly nowadays.
Configuration is split into multiple files for easier maintenance, files are the following:
### Bar setup
```lua file:bar.lua  !tangle:~/.config/wezterm/bar.lua
local wezterm = require("wezterm")

local M = {}

M.config = {
  dividers = "slant_right",
  indicator = {
    leader = {
      enabled = true,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic",
    pane_count = "superscript",
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = {
    enabled = true,
    format = "%H:%M",
  },
}

local function tableMerge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

local C = {}

M.setup = function(config)
  M.config = tableMerge(M.config, config)
  local dividers = {
    slant_right = {
      left = utf8.char(0xe0be),
      right = utf8.char(0xe0bc),
    },
    slant_left = {
      left = utf8.char(0xe0ba),
      right = utf8.char(0xe0b8),
    },
    arrows = {
      left = utf8.char(0xe0b2),
      right = utf8.char(0xe0b0),
    },
    rounded = {
      left = utf8.char(0xe0b6),
      right = utf8.char(0xe0b4),
    },
  }

  C.div = {
    l = "",
    r = "",
  }
  if M.config.dividers then
    C.div.l = dividers[M.config.dividers].left
    C.div.r = dividers[M.config.dividers].right
  end

  C.leader = {
    enabled = M.config.indicator.leader.enabled or true,
    off = M.config.indicator.leader.off,
    on = M.config.indicator.leader.on,
  }

  C.mode = {
    enabled = M.config.indicator.mode.enabled,
    names = M.config.indicator.mode.names,
  }

  C.tabs = {
    numerals = M.config.tabs.numerals,
    pane_count_style = M.config.tabs.pane_count,
    brackets = {
      active = M.config.tabs.brackets.active,
      inactive = M.config.tabs.brackets.inactive,
    },
  }

  C.clock = {
    enabled = M.config.clock.enabled,
    format = M.config.clock.format,
  }

  C.p = (M.config.dividers == "rounded") and "" or " "

  wezterm.log_info(C)
end

-- superscript/subscript
local function numberStyle(number, script)
  local scripts = {
    superscript = {
      "⁰",
      "¹",
      "²",
      "³",
      "⁴",
      "⁵",
      "⁶",
      "⁷",
      "⁸",
      "⁹",
    },
    subscript = {
      "₀",
      "₁",
      "₂",
      "₃",
      "₄",
      "₅",
      "₆",
      "₇",
      "₈",
      "₉",
    },
  }
  local numbers = scripts[script]
  local number_string = tostring(number)
  local result = ""
  for i = 1, #number_string do
    local char = number_string:sub(i, i)
    local num = tonumber(char)
    if num then
      result = result .. numbers[num + 1]
    else
      result = result .. char
    end
  end
  return result
end

local roman_numerals = {
  "Ⅰ",
  "Ⅱ",
  "Ⅲ",
  "Ⅳ",
  "Ⅴ",
  "Ⅵ",
  "Ⅶ",
  "Ⅷ",
  "Ⅸ",
  "Ⅹ",
  "Ⅺ",
  "Ⅻ",
}

-- custom tab bar
wezterm.on(
  "format-tab-title",
  function(tab, tabs, panes, config, hover, max_width)
    local colours = config.resolved_palette.tab_bar

    local active_tab_index = 0
    for _, t in ipairs(tabs) do
      if t.is_active == true then
        active_tab_index = t.tab_index
      end
    end

    local rainbow = {
      config.resolved_palette.ansi[2],
      config.resolved_palette.indexed[16],
      config.resolved_palette.ansi[4],
      config.resolved_palette.ansi[3],
      config.resolved_palette.ansi[5],
      config.resolved_palette.ansi[1],
    }

    local i = tab.tab_index % 6
    local active_bg = rainbow[i + 1]
    local active_fg = colours.background
    local inactive_bg = colours.inactive_tab.bg_color
    local inactive_fg = colours.inactive_tab.fg_color
    local new_tab_bg = colours.new_tab.bg_color

    local s_bg, s_fg, e_bg, e_fg

    -- the last tab
    if tab.tab_index == #tabs - 1 then
      if tab.is_active then
        s_bg = active_bg
        s_fg = active_fg
        e_bg = new_tab_bg
        e_fg = active_bg
      else
        s_bg = inactive_bg
        s_fg = inactive_fg
        e_bg = new_tab_bg
        e_fg = inactive_bg
      end
    elseif tab.tab_index == active_tab_index - 1 then
      s_bg = inactive_bg
      s_fg = inactive_fg
      e_bg = rainbow[(i + 1) % 6 + 1]
      e_fg = inactive_bg
    elseif tab.is_active then
      s_bg = active_bg
      s_fg = active_fg
      e_bg = inactive_bg
      e_fg = active_bg
    else
      s_bg = inactive_bg
      s_fg = inactive_fg
      e_bg = inactive_bg
      e_fg = inactive_bg
    end

    local pane_count = ""
    if C.tabs.pane_count_style then
      local tabi = wezterm.mux.get_tab(tab.tab_id)
      local muxpanes = tabi:panes()
      local count = #muxpanes == 1 and "" or tostring(#muxpanes)
      pane_count = numberStyle(count, C.tabs.pane_count_style)
    end

    local index_i
    if C.tabs.numerals == "roman" then
      index_i = roman_numerals[tab.tab_index + 1]
    else
      index_i = tab.tab_index + 1
    end

    if tab.is_active then
      index = string.format(
        "%s%s%s ",
        C.tabs.brackets.active[1],
        index_i,
        C.tabs.brackets.active[2]
      )
    else
      index = string.format(
        "%s%s%s ",
        C.tabs.brackets.inactive[1],
        index_i,
        C.tabs.brackets.inactive[2]
      )
    end

    -- start and end hardcoded numbers are the Powerline + " " padding
    local fillerwidth = 2 + string.len(index) + string.len(pane_count) + 2

    local tabtitle = tab.active_pane.title
    local width = config.tab_max_width - fillerwidth - 1
    if (#tabtitle + fillerwidth) > config.tab_max_width then
      tabtitle = wezterm.truncate_right(tabtitle, width) .. "…"
    end

    local title = string.format(" %s%s%s%s", index, tabtitle, pane_count, C.p)

    return {
      { Background = { Color = s_bg } },
      { Foreground = { Color = s_fg } },
      { Text = title },
      { Background = { Color = e_bg } },
      { Foreground = { Color = e_fg } },
      { Text = C.div.r },
    }
  end
)

-- custom status
wezterm.on("update-status", function(window, pane)
  local active_kt = window:active_key_table() ~= nil
  local show = C.leader.enabled or (active_kt and C.mode.enabled)
  if not show then
    window:set_left_status("")
    return
  end

  local palette = window:effective_config().resolved_palette

  local leader = ""
  if C.leader.enabled then
    local leader_text = C.leader.off
    if window:leader_is_active() then
      leader_text = C.leader.on
    end
    leader = wezterm.format({
      { Foreground = { Color = palette.background } },
      { Background = { Color = palette.ansi[5] } },
      { Text = " " .. leader_text .. C.p },
    })
  end

  local mode = ""
  if C.mode.enabled then
    local mode_text = ""
    local active = window:active_key_table()
    if C.mode.names[active] ~= nil then
      mode_text = C.mode.names[active] .. ""
    end
    mode = wezterm.format({
      { Foreground = { Color = palette.background } },
      { Background = { Color = palette.ansi[5] } },
      { Attribute = { Intensity = "Bold" } },
      { Text = mode_text },
      "ResetAttributes",
    })
  end

  local first_tab_active = window:mux_window():tabs_with_info()[1].is_active
  local divider_bg = first_tab_active and palette.ansi[2]
      or palette.tab_bar.inactive_tab.bg_color

  local divider = wezterm.format({
    { Background = { Color = divider_bg } },
    { Foreground = { Color = palette.ansi[5] } },
    { Text = C.div.r },
  })

  window:set_left_status(leader .. mode .. divider)

  if C.clock.enabled then
    local time = wezterm.time.now():format(C.clock.format)
    window:set_right_status(wezterm.format({
      { Background = { Color = palette.tab_bar.background } },
      { Foreground = { Color = palette.ansi[6] } },
      { Text = time },
    }))
  end
end)

return M
```

### Fonts setup
```lua file:fonts.lua  !tangle:~/.config/wezterm/fonts.lua
local wezterm = require("wezterm")

local F = {}
local fonts = {
	operator_mono = {
		font = {
			family = "OperatorMono Nerd Font",
			harfbuzz_features = {
				"cv06=1",
				"cv14=1",
				"cv32=1",
				"ss04=1",
				"ss07=1",
				"ss09=1",
			},
		},
		size = 15,
		font_rules = {
			italics = false,
		},
	},
}
F.get_font = function(name)
	return {
		font = wezterm.font_with_fallback({
			fonts[name].font,
		}),
		size = fonts[name].size,
	}
end

return F
```
### Keybindings setup
```lua file:keybindings.lua  !tangle:~/.config/wezterm/keybindings.lua
local wezterm = require("wezterm")
local act = wezterm.action

local shortcuts = {}

local map = function(key, mods, action)
  if type(mods) == "string" then
    table.insert(shortcuts, { key = key, mods = mods, action = action })
  elseif type(mods) == "table" then
    for _, mod in pairs(mods) do
      table.insert(shortcuts, { key = key, mods = mod, action = action })
    end
  end
end

local toggleTabBar = wezterm.action_callback(function(window)
  wezterm.GLOBAL.enable_tab_bar = not wezterm.GLOBAL.enable_tab_bar
  window:set_config_overrides({
    enable_tab_bar = wezterm.GLOBAL.enable_tab_bar,
  })
end)

local openUrl = act.QuickSelectArgs({
  label = "open url",
  patterns = { "https?://\\S+" },
  action = wezterm.action_callback(function(window, pane)
    local url = window:get_selection_text_for_pane(pane)
    wezterm.open_with(url)
  end),
})

-- use 'Backslash' to split horizontally
map("\\", "LEADER", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
-- and 'Minus' to split vertically
map("-", "LEADER", act.SplitVertical({ domain = "CurrentPaneDomain" }))
-- map 1-9 to switch to tab 1-9, 0 for the last tab
for i = 1, 9 do
  map(tostring(i), { "LEADER", "SUPER" }, act.ActivateTab(i - 1))
end
map("0", { "LEADER", "SUPER" }, act.ActivateTab(-1))
-- 'hjkl' to move between panes
map("h", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Left"))
map("j", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Down"))
map("k", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Up"))
map("l", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Right"))
-- resize
map("h", "LEADER|SHIFT", act.AdjustPaneSize({ "Left", 5 }))
map("j", "LEADER|SHIFT", act.AdjustPaneSize({ "Down", 5 }))
map("k", "LEADER|SHIFT", act.AdjustPaneSize({ "Up", 5 }))
map("l", "LEADER|SHIFT", act.AdjustPaneSize({ "Right", 5 }))
-- spawn & close
map("c", "LEADER", act.SpawnTab("CurrentPaneDomain"))
map("x", "LEADER", act.CloseCurrentPane({ confirm = true }))
map("t", { "SHIFT|CTRL", "SUPER" }, act.SpawnTab("CurrentPaneDomain"))
map("w", { "SHIFT|CTRL", "SUPER" }, act.CloseCurrentTab({ confirm = true }))
map("n", { "SHIFT|CTRL", "SUPER" }, act.SpawnWindow)
-- zoom states
map("z", { "LEADER", "SUPER" }, act.TogglePaneZoomState)
map("Z", { "LEADER", "SUPER" }, toggleTabBar)
-- copy & paste
map("v", "LEADER", act.ActivateCopyMode)
map("c", { "SHIFT|CTRL", "SUPER" }, act.CopyTo("Clipboard"))
map("v", { "SHIFT|CTRL", "SUPER" }, act.PasteFrom("Clipboard"))
map("f", { "SHIFT|CTRL", "SUPER" }, act.Search("CurrentSelectionOrEmptyString"))
-- rotation
map("e", { "LEADER", "SUPER" }, act.RotatePanes("Clockwise"))
-- pickers
map(" ", "LEADER", act.QuickSelect)
map("o", { "LEADER", "SUPER" }, openUrl)
map("p", { "LEADER", "SUPER" }, act.PaneSelect({ alphabet = "asdfghjkl;" }))
map("R", { "LEADER", "SUPER" }, act.ReloadConfiguration)
map("u", "SHIFT|CTRL", act.CharSelect)
map("p", { "SHIFT|CTRL", "SHIFT|SUPER" }, act.ActivateCommandPalette)
-- view
map("Enter", "ALT", act.ToggleFullScreen)
map("-", { "CTRL", "SUPER" }, act.DecreaseFontSize)
map("=", { "CTRL", "SUPER" }, act.IncreaseFontSize)
map("0", { "CTRL", "SUPER" }, act.ResetFontSize)
-- switch fonts
map("f", "LEADER", act.EmitEvent("switch-font"))
-- debug
map("l", "SHIFT|CTRL", act.ShowDebugOverlay)

map(
  "r",
  { "LEADER", "SUPER" },
  act.ActivateKeyTable({
    name = "resize_mode",
    one_shot = false,
  })
)

local key_tables = {
  resize_mode = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
  },
}

-- add a common escape sequence to all key tables
for k, _ in pairs(key_tables) do
  table.insert(key_tables[k], { key = "Escape", action = "PopKeyTable" })
  table.insert(key_tables[k], { key = "Enter", action = "PopKeyTable" })
  table.insert(
    key_tables[k],
    { key = "c", mods = "CTRL", action = "PopKeyTable" }
  )
end

return {
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5000 },
  keys = shortcuts,
  disable_default_key_bindings = true,
  key_tables = key_tables,
}
```

### Theme setup
```lua file:theme.lua  !tangle:~/.config/wezterm/theme.lua
local wezterm = require("wezterm")

local F = {}

F.scheme_for_appearance = function(appearance, theme)
  if appearance:find("Dark") then
    return theme.dark
  else
    return theme.light
  end
end

F.custom_colorscheme = function()
  local americano = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
  americano.background = "#000000"
  americano.tab_bar.background = "#040404"
  americano.tab_bar.inactive_tab.bg_color = "#0f0f0f"
  americano.tab_bar.new_tab.bg_color = "#080808"

  return {
    ["Catppuccin Americano"] = americano
  }
end

return F
```

### Wezterm Setup
```lua file:wezterm.lua  !tangle:~/.config/wezterm/wezterm.lua
local wezterm = require("wezterm")
local theme = require("theme")
-- Thanks to winston for a lot of this config :)
-- Look for more of his setup at https://github.com/nekowinston/dotfiles
require("bar").setup({
	dividers = "rounded", -- or "slant_left", "arrows", "rounded", false
	indicator = {
		leader = {
			enabled = true,
			off = " ",
			on = " ",
		},
		mode = {
			enabled = true,
			names = {
				resize_mode = "RESIZE",
				copy_mode = "VISUAL",
				search_mode = "SEARCH",
			},
		},
	},
	tabs = {
		numerals = "arabic", -- or "roman"
		pane_count = "superscript", -- or "subscript", false
		brackets = {
			active = { "", ":" },
			inactive = { "", ":" },
		},
	},
	clock = {
		-- note that this overrides the whole set_right_status
		enabled = true,
		format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
	},
})

wezterm.GLOBAL = {
	font = "operator_mono",
	enable_tar_bar = true,
}
local font = require("fonts").get_font(wezterm.GLOBAL.font)

local opts = {
	font = font.font,
	font_size = font.size,
	window_decorations = "RESIZE",
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.6,
	},
	color_schemes = theme.custom_colorscheme(),
	color_scheme = theme.scheme_for_appearance(wezterm.gui.get_appearance(), {
		-- dark = "Everforest Dark (Gogh)",
		dark = "Catppuccin Americano",
		light = "Catppuccin Mocha",
	}),
	tab_bar_at_bottom = true,
	tab_max_width = 22,
	use_fancy_tab_bar = false,
	window_background_opacity = 1.00,
	hide_tab_bar_if_only_one_tab = false,
	enable_tar_bar = wezterm.GLOBAL.tab_bar_hidden,
	enable_tab_bar = false,
	adjust_window_size_when_changing_font_size = false,
	use_resize_increments = false,
	audible_bell = "Disabled",
	clean_exit_codes = { 130 },
	default_cursor_style = "BlinkingBar",
	enable_scroll_bar = false,
	check_for_updates = false,
}
for k, v in pairs(require("keybindings")) do
	opts[k] = v
end

return opts
```
