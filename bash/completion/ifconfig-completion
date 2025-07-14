_ifconfig_completions() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}

    if [[ "${prev}" == "ifconfig" ]]; then
        COMPREPLY=( $(compgen -W "$(ifconfig -a | awk '/^[a-zA-Z0-9]/ {print $1}' | cut -d':' -f1)" -- "${cur}") )
    else
    	COMPREPLY=( $(compgen -f -- "${cur}") )
    fi

}
complete -F _ifconfig_completions ifconfig
