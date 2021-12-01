
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

AJAX_LINE_PREFIX='%{$fg_bold[white]%}[#] %{$reset_color%}'

# set prompt and rprompt
PROMPT="$FG[237]------------------------------------------------------------%{$reset_color%}
${AJAX_LINE_PREFIX} %{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%m%{$reset_color%} %{$fg[cyan]%}%~ %{$fg[yellow]%}$(git_prompt_short_sha)$(check_git_prompt_info)%{$reset_color%}
${AJAX_LINE_PREFIX} %F{green}\\$%f "
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
