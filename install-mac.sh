#!/bin/bash
# Silkreader für macOS installieren – ohne Sicherheitswarnung.
# Aufruf im Terminal:
#   curl -fsSL https://raw.githubusercontent.com/Sebbilore/silkreader-download/main/install-mac.sh | bash
# Lädt die neueste Mac-Version (Apple-Chip oder Intel) und legt sie in den Ordner Programme.
set -euo pipefail

echo "🕷  Silkreader wird installiert …"

case "$(uname -m)" in
  arm64) arch=arm64 ;;
  *)     arch=x64 ;;
esac

# Neueste Mac-Version im Download-Repo finden
url=$(curl -fsSL "https://api.github.com/repos/Sebbilore/silkreader-download/releases?per_page=30" \
  | grep -o "\"browser_download_url\": *\"[^\"]*-mac-${arch}\.dmg\"" \
  | head -1 | sed 's/.*"\(https[^"]*\)"$/\1/')
if [ -z "$url" ]; then echo "Keine Mac-Version gefunden. Bitte später noch einmal versuchen."; exit 1; fi
echo "   Version: $(basename "$url")"

tmp=$(mktemp -d)
trap 'hdiutil detach "$tmp/vol" -quiet 2>/dev/null || true; rm -rf "$tmp"' EXIT
curl -fL --progress-bar "$url" -o "$tmp/silkreader.dmg"

hdiutil attach "$tmp/silkreader.dmg" -nobrowse -quiet -mountpoint "$tmp/vol"
app=$(find "$tmp/vol" -maxdepth 1 -name "*.app" | head -1)
if [ -z "$app" ]; then echo "In der Datei war keine App."; exit 1; fi

# Laufende Spinne beenden und alte Version ersetzen
osascript -e 'quit app "Silkreader"' 2>/dev/null || true
sleep 1
rm -rf "/Applications/Silkreader.app"
cp -R "$app" /Applications/
xattr -dr com.apple.quarantine "/Applications/Silkreader.app" 2>/dev/null || true

echo "✅ Fertig. Silkreader startet jetzt."
echo "   Damit die Spinne markierten Text lesen kann: Systemeinstellungen → Datenschutz & Sicherheit → Bedienungshilfen → Silkreader einschalten."
open "/Applications/Silkreader.app"
