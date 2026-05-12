# Auto start Xray in Codespaces terminal
bash /workspaces/g2ray/.devcontainer/start.sh >/dev/null 2>&1 || true

# Show latest connection info
if [ -f /workspaces/g2ray/.devcontainer/connection.txt ]; then
  echo
  cat /workspaces/g2ray/.devcontainer/connection.txt
  echo
fi
