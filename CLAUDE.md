# silkreader-download

Installer und Download-Infos für Silkreader. Die App selbst liegt im Repo `silkreader`.

- `install-mac.sh`: Mac-Installer. Kein Apple-Developerkonto: Probleme mit Code im Skript lösen, nicht mit Signierung.
- Texte für Nutzer auf Deutsch, einfach und beruhigend. Datenschutz offen erklären: Nur Markiertes wird kopiert, nichts wird verschickt.
- Ein Hook in `.claude/settings.json` prüft nach jeder Änderung die Syntax von `.sh`-Dateien mit `bash -n`.

## Möglichst wenig Code (nach Ponytail)
- Erst den betroffenen Code lesen und den Ablauf verstehen, dann entscheiden.
- Vor neuem Code der Reihe nach prüfen: Wird es überhaupt gebraucht? Gibt es das schon im Projekt? Kann die Shell oder ein vorhandenes Werkzeug es selbst? Geht es in einer Zeile? Erst dann das Kleinste schreiben, das funktioniert.
- Keine neuen Abhängigkeiten ohne Rückfrage.
- Nie an Sicherheit, Datenschutz, Datenverlust-Schutz oder Barrierefreiheit sparen.
- Logik mit Verzweigung, Schleife oder Parser bekommt einen kleinen Test.
