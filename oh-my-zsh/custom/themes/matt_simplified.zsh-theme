# Now that iTerm2 supports status bars that contain path, git status, and processes running
# I want a seriously simplified prompt

setopt prompt_subst
autoload colors
colors

#use extended color palette if available
if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
    red="%F{196}"
    green="%F{46}"
else
    turquoise="$fg[cyan]"
    orange="$fg[yellow]"
    purple="$fg[magenta]"
    hotpink="$fg[red]"
    limegreen="$fg[green]"
    red="$fg[red]"
    green="$fg[green]"
fi

autoload -U add-zsh-hook

function set_exit_status_dollar {
    if [ $? -eq 0 ]; then
        STATUS_DOLLAR="$"
    else
        STATUS_DOLLAR="%{$red%}$%{$reset_color%}"
    fi
}
add-zsh-hook precmd set_exit_status_dollar

TIME=
PROMPT=$' %{$green%}%~%{$reset_color%} %{$orange%}$(date "+%H:%M:%S")%{$reset_color%} $STATUS_DOLLAR '
