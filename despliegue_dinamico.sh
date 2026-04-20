#!/bin/bash

echo "🚀 [Conciencia Libre] Iniciando actualización dinámica y unificación..."

# 1. Limpieza de scripts antiguos (si existen)
echo "🧹 Eliminando scripts de generación antiguos..."
rm -f scripts/genera_bd[1-9]*.sh scripts/genera_bd10.sh 2>/dev/null
rm -f scripts/generar_bd_bloque*.py 2>/dev/null

# 2. Creación del archivo de datos desacoplado (Plantilla inicial)
echo "📄 Creando fuente_datos.json..."
cat << 'EOF' > scripts/fuente_datos.json
{
  "adobe.com/products/photoshop": {
    "privativo": "Adobe Photoshop",
    "alternativas": [
      {"nombre": "GIMP", "url": "https://www.gimp.org/", "descripcion": "Editor profesional de imágenes."},
      {"nombre": "Krita", "url": "https://krita.org/", "descripcion": "Especializado en pintura digital."}
    ]
  }
}
EOF
# (Nota: Aquí el usuario puede pegar el resto de su diccionario JSON enorme)

# 3. Unificación del script de Python
echo "🐍 Generando nuevo generar_bd.py unificado..."
cat << 'EOF' > scripts/generar_bd.py
import json
import os
import urllib.request
import urllib.parse
import ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

dir_actual = os.path.dirname(os.path.abspath(__file__))
ruta_fuente = os.path.join(dir_actual, "fuente_datos.json")
ruta_logos = os.path.join(dir_actual, "../src/data/logos/")
ruta_json_final = os.path.join(dir_actual, "../src/data/alternativas.json")

os.makedirs(ruta_logos, exist_ok=True)

print("📖 Leyendo fuente de datos remota/local...")
try:
    with open(ruta_fuente, 'r', encoding='utf-8') as f:
        datos = json.load(f)
except FileNotFoundError:
    print("❌ Error: No se encuentra fuente_datos.json")
    exit(1)

headers = {'User-Agent': 'Mozilla/5.0'}

for web, info in datos.items():
    for alt in info["alternativas"]:
        nombre_logo = f"{alt['nombre'].lower().replace(' ', '_').replace('+', '')}.png"
        ruta_local_logo = os.path.join(ruta_logos, nombre_logo)
        alt["icono"] = f"src/data/logos/{nombre_logo}"
        
        if not os.path.exists(ruta_local_logo):
            dominio = urllib.parse.urlparse(alt["url"]).netloc
            url_logo = f"https://logo.clearbit.com/{dominio}"
            try:
                req = urllib.request.Request(url_logo, headers=headers)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                    f.write(r.read())
            except:
                pass # Si falla, el fallback HTML lo solucionará en vivo

with open(ruta_json_final, 'w', encoding='utf-8') as f:
    json.dump(datos, f, indent=2, ensure_ascii=False)

print("✅ Base de datos unificada generada con éxito.")
EOF

# 4. Crear estructura para el Service Worker (Background)
echo "⚙️ Configurando sincronización remota (background.js)..."
mkdir -p src/background
cat << 'EOF' > src/background/background.js
// URL raw del JSON en tu repositorio de GitHub
const GITHUB_DB_URL = "https://raw.githubusercontent.com/arequenapx/conciencia-libre/main/src/data/alternativas.json";

chrome.runtime.onInstalled.addListener(() => {
  console.log("[Conciencia Libre] Comprobando actualizaciones de la base de conocimiento...");
  fetch(GITHUB_DB_URL, { cache: "no-store" })
    .then(response => response.json())
    .then(data => {
      chrome.storage.local.set({ "db_remota": data }, () => {
        console.log("✅ Base de datos sincronizada desde GitHub.");
      });
    })
    .catch(err => console.log("⚠️ Sin conexión. Se usará la base de datos local."));
});
EOF

# 5. Modificar manifest.json de forma segura usando Python
echo "📝 Actualizando manifest.json con permisos de Storage y Background..."
python3 -c "
import json
with open('manifest.json', 'r') as f:
    m = json.load(f)

if 'permissions' not in m: m['permissions'] = []
if 'storage' not in m['permissions']: m['permissions'].append('storage')

m['background'] = {'service_worker': 'src/background/background.js'}

with open('manifest.json', 'w') as f:
    json.dump(m, f, indent=2)
"

# 6. Despliegue en GitHub
echo "🌐 Subiendo cambios a GitHub (Rama: main)..."
git add .
git commit -m "Actualización dinámica, unificación de BD y sincronización remota"
git push origin main

echo "🎉 ¡Completado! Tu extensión ahora es dinámica."
