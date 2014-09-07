#!bash
#
# bash completion file for core hmm helpers
#
# To enable the completions either:
#  - place this file in /etc/bash_completion.d
#  or
#  - copy this file and add the line below to your .bashrc after
#    bash completion features are loaded
#     . hmm.bash
#

_hmm()
{
    local cur
    local WHICH
    local TARDIR
    local HMM_PATH

    HMM=$( which hmm )
    HMM_PATH=$( hmm --path )
    TARDIR="$HMM_PATH/.hmm/*"
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=($( compgen -W "$(for x in $TARDIR; do echo $(basename ${x%}); done)" -- $cur))
}

complete -F _hmm hmm
