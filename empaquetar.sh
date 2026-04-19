#!/bin/bash

echo "📦 [Conciencia Libre] Iniciando fase de Empaquetado y Producción..."

# 1. Crear el archivo .gitignore para GitHub
cat << 'EOF' > .gitignore
# Archivos del sistema operativo
.DS_Store
Thumbs.db

# Entornos virtuales de Python (por si en el futuro los usas)
venv/
env/
__pycache__/

# Archivos de empaquetado de producción
*.zip
EOF
echo "✅ .gitignore generado."

# 2. Crear el archivo de Licencia (GNU GPLv3 - Versión Resumida Estándar)
cat << 'EOF' > LICENSE
                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
EOF
echo "⚖️ Licencia GPLv3 generada."

# 3. Empaquetar la extensión para la tienda de navegadores (Producción)
NOMBRE_ZIP="conciencia_libre_v2.5.0_produccion.zip"

echo "🧹 Limpiando empaquetados anteriores..."
rm -f $NOMBRE_ZIP

echo "🗜️ Comprimiendo archivos necesarios para la extensión..."
# Solo incluimos los archivos estrictamente necesarios para el navegador
zip -r $NOMBRE_ZIP manifest.json src/ icons/ README.md LICENSE -q

if [ -f "$NOMBRE_ZIP" ]; then
    echo "🎉 ¡ÉXITO! Se ha creado el archivo: $NOMBRE_ZIP"
    echo "👉 Este es el archivo exacto que debes subir a la Chrome Web Store o enviar a tu profesor."
else
    echo "❌ Error al crear el archivo .zip. Asegúrate de tener 'zip' instalado en tu terminal."
fi