#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

python -m pygbag --build --title "Rose — JIN2" --package "rose-jin2" .
rm -rf site
mkdir -p site/game

cp index.html site/index.html
if [ ! -d build/web ]; then
  echo "No se encontró build/web. Revisa la salida de Pygbag." >&2
  exit 1
fi
cp -a build/web/. site/game/

echo
echo "Sitio preparado en: $ROOT/site"
echo "Prueba: cd site && python -m http.server 8080"
