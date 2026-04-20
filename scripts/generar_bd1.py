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

# SEMILLA BLOQUE 1
nuevos_datos = {
    "adobe.com/products/photoshop": {
        "privativo": "Adobe Photoshop",
        "alternativas": [
            {"nombre": "GIMP", "licencia": "GPL 3.0", "estrellas": "50k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor fotográfico profesional.", "por_que": ["Potencia profesional.", "Sin suscripciones."], "url": "https://www.gimp.org/"},
            {"nombre": "Krita", "licencia": "GPL 3.0", "estrellas": "22k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Especializado en pintura digital.", "por_que": ["Pinceles avanzados.", "Ideal para artistas."], "url": "https://krita.org/"}
        ]
    },
    "adobe.com/products/illustrator": {
        "privativo": "Adobe Illustrator",
        "alternativas": [
            {"nombre": "Inkscape", "licencia": "GPL 3.0", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vectores SVG profesional.", "por_que": ["Estándar abierto.", "Herramientas potentes."], "url": "https://inkscape.org/"}
        ]
    },
    "adobe.com/products/indesign": {
        "privativo": "Adobe InDesign",
        "alternativas": [
            {"nombre": "Scribus", "licencia": "GPL 2.0", "estrellas": "3k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Autoedición y maquetación de páginas.", "por_que": ["Salida CMYK profesional.", "Soporte ICC."], "url": "https://www.scribus.net/"}
        ]
    },
    "adobe.com/products/lightroom": {
        "privativo": "Adobe Lightroom",
        "alternativas": [
            {"nombre": "Darktable", "licencia": "GPL 3.0", "estrellas": "8k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Flujo de trabajo fotográfico y revelado RAW.", "por_que": ["Edición no destructiva.", "Gestión de color avanzada."], "url": "https://www.darktable.org/"}
        ]
    },
    "adobe.com/products/aftereffects": {
        "privativo": "Adobe After Effects",
        "alternativas": [
            {"nombre": "Natron", "licencia": "GPL 2.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Composición de efectos visuales (VFX) por nodos.", "por_que": ["Arquitectura OpenFX.", "Potencia cinematográfica."], "url": "https://natrongithub.github.io/"}
        ]
    },
    "adobe.com/products/animate": {
        "privativo": "Adobe Animate",
        "alternativas": [
            {"nombre": "Synfig Studio", "licencia": "GPL 3.0", "estrellas": "4k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Animación 2D vectorial potente.", "por_que": ["Animación por huesos.", "Interpolación automática."], "url": "https://www.synfig.org/"}
        ]
    },
    "adobe.com/products/dreamweaver": {
        "privativo": "Adobe Dreamweaver",
        "alternativas": [
            {"nombre": "VS Code", "licencia": "MIT", "estrellas": "150k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "El editor de código más popular (Open Source base).", "por_que": ["Ecosistema gigante.", "Ligero y extensible."], "url": "https://code.visualstudio.com/"}
        ]
    },
    "coreldraw.com": {
        "privativo": "CorelDraw",
        "alternativas": [
            {"nombre": "Inkscape", "licencia": "GPL 3.0", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Alternativa libre para diseño vectorial.", "por_que": ["Fácil de usar.", "Totalmente gratuito."], "url": "https://inkscape.org/"}
        ]
    },
    "sketch.com": {
        "privativo": "Sketch",
        "alternativas": [
            {"nombre": "Penpot", "licencia": "MPL 2.0", "estrellas": "27k", "plataformas": ["Web", "Linux"], "descripcion": "Diseño UX/UI basado en estándares abiertos.", "por_que": ["Colaboración real.", "Uso de SVG y CSS nativo."], "url": "https://penpot.app/"}
        ]
    },
    "figma.com": {
        "privativo": "Figma",
        "alternativas": [
            {"nombre": "Penpot", "licencia": "MPL 2.0", "estrellas": "27k", "plataformas": ["Web"], "descripcion": "La alternativa libre a Figma para equipos.", "por_que": ["Sin límites de archivos.", "Independencia de plataforma."], "url": "https://penpot.app/"}
        ]
    }
}

# Cargar base de datos existente si existe
if os.path.exists(ruta_json):
    with open(ruta_json, 'r', encoding='utf-8') as f:
        try:
            base_datos = json.load(f)
        except:
            base_datos = {}
else:
    base_datos = {}

# Fusionar datos
base_datos.update(nuevos_datos)

print(f"🤖 Procesando logos para el Bloque 1...")
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
                # Fallback Google
                try:
                    url_fb = f"https://www.google.com/s2/favicons?domain={dominio}&sz=128"
                    req = urllib.request.Request(url_fb, headers=headers)
                    with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                        f.write(r.read())
                    print(f"   ✅ {alt['nombre']} (Fallback)")
                except:
                    print(f"   ❌ {alt['nombre']}")
                    alt["icono"] = ""

# Guardar final
with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_datos, f, indent=2, ensure_ascii=False)

print("🎉 Bloque 1 integrado correctamente.")
