# sorin.zsh-theme
# screenshot: http://i.imgur.com/aipDQ.png
#

function prompt_pwd {
  local pwd="${PWD/#$HOME/~}"
  if [[ "$pwd" == [/~] ]]; then
    unset MATCH
    echo $pwd
  else
    echo "$(echo ${pwd:h}|sed -e 's+/\([^.]\|\.[^.]\)[^\/]*+/\1+g' -e 's+/$++')/${${pwd:t}//\%/%%}"
  fi
  # if [[ "$pwd" == (#m)[/~] ]]; then
  #   unset MATCH
  #   # echo "$MATCH"
  #   echo "~"
  # else
  #   # echo "${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  #   echo "$(echo ${pwd:h}|sed -e 's+/\([^.]\|\.[^.]\)[^\/]*+/\1+g')/${${pwd:t}//\%/%%}"
  # fi
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
  local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%}"
  local lreturn_status="%(?.%{%F{44}%B%}.%{%F{208}%B%})❯"
  
  if [[ "$HOST_PROMPT_COLOR" == "" ]]; then
    HOST_PROMPT_COLOR="214"
  fi
   
  PROMPT='🐻  %{%F{45}%}$(prompt_pwd)$(git_prompt_info) %(!.%{$fg_bold[red]%}#.%{%F{$HOST_PROMPT_COLOR}%B%}❯)${lreturn_status}%{$reset_color%} '

  # ZSH_THEME_GIT_PROMPT_PREFIX=" %{%F{69}%}[%{$fg[cyan]%}git%{$reset_color%}:%{$fg[red]%}"
  ZSH_THEME_GIT_PROMPT_PREFIX=" %{%F{202}%}["
  ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='$(vi_mode_prompt_info)${return_status}$(git_prompt_status)%{$reset_color%}${SSH_CONNECTION:+"[%F{9}%n%f%F{7}@%f%F{3}%m%f]"}'

  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
  ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
else 
  MODE_INDICATOR="❮❮❮"
  local return_status="%(?::⏎)"
  
  PROMPT='%c$(git_prompt_info) %(!.#.❯) '

  ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='$(vi_mode_prompt_info)${return_status}$(git_prompt_status)'

  ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
  ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
  ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi

# vim: ts=2 sts=2 sw=2 expandtab
