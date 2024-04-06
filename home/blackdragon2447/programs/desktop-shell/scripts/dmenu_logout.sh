declare -a optionsList=(
	"Lock screen"
	"Logout"
	"Reboot"
	"Shutdown"
	"Suspend"
	"Hibernate"
	"Exit"
)

choice=$(printf '%s\n' "${optionsList[@]}" | $dmenu -p 'Shutdown menu' "${@}")

case $choice in
    'Logout')
        if [[ "$(echo -e "No\nYes" | $dmenu -p "${choice}?" "${@}" )" == "Yes" ]]; then
            loginctl kill-session $XDG_SESSION_ID
        else
            exit 0
        fi
        ;;
    'Lock screen')
		$lock
        ;;
    'Reboot')
        if [[ "$(echo -e "No\nYes" | $dmenu -p "${choice}?" "${@}" )" == "Yes" ]]; then
			systemctl reboot
        else
            exit 0
        fi
        ;;
    'Shutdown')
        if [[ "$(echo -e "No\nYes" | $dmenu -p "${choice}?" "${@}" )" == "Yes" ]]; then
			systemctl shutdown now
        else
            exit 0
        fi
        ;;
    'Suspend')
        if [[ "$(echo -e "No\nYes" | $dmenu -p "${choice}?" "${@}" )" == "Yes" ]]; then
			$lock
            systemctl hybrid-sleep
        else
            exit 0
        fi
        ;;
    'Hibernate')
        if [[ "$(echo -e "No\nYes" | $dmenu -p "${choice}?" "${@}" )" == "Yes" ]]; then
			$lock
            systemctl hibernate
          else
            exit 0
        fi
        ;;
    'Exit')
        exit 0
    	;;
    # It is a common practice to use the wildcard asterisk symbol (*) as a final
    # pattern to define the default case. This pattern will always match.
    *)
        exit 0
    	;;
esac
