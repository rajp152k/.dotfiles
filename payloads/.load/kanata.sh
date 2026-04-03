#!/bin/bash
set -e

echo "=== Killing stale processes ==="
sudo pkill -f kanata 2>/dev/null || true
sudo pkill -f Karabiner-VirtualHIDDevice-Daemon 2>/dev/null || true
sleep 1

echo "=== Starting Karabiner daemon as root (background) ==="
sudo '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon' &
DAEMON_PID=$!
sleep 3
echo "=== Karabiner daemon running (PID: $DAEMON_PID) ==="

echo "=== Starting kanata as user (NOT root) ==="
echo "=== Ghostty's Input Monitoring permission will be inherited ==="
sudo /opt/homebrew/bin/kanata --cfg /Users/nilenso/.config/kanata/config.kbd --nodelay
