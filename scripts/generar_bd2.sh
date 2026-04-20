#!/bin/bash

echo "🏢 [Conciencia Libre] Añadiendo Bloque 2: Ofimática y Productividad (10 URLs)..."

cat << 'EOF' > scripts/generar_bd2.py
import json
import os
import urllib.request
import urllib.parse
import ssl
import time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# Rutas
dir_actual = os.path.dirname(os.path.abspath(__file__))
ruta_logos = os.path.join(dir_actual, "../src/data/logos/")
ruta_json = os.path.join(dir_actual, "../src/data/alternativas.json")
os.makedirs(ruta_logos, exist_ok=True)

# SEMILLA BLOQUE 2
nuevos_datos = {
    "microsoft.com/microsoft-365/word": {
        "privativo": "Microsoft Word",
        "alternativas": [
            {"nombre": "LibreOffice Writer", "licencia": "MPL 2.0", "estrellas": "28k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Potente procesador de textos profesional.", "por_que": ["Compatibilidad .docx.", "Privacidad total."], "url": "https://www.libreoffice.org/"},
            {"nombre": "OnlyOffice", "licencia": "AGPL 3.0", "estrellas": "15k", "plataformas": ["Web", "Win", "Linux"], "descripcion": "Alta fidelidad con formatos de MS Office.", "por_que": ["Interfaz moderna.", "Edición colaborativa."], "url": "https://www.onlyoffice.com/"}
        ]
    },
    "microsoft.com/microsoft-365/excel": {
        "privativo": "Microsoft Excel",
        "alternativas": [
            {"nombre": "LibreOffice Calc", "licencia": "MPL 2.0", "estrellas": "28k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Hojas de cálculo con funciones avanzadas.", "por_que": ["Cálculo complejo.", "Sin suscripciones."], "url": "https://www.libreoffice.org/"}
        ]
    },
    "microsoft.com/microsoft-365/powerpoint": {
        "privativo": "Microsoft PowerPoint",
        "alternativas": [
            {"nombre": "LibreOffice Impress", "licencia": "MPL 2.0", "estrellas": "28k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Herramienta de presentaciones multimedia.", "por_que": ["Versatilidad de formatos.", "Exportación limpia."], "url": "https://www.libreoffice.org/"}
        ]
    },
    "microsoft.com/microsoft-365/outlook": {
        "privativo": "Microsoft Outlook",
        "alternativas": [
            {"nombre": "Thunderbird", "licencia": "MPL 2.0", "estrellas": "12k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor de correo y calendario robusto.", "por_que": ["Altamente personalizable.", "Privacidad de datos."], "url": "https://www.thunderbird.net/"}
        ]
    },
    "notion.so": {
        "privativo": "Notion",
        "alternativas": [
            {"nombre": "AppFlowy", "licencia": "AGPL 3.0", "estrellas": "45k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Alternativa a Notion centrada en la soberanía de datos.", "por_que": ["Escrito en Rust (rápido).", "Tú controlas tus datos."], "url": "https://appflowy.io/"}
        ]
    },
    "evernote.com": {
        "privativo": "Evernote",
        "alternativas": [
            {"nombre": "Joplin", "licencia": "AGPL 3.0", "estrellas": "40k", "plataformas": ["Móvil", "Desktop"], "descripcion": "Captura tus notas y sincronízalas con seguridad.", "por_que": ["Cifrado de extremo a extremo.", "Auto-alojable."], "url": "https://joplinapp.org/"}
        ]
    },
    "trello.com": {
        "privativo": "Trello",
        "alternativas": [
            {"nombre": "Wekan", "licencia": "MIT", "estrellas": "18k", "plataformas": ["Web", "Linux"], "descripcion": "Tablero Kanban open-source muy completo.", "por_que": ["Sin límites de usuarios.", "Tableros infinitos."], "url": "https://wekan.github.io/"}
        ]
    },
    "asana.com": {
        "privativo": "Asana",
        "alternativas": [
            {"nombre": "Taiga", "licencia": "MPL 2.0", "estrellas": "10k", "plataformas": ["Web", "Self-hosted"], "descripcion": "Gestión de proyectos ágil para equipos.", "por_que": ["Interfaz intuitiva.", "Flujos de trabajo flexibles."], "url": "https://taiga.io/"}
        ]
    },
    "monday.com": {
        "privativo": "Monday.com",
        "alternativas": [
            {"nombre": "Vikunja", "licencia": "AGPL 3.0", "estrellas": "6k", "plataformas": ["Web", "Linux"], "descripcion": "Organiza tus tareas con múltiples vistas.", "por_que": ["Vistas Gantt y Kanban.", "Colaborativo."], "url": "https://vikunja.io/"}
        ]
    },
    "atlassian.com/software/jira": {
        "privativo": "Atlassian Jira",
        "alternativas": [
            {"nombre": "OpenProject", "licencia": "GPL 3.0", "estrellas": "8k", "plataformas": ["Web", "Linux"], "descripcion": "Software líder de gestión de proyectos open source.", "por_que": ["Seguridad empresarial.", "Gestión de recursos."], "url": "https://www.openproject.org/"}
        ]
    }
}

# Cargar base de datos existente
if os.path.exists(ruta_json):
    with open(ruta_json, 'r', encoding='utf-8') as f:
        try:
            base_datos = json.load(f)
        except: base_datos = {}
else:
    base_datos = {}

# Fusionar
base_datos.update(nuevos_datos)

print(f"🤖 Procesando logos para el Bloque 2...")
headers = {'User-Agent': 'Mozilla/5.0'}

for web, info in nuevos_datos.items():
    for alt in info["alternativas"]:
        nombre_logo = f"{alt['nombre'].lower().replace(' ', '_')}.png"
        ruta_local_logo = os.path.join(ruta_logos, nombre_logo)
        alt["icono"] = f"src/data/logos/{nombre_logo}"
        
        if not os.path.exists(ruta_local_logo):
            dominio = urllib.parse.urlparse(alt["url"]).netloc
            url_logo = f"https://logo.clearbit.com/{dominio}"
            try:
                req = urllib.request.Request(url_logo, headers=headers)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                    f.write(r.read())
                print(f"   ✅ {alt['nombre']}")
            except:
                try:
                    url_fb = f"https://www.google.com/s2/favicons?domain={dominio}&sz=128"
                    req = urllib.request.Request(url_fb, headers=headers)
                    with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                        f.write(r.read())
                    print(f"   ✅ {alt['nombre']} (Fallback)")
                except:
                    print(f"   ❌ {alt['nombre']}")
                    alt["icono"] = ""

# Guardar
with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_datos, f, indent=2, ensure_ascii=False)

print("🎉 Bloque 2 integrado correctamente.")
EOF

python3 scripts/generar_bd2.py
