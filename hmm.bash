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

signature() {
	printf "\n$(tput bold)$(tput setaf 4)-[$(tput setaf 6)CFZ$(tput setaf 4)]- $(tput setaf 1)H$(tput sgr0)eadworks $(tput setaf 1)M$(tput sgr0)achination $(tput setaf 1)M$(tput sgr0)anagement$(tput sgr0) - v$VERSION"
}

get_actions() {
    TARGET=$1
    RESULT=""
#    echo $TARGET
    for ACTION_FILE in ${TARGET}/*
    do
        BASE_ACTION=${ACTION_FILE/$TARGET\//}
#        echo $BASE_ACTION
        if [[ -f ${ACTION_FILE} ]]; then
        	[[ ${RESULT} = "" ]] || RESULT+=" "
        	RESULT+="${BASE_ACTION}"
        fi

        if [[ -d ${ACTION_FILE} ]]; then
            for SUB_ACTION_FILE in ${ACTION_FILE}/*
            do
                BASE_SUB_ACTION=${BASE_ACTION}-${SUB_ACTION_FILE/$ACTION_FILE\//}
#                echo $BASE_SUB_ACTION
                [[ ${RESULT} = "" ]] || RESULT+=" "
                RESULT+="${BASE_SUB_ACTION}"
            done
        fi
    done
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
###MINIFY-ACTIONS###
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
    RETURN_HOLDER=${opts/###MINIFY-ACTIONS###/}
    return
}

_hmm()
{
#    signature
    local cur prev opts actions
    cur="${COMP_WORDS[COMP_CWORD]}"
    PREV_CWORD=${COMP_CWORD}-1
    prev="${COMP_WORDS[$PREV_CWORD]}"
    HMM=$( which hmm )
    HMM_PATH=$( ${HMM} --path )
    PLUGDIR="$HMM_PATH/.hmm/"
#    echo "PLUGDIR: $PLUGDIR"
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
        cd ${CURDIR}
        COMPREPLY=( $( compgen -W "$actions" -- "$cur" ) )
    fi
}
#complete -F _hmm ${filenames} hmm
complete -F _hmm hmm
