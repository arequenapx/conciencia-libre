#!/bin/bash

echo "🩹 [Conciencia Libre] Aplicando parche anti-bloqueo 429 al Bot..."

cat << 'EOF' > scripts/generar_bd.py
import json
import os
import urllib.request
import ssl
import time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

fuente_datos = {
    "microsoft.com": {
        "privativo": "Microsoft Office / 365",
        "alternativas": [
            {
                "nombre": "LibreOffice",
                "licencia": "MPL 2.0",
                "estrellas": "28.4k",
                "plataformas": ["Win", "Mac", "Linux"],
                "descripcion": "La suite ofimática más potente y compatible del mundo libre.",
                "por_que": ["🚀 100% Gratuito: Olvida las suscripciones.", "📂 Estándar Abierto.", "🛡️ Privacidad Total."],
                "url": "https://es.libreoffice.org/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/LibreOffice_logo.svg/128px-LibreOffice_logo.svg.png"
            },
            {
                "nombre": "OnlyOffice",
                "licencia": "AGPL 3.0",
                "estrellas": "15.2k",
                "plataformas": ["Win", "Mac", "Linux", "Web"],
                "descripcion": "Interfaz moderna y máxima fidelidad con archivos .docx.",
                "por_que": ["🤝 Colaboración en tiempo real.", "☁️ Auto-alojable en tu servidor."],
                "url": "https://www.onlyoffice.com/es/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/ONLYOFFICE_logo.svg/128px-ONLYOFFICE_logo.svg.png"
            }
        ]
    },
    "adobe.com/products/photoshop": {
        "privativo": "Adobe Photoshop",
        "alternativas": [
            {
                "nombre": "GIMP",
                "licencia": "GPL 3.0",
                "estrellas": "50k",
                "plataformas": ["Win", "Mac", "Linux"],
                "descripcion": "El estándar profesional para la manipulación de imágenes.",
                "por_que": ["💰 Potencia profesional a coste cero.", "🔌 Expandible con miles de plugins."],
                "url": "https://www.gimp.org/es/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/The_GIMP_icon_-_gnome.svg/128px-The_GIMP_icon_-_gnome.svg.png"
            },
            {
                "nombre": "Krita",
                "licencia": "GPL 3.0",
                "estrellas": "22k",
                "plataformas": ["Win", "Mac", "Linux"],
                "descripcion": "Software de pintura digital e ilustración 2D profesional.",
                "por_que": ["🎨 Diseñado por y para ilustradores.", "🖌️ Motor de pinceles avanzado."],
                "url": "https://krita.org/es/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Calligra_Krita_icon.svg/128px-Calligra_Krita_icon.svg.png"
            }
        ]
    },
    "adobe.com/products/illustrator": {
        "privativo": "Adobe Illustrator",
        "alternativas": [
            {
                "nombre": "Inkscape",
                "licencia": "GPL 3.0",
                "estrellas": "25k",
                "plataformas": ["Win", "Mac", "Linux"],
                "descripcion": "Editor de gráficos vectoriales de código abierto.",
                "por_que": ["📐 Formato nativo SVG estándar.", "🖋️ Herramientas de dibujo avanzadas."],
                "url": "https://inkscape.org/es/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Inkscape_Logo.svg/128px-Inkscape_Logo.svg.png"
            }
        ]
    },
    "autodesk.com/products/autocad": {
        "privativo": "AutoCAD",
        "alternativas": [
            {
                "nombre": "FreeCAD",
                "licencia": "LGPL 2.0",
                "estrellas": "16k",
                "plataformas": ["Win", "Mac", "Linux"],
                "descripcion": "Modelador 3D paramétrico para diseño CAD, MCAD, CAx y CAE.",
                "por_que": ["⚙️ Arquitectura modular.", "🏗️ Sin licencias corporativas restrictivas."],
                "url": "https://www.freecadweb.org/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/FreeCAD_logo.svg/128px-FreeCAD_logo.svg.png"
            }
        ]
    },
    "zoom.us": {
        "privativo": "Zoom",
        "alternativas": [
            {
                "nombre": "Jitsi Meet",
                "licencia": "Apache 2.0",
                "estrellas": "20k",
                "plataformas": ["Web", "Android", "iOS"],
                "descripcion": "Videoconferencias seguras, completas y 100% de código abierto.",
                "por_que": ["🔒 Sin necesidad de cuenta para participar.", "⏱️ Sin límite de tiempo en llamadas."],
                "url": "https://meet.jit.si/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Jitsi_logo.svg/128px-Jitsi_logo.svg.png"
            }
        ]
    },
    "google.com/drive": {
        "privativo": "Google Drive",
        "alternativas": [
            {
                "nombre": "Nextcloud",
                "licencia": "AGPL 3.0",
                "estrellas": "24k",
                "plataformas": ["Win", "Mac", "Linux", "Web", "Móvil"],
                "descripcion": "Plataforma de colaboración y alojamiento de archivos auto-gestionada.",
                "por_que": ["☁️ Tus datos están en tu servidor, no en los de Google.", "🔐 Cifrado de extremo a extremo opcional."],
                "url": "https://nextcloud.com/",
                "url_logo_externo": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Nextcloud_Logo.svg/128px-Nextcloud_Logo.svg.png"
            }
        ]
    }
}

ruta_logos = "../src/data/logos/"
ruta_json = "../src/data/alternativas.json"
os.makedirs(ruta_logos, exist_ok=True)
base_final = {}

print("🤖 Iniciando Bot Educado de Conciencia Libre...")
print("---------------------------------------")

# Identificación clara para no ser baneados por Wikimedia
headers_educados = {
    'User-Agent': 'ConcienciaLibreBot/1.0 (Proyecto Educativo; UCO; contacto@tudominio.com)'
}

for web_privativa, datos in fuente_datos.items():
    base_final[web_privativa] = {"privativo": datos["privativo"], "alternativas": []}
    
    for alt in datos["alternativas"]:
        nombre_archivo = f"{alt['nombre'].lower().replace(' ', '_')}.png"
        ruta_local = os.path.join(ruta_logos, nombre_archivo)
        ruta_extension = f"src/data/logos/{nombre_archivo}"
        
        if not os.path.exists(ruta_local) and "url_logo_externo" in alt:
            try:
                print(f"📥 Solicitando logo de {alt['nombre']}...")
                req = urllib.request.Request(alt["url_logo_externo"], headers=headers_educados)
                with urllib.request.urlopen(req, context=ctx) as response, open(ruta_local, 'wb') as out_file:
                    out_file.write(response.read())
                print(f"✅ Logo guardado.")
                
                # Pausa mágica de 1.5 segundos para no enfadar al servidor
                time.sleep(1.5) 
            except Exception as e:
                print(f"❌ Error con {alt['nombre']}: {e}")
                ruta_extension = ""

        alt_limpia = {
            "nombre": alt["nombre"],
            "licencia": alt["licencia"],
            "estrellas": alt["estrellas"],
            "plataformas": alt["plataformas"],
            "descripcion": alt["descripcion"],
            "por_que": alt["por_que"],
            "url": alt["url"],
            "icono": ruta_extension
        }
        base_final[web_privativa]["alternativas"].append(alt_limpia)

with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_final, f, indent=2, ensure_ascii=False)

print("---------------------------------------")
print("🎉 Proceso finalizado. El archivo alternativas.json ha sido construido de forma segura.")
EOF

echo "✅ Parche aplicado. Ejecutando de nuevo..."
cd scripts
python3 generar_bd.py