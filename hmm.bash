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
    local cur prev opts base opts actions
    cur="${COMP_WORDS[COMP_CWORD]}"
    PREV_CWORD=${COMP_CWORD}-1
    prev="${COMP_WORDS[$PREV_CWORD]}"
    HMM=$( which hmm )
    HMM_PATH=$( $HMM --path )
    TARDIR="$HMM_PATH/.hmm/*"
    COMPREPLY=()

    #
    #  The basic options we'll complete.
    #
    opts=" \
    ###MINIFY-ACTIONS### \
    -h --help \
    -a --actions \
    -i --info \
    -f --force \
    -V --verbose \
    -c --config \
    -H --home \
    -p --port \
    -v --vol \
    -e --env \
    -n --name \
    -R --registry \
    -B --base \
    -T --tag \
    -P --parent \
    -u --user \
    -C --control \
    --path"

    #
    #  Complete the arguments to some of the basic commands.
    #
    if [[ "$prev" == -* ]]; then
        case "$prev" in
            "-c"|"--config")
                _filedir '@(hmm)'
                return 0
                ;;
            *)
                ;;
        esac
    fi

    actions=$(for x in $TARDIR; do echo $(basename ${x%}); done)
    COMPREPLY=( $( compgen -W "$opts $actions" -- "$cur" ) )
}
complete -F _hmm $filenames hmm