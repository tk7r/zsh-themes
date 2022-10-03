
# get return code of last command and format it
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}

# information blocks
AJAX_USER_HOST_INFO='%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%}'
AJAX_LOCATION_INFO='%{$fg[cyan]%}%~%{$reset_color%}'
AJAX_GIT_INFO='%{$fg[yellow]%}$(git_prompt_short_sha)$(check_git_prompt_info)%{$reset_color%}'
AJAX_KUBE_PS1='$(kube_ps1)'

# assemble lines
AJAX_LINE_FINISHER=''
#$FG[237]------------------------------------------------------------%{$reset_color%}'
AJAX_LINE_INFO="${AJAX_USER_HOST_INFO} ${AJAX_LOCATION_INFO} ${AJAX_GIT_INFO} ${AJAX_KUBE_PS1}%{$reset_color%}"
AJAX_LINE_PROMPT='%F{blue}[%f '

AJAX_LINE_PREFIX='%{$fg_bold[white]%}[#] %{$reset_color%}'

# set prompt and rprompt
PROMPT="${AJAX_LINE_FINISHER}
${AJAX_LINE_PREFIX}${AJAX_LINE_INFO}
${AJAX_LINE_PREFIX}${AJAX_LINE_PROMPT}"
RPROMPT="${return_code} %F{blue}] %F{green}%D{%H:%M:%S} %f"

#
# GIT
#
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}"

# Do nothing if the branch is clean (no changes).
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✓"

# Add a yellow ✗ if the branch is dirty
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗"

ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg_bold[white]%}   ➤ %{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg[white]%}|"

#
# KUBE PS1
#
KUBE_PS1_PREFIX='/K8s/'
KUBE_PS1_SUFFIX=''
KUBE_PS1_DIVIDER='/'
KUBE_PS1_SYMBOL_ENABLE=false

