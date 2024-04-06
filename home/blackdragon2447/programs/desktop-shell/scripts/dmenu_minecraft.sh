#!/usr/bin/env zsh

instances=($(exa -la /home/blackdragon2447/.local/share/multimc/instances | grep -v 'inst\|_MMC_TEMP' | awk '{print $7}'))
names=()

for i in "${instances[@]}"
do
	name=$(cat "$HOME/.local/share/multimc/instances/${i}/instance.cfg" | grep name | sed -e "s/name=//")
	names+=("$name")
done

names+=("Exit")

choice=$(printf '%s\n' "${names[@]}" | dmenu -l ${#names[@]} -sb "#eeeeee" -sf "#3b3b3b" -nb "#3b3b3b" -nf "#eeeeee" -fn "Hack Nerd Font Mono:pixelsize=12" -p 'Launch Minecraft')

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
	multimc -l "$instance" &
fi
