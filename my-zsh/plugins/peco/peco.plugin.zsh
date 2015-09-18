if which peco &> /dev/null; then
	typeset -ga ZSH_PECO_HELPERS
	typeset -ga chpwd_functions

	CD_HISTORY_FILE=${HOME}/.cd_history
	function chpwd_record_history() {
		echo $PWD >> ${CD_HISTORY_FILE}
	}
	chpwd_functions+=chpwd_record_history
	
	
	if which tac &> /dev/null; then
		_PECO_TAC="tac"
	elif  which gtac &> /dev/null; then
		_PECO_TAC="gtac"
	else
		_PECO_TAC="tail -r"
	fi

	function _ptac() {
		eval $_PECO_TAC
	}

	
	function _percol_get_destination_from_history() {
		sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
			sed -e "s/^[ ]*[0-9]*[ ]*//" | \
			sed -e s"/^${HOME//\//\\/}/~/"| \
			peco | xargs echo
	}
	
	function peco_cd_history() {
		local dst=$(_percol_get_destination_from_history)
		[ -n $dst ] && cd ${dst/#\~/${HOME}}
		zle reset-prompt
	}

	function peco_cmd_history() {
		BUFFER=$(fc -l -n 1 | _ptac | peco --layout=bottom-up --query="$LBUFFER")
		CURSOR=$#BUFFER         # move cursor
		zle -R -c               # refresh
	}
	
	local helper; for helper in $ZSH_PECO_HELPERS; do
		if [[ $helper == "cmd-history" ]]; then
			zle -N peco_cmd_history
			bindkey '^R' peco_cmd_history
		elif [[ $helper == "cd-history" ]]; then
			zle -N peco_cd_history
			bindkey '^x' peco_cd_history
		fi
	done

fi
