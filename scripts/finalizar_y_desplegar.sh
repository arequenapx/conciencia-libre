#!/bin/bash

# Configuración de versión
VERSION="2.6.0"
REPO_USER="arequenapx" # Asegúrate de que este es tu usuario de GitHub

echo "===================================================="
echo "🚀 [Conciencia Libre] Iniciando Despliegue Dinámico v$VERSION"
echo "===================================================="

# 1. LIMPIEZA DE SCRIPTS ANTIGUOS
echo "🧹 Limpiando scripts de bloques antiguos..."
rm -f scripts/genera_bd[1-9]*.sh scripts/genera_bd10.sh 2>/dev/null
rm -f scripts/generar_bd_bloque*.py 2>/dev/null
rm -rf scripts/__pycache__ 2>/dev/null

# 2. CREACIÓN DE FUENTE DE DATOS DESACOPLADA
echo "📄 Creando fuente_datos.json (Base Maestra)..."
if [ ! -f "scripts/fuente_datos.json" ]; then
cat << 'EOF' > scripts/fuente_datos.json
{
  "adobe.com/products/photoshop": {
    "privativo": "Adobe Photoshop",
    "alternativas": [
      {"nombre": "GIMP", "licencia": "GPLv3", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor profesional de imágenes.", "por_que": ["Totalmente gratuito.", "Gran soporte de plugins."], "url": "https://www.gimp.org/"}
    ]
  }
}
EOF
fi

# 3. UNIFICACIÓN DEL SCRIPT DE PYTHON
echo "🐍 Unificando lógica en generar_bd.py..."
cat << 'EOF' > scripts/generar_bd.py
import json, os, urllib.request, urllib.parse, ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

dir_actual = os.path.dirname(os.path.abspath(__file__))
ruta_fuente = os.path.join(dir_actual, "fuente_datos.json")
ruta_logos = os.path.join(dir_actual, "../src/data/logos/")
ruta_json_final = os.path.join(dir_actual, "../src/data/alternativas.json")

os.makedirs(ruta_logos, exist_ok=True)

with open(ruta_fuente, 'r', encoding='utf-8') as f:
    datos = json.load(f)

headers = {'User-Agent': 'Mozilla/5.0'}
for web, info in datos.items():
    for alt in info["alternativas"]:
        nombre_logo = f"{alt['nombre'].lower().replace(' ', '_').replace('+', '')}.png"
        ruta_local_logo = os.path.join(ruta_logos, nombre_logo)
        alt["icono"] = f"src/data/logos/{nombre_logo}"
        
        if not os.path.exists(ruta_local_logo):
            dominio = urllib.parse.urlparse(alt["url"]).netloc
            try:
                req = urllib.request.Request(f"https://logo.clearbit.com/{dominio}", headers=headers)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                    f.write(r.read())
            except: pass

with open(ruta_json_final, 'w', encoding='utf-8') as f:
    json.dump(datos, f, indent=2, ensure_ascii=False)
print("✅ Base de datos unificada generada.")
EOF

python3 scripts/generar_bd.py

# 4. CONFIGURACIÓN DEL BACKGROUND (Service Worker)
echo "⚙️ Configurando background.js (Sync remota)..."
mkdir -p src/background
cat << 'EOF' > src/background/background.js
const GITHUB_DB_URL = "https://raw.githubusercontent.com/arequenapx/conciencia-libre/main/src/data/alternativas.json";

chrome.runtime.onInstalled.addListener(() => {
  fetch(GITHUB_DB_URL, { cache: "no-store" })
    .then(r => r.json())
    .then(data => chrome.storage.local.set({ "db_remota": data }))
    .catch(e => console.log("Usando DB local."));
});
EOF

# 5. ACTUALIZACIÓN DE MANIFEST Y VERSIÓN
echo "📝 Actualizando manifest.json a v$VERSION..."
python3 -c "
import json
with open('manifest.json', 'r') as f: m = json.load(f)
m['version'] = '$VERSION'
if 'permissions' not in m: m['permissions'] = []
if 'storage' not in m['permissions']: m['permissions'].append('storage')
m['background'] = {'service_worker': 'src/background/background.js'}
with open('manifest.json', 'w') as f: json.dump(m, f, indent=2)
"

# 6. EMPAQUETADO PARA TIENDAS
echo "🗜️ Creando ZIP de distribución..."
mkdir -p dist
zip -r dist/conciencia_libre_v$VERSION.zip manifest.json src/ icons/ -x "*.DS_Store"

# 7. GITHUB: CONTRIBUCIÓN Y SUBIDA
echo "🌐 Configurando GitHub y subiendo cambios..."
mkdir -p .github/ISSUE_TEMPLATE
cat << 'EOF' > .github/ISSUE_TEMPLATE/sugerir.md
---
name: Sugerir alternativa
about: Ayúdanos a crecer
title: '[SUGERENCIA] Software'
---
**Software Privativo:**
**Alternativa Libre:**
**URL:**
EOF

git add .
git commit -m "🚀 v$VERSION: Unificación de BD, modo dinámico y herramientas de contribución"
git push origin main

echo "===================================================="
echo "🎉 ¡LISTO! Extensión v$VERSION desplegada."
echo "===================================================="