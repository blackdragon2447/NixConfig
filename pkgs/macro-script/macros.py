import os

from evdev import InputDevice, UInput, categorize, ecodes

dev = InputDevice('/dev/input/by-id/usb-MOSART_Semi._2.4G_Keyboard_Mouse-event-kbd')
dev.grab()

def pressKey(keycode):
    ui = UInput()
    ui.write(ecodes.EV_KEY, keycode, 1)
    ui.write(ecodes.EV_KEY, keycode, 0)
    ui.syn()
    ui.close()

for event in dev.read_loop():
  print("looping")
  if event.type == ecodes.EV_KEY:
      print("key pressed")
      key = categorize(event)
      if key.keystate == key.key_down:
          if key.keycode == 'KEY_NUMLOCK':
              os.system('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')
          elif key.keycode == 'KEY_KPSLASH':
              os.system('wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+')
          elif key.keycode == 'KEY_KPASTERISK':
              os.system('wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-')
          elif key.keycode == 'KEY_BACKSPACE':
              os.system('$HOME/scripts/leftwm/dmenu_screenshot.sh')
          elif key.keycode == 'KEY_KP7':
              os.system('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')
          elif key.keycode == 'KEY_KP8':
              os.system('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+')
          elif key.keycode == 'KEY_KP9':
              os.system('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')
          elif key.keycode == 'KEY_KPMINUS':
              pressKey(ecodes.KEY_F1)
              pressKey(ecodes.KEY_F2)
              pressKey(ecodes.KEY_F1)
          elif key.keycode == 'KEY_KP4':
              os.system("echo kp_4")
          elif key.keycode == 'KEY_KP5':
              os.system("echo kp_5")
          elif key.keycode == 'KEY_KP6':
              os.system("echo kp_6")
          elif key.keycode == 'KEY_KPPLUS':
              os.system('echo kp_plus')
          elif key.keycode == 'KEY_KP1':
              os.system('echo kp_1')
          elif key.keycode == 'KEY_KP2':
              os.system('echo kp_2')
          elif key.keycode == 'KEY_KP3':
              os.system('echo kp_3')
          elif key.keycode == 'KEY_KPENTER':
              os.system('playerctl -p vlc play-pause')
          elif key.keycode == 'KEY_KP0':
              os.system('obs-cli recording toggle')
          elif key.keycode == 'KEY_KPDOT':
              os.system('playerctl -a pause')
              
print("done")
