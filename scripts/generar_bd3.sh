#!/bin/bash

echo "🎬 [Conciencia Libre] Añadiendo Bloque 3: Vídeo, Audio y Multimedia (10 URLs)..."

cat << 'EOF' > scripts/generar_bd3.py
import json
import os
import urllib.request
import urllib.parse
import ssl
import time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

dir_actual = os.path.dirname(os.path.abspath(__file__))
ruta_logos = os.path.join(dir_actual, "../src/data/logos/")
ruta_json = os.path.join(dir_actual, "../src/data/alternativas.json")
os.makedirs(ruta_logos, exist_ok=True)

# SEMILLA BLOQUE 3
nuevos_datos = {
    "adobe.com/products/premiere": {
        "privativo": "Adobe Premiere Pro",
        "alternativas": [
            {"nombre": "Kdenlive", "licencia": "GPL 3.0", "estrellas": "12k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vídeo no lineal profesional y versátil.", "por_que": ["Efectos avanzados.", "Altamente estable."], "url": "https://kdenlive.org/"},
            {"nombre": "Shotcut", "licencia": "GPL 3.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor multiplataforma con soporte 4K nativo.", "por_que": ["Sin curvas de aprendizaje.", "Ligero."], "url": "https://shotcut.org/"}
        ]
    },
    "adobe.com/products/audition": {
        "privativo": "Adobe Audition",
        "alternativas": [
            {"nombre": "Audacity", "licencia": "GPL 2.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "El estándar libre para edición y grabación de audio.", "por_que": ["Gran ecosistema de plugins.", "Muy sencillo."], "url": "https://www.audacityteam.org/"},
            {"nombre": "Tenacity", "licencia": "GPL 3.0", "estrellas": "4k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Fork de Audacity enfocado en la privacidad total.", "por_que": ["Sin telemetría.", "Respetuoso con el usuario."], "url": "https://tenacityaudio.org/"}
        ]
    },
    "apple.com/final-cut-pro": {
        "privativo": "Final Cut Pro",
        "alternativas": [
            {"nombre": "Olive", "licencia": "GPL 3.0", "estrellas": "6k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vídeo de alta fidelidad basado en nodos.", "por_que": ["Motor de renderizado rápido.", "Interfaz moderna."], "url": "https://www.olivevideoeditor.org/"}
        ]
    },
    "apple.com/logic-pro": {
        "privativo": "Logic Pro",
        "alternativas": [
            {"nombre": "Ardour", "licencia": "GPL 2.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Estación de trabajo de audio digital profesional (DAW).", "por_que": ["Grabación multipista real.", "Soporte VST/LV2."], "url": "https://ardour.org/"}
        ]
    },
    "image-line.com/fl-studio": {
        "privativo": "FL Studio",
        "alternativas": [
            {"nombre": "LMMS", "licencia": "GPL 2.0", "estrellas": "20k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Producción musical enfocada en beats y sintetizadores.", "por_que": ["Secuenciador intuitivo.", "Incluye instrumentos libres."], "url": "https://lmms.io/"}
        ]
    },
    "ableton.com": {
        "privativo": "Ableton Live",
        "alternativas": [
            {"nombre": "Giada", "licencia": "GPL 3.0", "estrellas": "2k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Herramienta de live-looping y carga de samples.", "por_que": ["Mínima latencia.", "Enfocado a directos."], "url": "https://www.giadamusic.com/"}
        ]
    },
    "steinberg.net/cubase": {
        "privativo": "Steinberg Cubase",
        "alternativas": [
            {"nombre": "Ardour", "licencia": "GPL 2.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Alternativa sólida para composición y mezcla profesional.", "por_que": ["Control total del flujo.", "Económicamente ético."], "url": "https://ardour.org/"}
        ]
    },
    "avid.com/pro-tools": {
        "privativo": "Avid Pro Tools",
        "alternativas": [
            {"nombre": "Ardour", "licencia": "GPL 2.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La solución FLOSS para postproducción de audio.", "por_que": ["Precisión de edición.", "Estándar abierto."], "url": "https://ardour.org/"}
        ]
    },
    "techsmith.com/camtasia": {
        "privativo": "Camtasia",
        "alternativas": [
            {"nombre": "OBS Studio", "licencia": "GPL 2.0", "estrellas": "50k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Grabación de pantalla y streaming profesional.", "por_que": ["Escenas ilimitadas.", "Gran rendimiento."], "url": "https://obsproject.com/"}
        ]
    },
    "magix.com/vegas-pro": {
        "privativo": "Vegas Pro",
        "alternativas": [
            {"nombre": "Flowblade", "licencia": "GPL 3.0", "estrellas": "3k", "plataformas": ["Linux"], "descripcion": "Editor de vídeo rápido diseñado para flujos de trabajo ágiles.", "por_que": ["Precisión de frame.", "Muy estable."], "url": "https://jliljebl.github.io/flowblade/"}
        ]
    }
}

if os.path.exists(ruta_json):
    with open(ruta_json, 'r', encoding='utf-8') as f:
        try: base_datos = json.load(f)
        except: base_datos = {}
else:
    base_datos = {}

base_datos.update(nuevos_datos)

print(f"🤖 Procesando logos para el Bloque 3...")
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

with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_datos, f, indent=2, ensure_ascii=False)

print("🎉 Bloque 3 integrado.")
EOF

python3 scripts/generar_bd3.py
