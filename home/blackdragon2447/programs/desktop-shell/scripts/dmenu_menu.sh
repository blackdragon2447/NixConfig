menus=(
	Programs
	Screenshot
	# Calc
	# Pass
	# Bluetooth
	Logout
)

menus+=("Exit")

choice=$(printf '%s\n' "${menus[@]}" | $dmenu -i)

if [[ "$choice" == "Exit" ]]
then
	exit 1

elif [ "$choice" ]
then
	case $choice in
		'Programs')
			$runmenu
			;;
		'Screenshot')
			menu_screenshot
			;;
		'Calc')
			rofi -show calc -modi calc -no-show-match -no-sort
			;;
		'Pass')
			passmenu 
			;;
		'Bluetooth')
			rofi-bluetooth
			;;
		'Logout')
			menu_logout
			;;
	esac
fi
