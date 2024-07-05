name=$(niri msg -j focused-window | jq -r .title)
app_id=$(niri msg -j focused-window | jq -r .app_id)
echo -e "{\"text\":\"${name}\", \"tooltip\":\"App id: ${app_id}\"}"
