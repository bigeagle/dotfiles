ZSH=$HOME/.my-zsh

case "$TERM" in
		xterm)
            export TERM=xterm-256color
            ;;
		screen)
            export TERM=screen-256color
            ;;
		dumb)export PROMPT_COMMAND="";;
esac

ZSH_THEME="bigeagle"
DEFAULT_USER="bigeagle"

plugins=(git fabric vi-mode-custom zsh-syntax-highlighting)

source $ZSH/my-zsh.sh
