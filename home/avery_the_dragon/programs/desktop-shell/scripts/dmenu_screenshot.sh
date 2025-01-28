maim_dir=/home/avery_the_dragon/Pictures/screenshots

get_timestamp() {
  date '+%Y%m%d-%H%M%S'
}

_file_type=""
# Makes sure the directory exists.
mkdir -p "${maim_dir}"

declare -a modes=(
	"Fullscreen"
	"Selected region"
)

target=$(printf '%s\n' "${modes[@]}" | $dmenu -p 'Take screenshot of' "$@") || exit 1
case "$target" in
  'Fullscreen')
    _file_type="full"
  ;;
  'Selected region')
    _file_type="region"
  ;;
  *)
    exit 1
  ;;
esac
destination=( "File" "Clipboard" "Both" )

dest=$(printf '%s\n' "${destination[@]}" | $dmenu -p 'Destination' "$@" ) || exit 1

sleep 1

case "$dest" in
  'File')
    # shellcheck disable=SC2086,SC2154
	grim -g "$(slurp)" -o "${maim_dir}/${_file_type}-$(get_timestamp).png"
    notify-send "Saved Screenshot" "${maim_dir}/${_file_type}-$(get_timestamp).png"
  ;;
  'Clipboard')
    # shellcheck disable=SC2086
    grim -g "$(slurp)" - | wl-copy -t image/png
    notify-send "Saved Screenshot" "Clipboard"
  ;;
  'Both')
    # shellcheck disable=SC2086
    grim -g "$(slurp)" - | tee "${maim_dir}/${_file_type}-$(get_timestamp).png" | wl-copy clipboard -t image/png
    notify-send "Saved Screenshot" "${maim_dir}/${_file_type}-$(get_timestamp).png And Clipboard"
  ;;
  *)
    exit 1
  ;;
esac
