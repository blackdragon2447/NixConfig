mapfile -t list < <(niri msg -j workspaces | jq -r "sort_by(.idx) | .[] | select(.output == \"$1\") | \"\(.name) \(.is_active)\"")

workspace_str=" " 
# for ws in $(niri msg -j workspaces | jq ".[] | select(.output == \"$1\") | \"\(.name) \(.is_active)\""); do
for ((i = 0; i < ${#list[@]}; i++)); do
# for ws in $list; do
	ws="${list[$i]}"
	workspace_str="$workspace_str$(echo $ws | awk "{if (\$2==\"true\") 
		{ 
			if (\$1==\"null\") {print \"<big><span color='$2'>  </span></big>\"} 
			else { print \"<big><span color='$2'>\"\$1\"  </span></big>\" } 
		} else { 
			if (\$1==\"null\") {print \"<small><span>  </span></small>\"} 
			else { print \"<small><span>\"\$1\"  </span></small>\" } }
		}")"
done
name=$(niri msg -j workspaces | jq -r "sort_by(.idx) | .[] | select(.output == \"$1\" and .is_active == true) | .name")
echo -e "{\"text\":\"${workspace_str}\", \"tooltip\":\"Active workspace name: ${name}\"}"
