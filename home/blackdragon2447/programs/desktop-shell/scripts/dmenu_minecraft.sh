instances=($(eza -la /home/blackdragon2447/.local/share/PrismLauncher/instances | grep -v 'inst\|MMC_TEMP\|LAUNCHER_TEMP\|.tmp' | awk '{print $7}'))
names=()

for i in "${instances[@]}"
do
	name=$(cat "$HOME/.local/share/PrismLauncher/instances/${i}/instance.cfg" | grep name | sed -e "s/name=//")
	names+=("$name")
done

names+=("Exit")

choice=$(printf '%s\n' "${names[@]}" | $dmenu -i )

insLen=${#instances[@]}

if [[ $choice == "" ]]
then 
	choice="Exit"
fi

if [[ $choice != "Exit" ]]
then
	for (( i=0; i<=insLen; i++)) 
	do
		echo $choice
		if [[ ${names[$i]} == "$choice" ]]
		then
			echo $i
			instance=${instances[$i]}
		fi
	done 
	prismlauncher -l "$instance" &
fi
