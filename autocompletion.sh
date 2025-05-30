# Bash completion for systole-dev

SYSTOLE_DEV_CONFIG="$HOME/.config/guix-dev-scripts/systole-dev.cfg"
BASEDIR="$(dirname "$0")"

if [ -f "$SYSTOLE_DEV_CONFIG" ]; then
    source "$SYSTOLE_DEV_CONFIG"
fi

_systole_dev_completion() {
    local cur prev commands opts build_opts shell_pkgs
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    commands="help build shell generate-config edit-config install"
    build_opts="--default-options --keep-failed --keep-going --no-grafts --rounds=1 --verbosity=3"
    build_pkgs="help $(grep -r "define-public" "$GUIX_SYSTOLE_DIR" | awk '{print $2}')"
    shell_pkgs="help slicer-5.8"

    case "${COMP_WORDS[1]}" in
        build)
            # Complete build options or package names
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                # Suggest package names here (statically or dynamically)
                COMPREPLY=( $(compgen -W "${build_pkgs[@]}" -- "$cur") )
            else
                COMPREPLY=( $(compgen -W "${build_opts}" -- "$cur") )
            fi
            ;;
        install)
            # Complete build options or package names
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                COMPREPLY=( $(compgen -W "${build_pkgs[@]}" -- "$cur") )
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
