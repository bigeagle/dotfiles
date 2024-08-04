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

plugins=(git zsh-syntax-highlighting)

_prepend_path () {
    for pentry in "$@"
    do
        case ":$PATH:" in
            (*":$pentry:"*)  ;;
            (*) export PATH="$pentry:$PATH"  ;;
        esac
    done
}

# initialize path
export PATH=""
for _pathfile in /etc/paths.d/*; do
    while read _path; do
        _prepend_path $_path
    done < $_pathfile
done
while read _path; do
    _prepend_path $_path
done < /etc/paths

source $ZSH/my-zsh.sh
#
source ~/.zshrc.local
