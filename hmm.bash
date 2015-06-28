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
PLUGDIR=""
CURDIR=$( pwd )

get_actions() {
    TARGET=$1
    RESULT=""
    cd ${TARGET}/
    for ACTION_FILE in *
    do
        if [[ -f ${ACTION_FILE} ]]; then
        	[[ ${RESULT} = "" ]] || RESULT+=" "
        	RESULT+="${ACTION_FILE}"
        fi

        if [[ -d ${ACTION_FILE} ]]; then
            cd ${ACTION_FILE}
            for SUB_ACTION_FILE in *
            do
                [[ ${RESULT} = "" ]] || RESULT+=" "
                RESULT+="${ACTION_FILE}-${SUB_ACTION_FILE}"
			done
			cd ..
		fi
    done
    cd ${CURDIR}
    RETURN_HOLDER=${RESULT}
    return
}

short_opts()
{
    #
    #  The basic options we'll complete.
    #
    opts=" \
    -h \
    -i \
    -a \
    -U \
    -f \
    -V \
    -H \
    -c \
    -p \
    -l \
    -v \
    -e \
    -n \
    -R \
    -r \
    -B \
    -T \
    -t \
    -P \
    -o \
    -L \
    -u \
    -C";
    RETURN_HOLDER=${opts}
    return
}

long_opts()
{
    #
    #  The basic options we'll complete.
    #
    opts=" \
    --help \
    --info \
    --actions \
    --update \
    --force \
    --verbose \
    --home \
    --config \
    --port \
    --link \
    --vol \
    --env \
    --name \
    --registry \
    --run \
    --base \
    --tag \
    --test \
    --parent \
    --host \
    --platform \
    --user \
    --control \
    --upgrade \
    --path";
    RETURN_HOLDER=${opts}
    return
}

_hmm()
{
    local cur prev opts actions
    cur="${COMP_WORDS[COMP_CWORD]}"
    PREV_CWORD=${COMP_CWORD}-1
    prev="${COMP_WORDS[$PREV_CWORD]}"
    HMM=$( which hmm )
    HMM_PATH=$( ${HMM} --path )
    PLUGDIR="$HMM_PATH/.hmm/"
    COMPREPLY=()

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

    short_opts
    SHORT=$RETURN_HOLDER
    long_opts
    LONG=$RETURN_HOLDER
    #    actions=$(for x in $PLUGDIR; do echo $(basename ${x%}); done)
    if [[ ${COMP_WORDS[COMP_CWORD]} == "-" ]]; then
        COMPREPLY=( $( compgen -W "$SHORT $LONG" -- "$cur" ) )
    elif [[ ${COMP_WORDS[COMP_CWORD]} == "--" ]]; then
        COMPREPLY=( $( compgen -W "$LONG" -- "$cur" ) )
    else
        get_actions "${PLUGDIR}"
        actions=${RETURN_HOLDER}
        COMPREPLY=( $( compgen -W "$actions" -- "$cur" ) )
    fi
}
#complete -F _hmm ${filenames} hmm
complete -F _hmm hmm