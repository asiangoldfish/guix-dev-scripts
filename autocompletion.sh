# Bash completion for systole-dev

_systole_dev_completion() {
    local cur prev commands opts build_opts shell_pkgs
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    commands="help build shell generate-config edit-config"
    build_opts="--default-options --keep-failed --keep-going --no-grafts --rounds=1 --verbosity=3"
    build_pkgs="help slicer-5.8"
    shell_pkgs="help slicer-5.8"

    case "${COMP_WORDS[1]}" in
        build)
            # Complete build options or package names
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                # Suggest package names here (statically or dynamically)
                COMPREPLY=( $(compgen -W "${build_pkgs}" -- "$cur") )
            else
                COMPREPLY=( $(compgen -W "${build_opts}" -- "$cur") )
            fi
            ;;
        shell)
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                COMPREPLY=( $(compgen -W "${shell_pkgs}" -- "$cur") )
            else
                COMPREPLY=()  # No more arguments allowed
            fi
            ;;
        help|generate-config|edit-config)
            # No further completion needed
            ;;
        *)
            # Complete main commands
            COMPREPLY=( $(compgen -W "${commands}" -- "$cur") )
            ;;
    esac
}

complete -F _systole_dev_completion systole-dev
