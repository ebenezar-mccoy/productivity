# $Id: zshrc,v 2.0 2019/02/09 12:00:00 ebenezar Exp $

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

# paths
path=(
  /usr/local/opt/ruby/bin
  /usr/local/lib/ruby/gems/2.6.0/bin/
  /usr/local/opt/python/libexec/bin
  /usr/local/Cellar/terraform@0.11/0.11.14/bin
  /opt/chefdk/bin
  /usr/local/bin
  /usr/local/sbin
  /bin
  /usr/bin
  /sbin
  /usr/sbin
  /usr/local/opt/mysql-client/bin
)

manpath=(
  /usr/man
  /usr/share/man
  /usr/X11R6/man
  /usr/local/man
)

fpath=(~/.zsh/zsh-completions/src $fpath)

export path manpath
typeset -U path manpath

# basic env setup
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
export REPORTTIME=10
export EDITOR='nvim'
export NULLCMD=:
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LESSCHARSET=utf-8
export PAGER='less'
#export TERM=screen-256color
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline]]]]]]]'
# export CLASSPATH=.:/home/mariusz.makowski/libs/jruby-1.7.2/lib/jruby.jar

# aliases
alias vi="nvim"
alias ls='ls -F'
alias lsl="ls -ltSrhF"
alias find='noglob find'
alias mkdir='nocorrect mkdir'
alias grep='egrep'
alias lsd='ls -ld *(-/DN)'
alias sgrep='egrep -v "^$|^#"'
# alias python='python3'
alias pip='pip3'
alias tmux='tmux -2'
alias sublime='subl --command toggle_full_screen'
alias curl='curl --netrc-file ~/.netrc -k'
alias ansible='ANSIBLE_STDOUT_CALLBACK=default ansible'
# alias mv='nocorrect mv'
# alias mv='noglob mv'
# alias cp='nocorrect cp'

# hashes ( directory aliases )
hash -d log="/var/log"
hash -d puppet=~/Documents/repos.nosync/puppet
hash -d ansible=~/Documents/repos.nosync/ansible
# export WORKSPACE=~/Documents/repos.nosync/ansible
hash -d devops-scripts=~/Documents/repos.nosync/devops-scripts
hash -d terraform=~/Documents/repos.nosync/terraform
hash -d repos=~/Documents/repos.nosync
hash -d apps=~/Documents/repos.nosync/apps
hash -d ansible-locale=~/Documents/repos.nosync/ansible-locale
hash -d tc-applications=~/Documents/repos.nosync/tc-applications
hash -d teamcity-agent=~/Documents/repos.nosync/teamcity-agent


# keybinds
bindkey -e
bindkey ' '  magic-space
bindkey '^I' complete-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' emacs-forward-word
bindkey '^B' emacs-backward-word
bindkey '^w' backward-delete-word
bindkey '^[' insert-last-word

# prediction
autoload predict-on
predict-toggle() {
  ((predict_on=1-predict_on)) && predict-on || predict-off
}
zle -N predict-toggle
bindkey '^Z'   predict-toggle
zstyle ':predict' toggle true
zstyle ':predict' verbose true

# sets
setopt \
  brace_ccl inc_append_history hist_ignore_space \
  hist_no_store hist_no_functions hist_ignore_all_dups \
  hist_expire_dups_first no_hup \
  no_check_jobs autocd autolist autopushd autoresume \
  cdablevars extendedglob globdots longlistjobs \
  noclobber notify pushdminus pushdsilent \
  pushdtohome rcquotes sunkeyboardhack recexact \
  correct complete_in_word promptsubst

# unset
unset mailpath nomatch MAILCHECK MAIL

# mass move
autoload -U zmv

# completions
zmodload -i zsh/complist
zstyle ':completion:*' menu select=4

autoload -U compinit
compinit -u

zstyle ':completion:*::::' completer _expand _complete _ignored #_approximate
zstyle ':completion:*:expand:*' tag-order all-expansions

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:processes' command 'ps -x -o pid,nice,pcpu,tt,args'

zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
  '*?.o' '*~' # '*?.orig'

zstyle ':completion:*:functions' ignored-patterns '_*'

# zsh speed up completions
zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*(scp|ssh):*' hosts $_myhosts
local _myusers
_myusers=( 'mariusz.makowski' 'root' 'm.makowski' )
zstyle ':completion:*:(scp|ssh):*' users $_myusers

# colors
autoload -U colors
colors

export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;00:cd=40;33;00:or=40;31;00:ex=00;32:*.tar=00;31:*.tgz=00;31:*.rar=00;31:*.ace=00;31:*.zip=00;31:*.bz2=00;31:*.rpm=00;31:*.gz=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.png=00;35:*.tga=00;35:*.xpm=00;35:*.mpg=00;37:*.avi=00;37:*.mov=00;37:*.mp3=01;35:*.flac=01;35:*.ogg=01;35:*.mpc=01;35:*.wav=01;35:*.ape=01;35:*.core=00;33'
export CLICOLOR='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;00:cd=40;33;00:or=40;31;00:ex=00;32:*.tar=00;31:*.tgz=00;31:*.rar=00;31:*.ace=00;31:*.zip=00;31:*.bz2=00;31:*.rpm=00;31:*.gz=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.png=00;35:*.tga=00;35:*.xpm=00;35:*.mpg=00;37:*.avi=00;37:*.mov=00;37:*.mp3=01;35:*.flac=01;35:*.ogg=01;35:*.mpc=01;35:*.wav=01;35:*.ape=01;35:*.core=00;33'
zstyle ':completion:*' list-colors $LS_COLORS

# clipboard
set clipboard=unnamed

# zsh highlight
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# fuzzy search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^p' fzf-file-widget
FZF_DEFAULT_OPTS='--multi --reverse --height=20%'
FZF_CTRL_R_OPTS='--sort'
# FZF_TMUX='1'
# FZF_TMUX_HEIGHT='20%'

# functions
reload () {
  exec $SHELL $SHELL_ARGS "$@"
}

saneperms()
{
  find . -type d -print0| xargs -r -0 chmod 755
  find . -type f -print0| xargs -r -0 chmod ${1:=644}
}

function mdcat()
{
  cat $* | markdown | html2text
}


# GIT_PROMPT_EXECUTABLE="haskell"
# PROMPT='%{$fg_no_bold[blue]%}%~%b$(git_super_status)%  %(!|%{$fg_no_bold[yellow]%}|%{$fg_bold[black]%})%(?..%{$fg[red]%})%#%{$fg_no_bold[default]%} '
# precmd () {
#   prompt="%{$fg_no_bold[blue]%}%~%b$(git_super_status)%  %(!|%{$fg_no_bold[yellow]%}|%{$fg_bold[black]%})%(?..%{$fg[red]%})%#%{$fg_no_bold[default]%} "
# }
# source ~/.zsh/git.zsh

source ~/.zsh/awsmfa.zsh

function checkJenkinsfile()
{
  curl --silent -X POST -F 'jenkinsfile=<Jenkinsfile' https://jenkins.cci-dev.pl/pipeline-model-converter/validate --netrc-file ~/.netrc
}

#stty erase '^?'

# prompt
autoload -U promptinit; promptinit
prompt pure
zstyle ':prompt:pure:prompt:*' color green
