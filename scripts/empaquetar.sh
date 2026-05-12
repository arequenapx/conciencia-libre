#!/bin/bash
VERSION=$(grep '"version":' manifest.json | sed -E 's/.*"([^"]+)".*/\1/')
OUTPUT="conciencia-libre-v$VERSION.zip"

echo "📦 Empaquetando versión $VERSION..."
rm -f *.zip
zip -r $OUTPUT . -x "*.git*" -x "scripts/*" -x "*.sh" -x "presentacion*" -x "fuente_datos.json" -x ".DS_Store"
echo "✅ Archivo generado: $OUTPUT"
