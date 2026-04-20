#!/bin/bash

echo "🎓 [Conciencia Libre] Añadiendo Bloque 9: Ocio, Educación y Ciencia (10 URLs)..."

cat << 'EOF' > scripts/generar_bd9.py
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

# SEMILLA BLOQUE 9: Ocio, Educación y Ciencia
nuevos_datos = {
    "steampowered.com": {
        "privativo": "Steam",
        "alternativas": [
            {"nombre": "Heroic Games Launcher", "licencia": "GPLv3", "estrellas": "7k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Lanzador de juegos de código abierto para Epic, GOG y Amazon.", "por_que": ["Privacidad absoluta.", "Soporte nativo para Wine y Proton."], "url": "https://heroicgameslauncher.com/"},
            {"nombre": "Lutris", "licencia": "GPLv3", "estrellas": "6k", "plataformas": ["Linux"], "descripcion": "Plataforma de preservación de videojuegos para Linux.", "por_que": ["Gestiona toda tu biblioteca en un sitio.", "Scripts de instalación comunitarios."], "url": "https://lutris.net/"}
        ]
    },
    "spotify.com": {
        "privativo": "Spotify",
        "alternativas": [
            {"nombre": "Spotube", "licencia": "BSD-4", "estrellas": "25k", "plataformas": ["Multiplataforma"], "descripcion": "Cliente de Spotify ligero que no requiere Premium ni usa telemetría.", "por_que": ["Sin anuncios.", "Sin rastreo de datos."], "url": "https://spotube.netlify.app/"},
            {"nombre": "Museeks", "licencia": "MIT", "estrellas": "4k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Reproductor de música minimalista, limpio y eficiente.", "por_que": ["Enfoque en la música local.", "Interfaz muy fluida."], "url": "https://museeks.io/"}
        ]
    },
    "netflix.com": {
        "privativo": "Netflix / Disney+",
        "alternativas": [
            {"nombre": "Jellyfin", "licencia": "GPLv2", "estrellas": "28k", "plataformas": ["Multiplataforma"], "descripcion": "El sistema de medios voluntario que te permite controlar tu streaming.", "por_que": ["Sin suscripciones ocultas.", "Tú eres el dueño del servidor."], "url": "https://jellyfin.org/"},
            {"nombre": "Kodi", "licencia": "GPLv2", "estrellas": "15k", "plataformas": ["Multiplataforma"], "descripcion": "Centro multimedia definitivo para organizar fotos, música y vídeo.", "por_que": ["Infinitos add-ons libres.", "Ideal para Smart TVs."], "url": "https://kodi.tv/"}
        ]
    },
    "mathworks.com/products/matlab": {
        "privativo": "MATLAB",
        "alternativas": [
            {"nombre": "GNU Octave", "licencia": "GPLv3", "estrellas": "N/A", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Lenguaje de alto nivel destinado a computación numérica.", "por_que": ["Altamente compatible con scripts de MATLAB.", "Potencia científica gratuita."], "url": "https://www.gnu.org/software/octave/"},
            {"nombre": "Scilab", "licencia": "GPL v2", "estrellas": "N/A", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Software para computación numérica con entorno de ingeniería.", "por_que": ["Gran alternativa para control y simulación.", "Visualización 3D avanzada."], "url": "https://www.scilab.org/"}
        ]
    },
    "wolframalpha.com": {
        "privativo": "WolframAlpha",
        "alternativas": [
            {"nombre": "SageMath", "licencia": "GPLv3", "estrellas": "2k", "plataformas": ["Linux", "Web"], "descripcion": "Sistema de software matemático que une Python, R, GAP y más.", "por_que": ["Soberanía científica.", "Ideal para investigación de alto nivel."], "url": "https://www.sagemath.org/"}
        ]
    },
    "duolingo.com": {
        "privativo": "Duolingo",
        "alternativas": [
            {"nombre": "Anki", "licencia": "AGPLv3", "estrellas": "15k", "plataformas": ["Multiplataforma"], "descripcion": "Aprendizaje inteligente mediante repetición espaciada.", "por_que": ["Método científicamente probado.", "Tú diseñas tu aprendizaje."], "url": "https://apps.ankiweb.net/"},
            {"nombre": "LibreLingo", "licencia": "AGPLv3", "estrellas": "3k", "plataformas": ["Web"], "descripcion": "Plataforma comunitaria de aprendizaje de idiomas 100% libre.", "por_que": ["Sin gamificación agresiva.", "Contenido abierto."], "url": "https://librelingo.app/"}
        ]
    },
    "coursera.org": {
        "privativo": "Coursera / Udemy",
        "alternativas": [
            {"nombre": "Moodle", "licencia": "GPLv3", "estrellas": "10k", "plataformas": ["Web"], "descripcion": "La plataforma de aprendizaje más utilizada del mundo.", "por_que": ["Control educativo total.", "Ecosistema pedagógico inmenso."], "url": "https://moodle.org/"}
        ]
    },
    "amazon.com/kindle-store": {
        "privativo": "Kindle Reader / Store",
        "alternativas": [
            {"nombre": "Calibre", "licencia": "GPLv3", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor y visor de libros electrónicos definitivo.", "por_que": ["Convierte cualquier formato.", "Elimina ataduras de tiendas cerradas."], "url": "https://calibre-ebook.com/"},
            {"nombre": "KOReader", "licencia": "AGPLv3", "estrellas": "13k", "plataformas": ["Kindle", "Android", "Linux"], "descripcion": "Visor de documentos avanzado para lectores de tinta electrónica.", "por_que": ["Mucho más potente que el software nativo.", "Soporta PDFs complejos."], "url": "https://koreader.rocks/"}
        ]
    },
    "ibm.com/spss": {
        "privativo": "IBM SPSS Statistics",
        "alternativas": [
            {"nombre": "GNU PSPP", "licencia": "GPLv3", "estrellas": "N/A", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Análisis estadístico de datos muestreados.", "por_que": ["Interfaz casi idéntica a SPSS.", "Libre de cuotas de licencia."], "url": "https://www.gnu.org/software/pspp/"},
            {"nombre": "Jamovi", "licencia": "GPLv3", "estrellas": "2k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Estadística moderna y robusta basada en R.", "por_que": ["Interfaz visual increíble.", "Resultados en tiempo real."], "url": "https://www.jamovi.org/"}
        ]
    },
    "ea.com/ea-app": {
        "privativo": "Origin / EA App",
        "alternativas": [
            {"nombre": "Heroic Games Launcher", "licencia": "GPLv3", "estrellas": "7k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestiona tus juegos de EA y Epic sin clientes pesados.", "por_que": ["Más ligero que la app oficial.", "Mejor compatibilidad en Linux/SteamDeck."], "url": "https://heroicgameslauncher.com/"}
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

print(f"🤖 Procesando logos para el Bloque 9...")
headers = {'User-Agent': 'Mozilla/5.0'}

for web, info in nuevos_datos.items():
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

print("🎉 Bloque 9 integrado correctamente.")
EOF

python3 scripts/generar_bd9.py
