# kanata

Cross-platform keyboard remapper — replaces `mouseless` on macOS, works on Linux too.

Config lives at `~/.config/kanata/config.kbd` (managed via GNU Stow).

---

## macOS Setup

Kanata on macOS needs the **Karabiner-DriverKit-VirtualHIDDevice** driver to
intercept keyboard input and emit mouse events. Without it, key remapping works
but mouse movement/clicks will not.

### 1. Install the driver

```sh
brew install --cask karabiner-elements
```

> This installs the full Karabiner-Elements app which bundles the required
> virtual HID device driver. You don't need to use Karabiner-Elements itself —
> just the driver it installs.

After installation:

```sh
# Activate the system extension
/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
```

Then go to **System Settings → Privacy & Security → Security** and click
**Allow** for software from `pqrs.org`.

Verify the driver is active:

```sh
systemextensionsctl list | grep pqrs
```

### 2. Grant Input Monitoring permission

When you first run kanata, macOS will prompt for **Input Monitoring** access.
Allow it in **System Settings → Privacy & Security → Input Monitoring**.

### 3. Restrict to specific keyboards (optional)

By default kanata intercepts all keyboards. To restrict it, find your keyboard
name with:

```sh
kanata --list
```

Then uncomment and fill in `macos-dev-names-include` in `config.kbd`.

---

## Linux Setup

### Permissions (avoid running as root)

```sh
sudo usermod -aG input $USER
# Create uinput group if it doesn't exist
sudo groupadd uinput
sudo usermod -aG uinput $USER
# Allow uinput access
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' \
  | sudo tee /etc/udev/rules.d/99-uinput.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
```

Log out and back in for group changes to take effect.

---

## Running kanata

### Manually (for testing)

```sh
kanata --cfg ~/.config/kanata/config.kbd
```

### As a launchd service (macOS)

```sh
# Install the plist (see kanata.plist in this directory)
cp ~/Library/LaunchAgents/org.kanata.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/org.kanata.plist
```

### As a systemd user service (Linux)

```sh
# Install the service file
cp ~/.config/systemd/user/kanata.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now kanata
```

---

## Layer Reference

```
initial (default)
  z         → tap: z  |  hold (300ms): toggle mouse layer
  ralt      → momentary arrows layer (while held)

mouse (toggled, stays on until q)
  i/k/j/l   → move up/down/left/right     (matches mouseless axes)
  p/n       → scroll up/down
  f/d/s     → left/middle/right click
  lalt      → hold for fast speed  (4×)
  e         → hold for slow speed  (0.3×)
  caps      → hold for very slow   (0.1×)
  q         → exit back to initial
  r         → live reload config

arrows (while ralt held)
  h/j/k/l   → left/down/up/right
  q         → esc
  w         → backspace
  r         → delete
  v         → enter
```

---

## Stow

```sh
cd ~/.dotfiles && stow kanata
```
