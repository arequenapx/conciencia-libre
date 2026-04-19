import json
import os
import urllib.request
import urllib.parse
import ssl
import time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# 📚 BASE DE CONOCIMIENTO GIGANTE Y MULTI-OPCIÓN
fuente_datos = {
    # --- OFIMÁTICA Y PRODUCTIVIDAD ---
    "microsoft.com": {
        "privativo": "Microsoft Office / 365",
        "alternativas": [
            {"nombre": "LibreOffice", "licencia": "MPL 2.0", "estrellas": "28k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La suite ofimática más potente del mundo libre.", "por_que": ["100% Gratuito", "Estándar Abierto", "Privacidad Total"], "url": "https://es.libreoffice.org/"},
            {"nombre": "OnlyOffice", "licencia": "AGPL 3.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux", "Web"], "descripcion": "Interfaz moderna y máxima fidelidad con MS Office.", "por_que": ["Colaboración en tiempo real", "Auto-alojable"], "url": "https://www.onlyoffice.com/es/"},
            {"nombre": "Apache OpenOffice", "licencia": "Apache 2.0", "estrellas": "12k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Clásico procesador de textos y hojas de cálculo libre.", "por_que": ["Comunidad histórica", "Gran estabilidad"], "url": "https://www.openoffice.org/es/"}
        ]
    },
    "notion.so": {
        "privativo": "Notion",
        "alternativas": [
            {"nombre": "AppFlowy", "licencia": "AGPL 3.0", "estrellas": "45k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La alternativa directa a Notion, centrada en la privacidad.", "por_que": ["100% control de tus datos", "Rápido (escrito en Rust)"], "url": "https://appflowy.io/"},
            {"nombre": "Joplin", "licencia": "AGPL 3.0", "estrellas": "40k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Aplicación de notas con soporte Markdown y cifrado.", "por_que": ["Notas locales", "Cifrado E2E"], "url": "https://joplinapp.org/"},
            {"nombre": "Logseq", "licencia": "AGPL 3.0", "estrellas": "28k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Base de conocimiento basada en esquemas y grafos.", "por_que": ["Archivos de texto plano locales", "Ideal para estudiantes"], "url": "https://logseq.com/"}
        ]
    },

    # --- DISEÑO, 3D Y MULTIMEDIA ---
    "figma.com": {
        "privativo": "Figma",
        "alternativas": [
            {"nombre": "Penpot", "licencia": "MPL 2.0", "estrellas": "27k", "plataformas": ["Web", "Auto-alojable"], "descripcion": "La primera herramienta de diseño y prototipado Open Source.", "por_que": ["Basada en SVG nativo", "Colaboración real", "100% web libre"], "url": "https://penpot.app/"}
        ]
    },
    "adobe.com/products/photoshop": {
        "privativo": "Adobe Photoshop",
        "alternativas": [
            {"nombre": "GIMP", "licencia": "GPL 3.0", "estrellas": "50k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "El estándar profesional para la manipulación de imágenes.", "por_que": ["Potencia a coste cero", "Miles de plugins"], "url": "https://www.gimp.org/"},
            {"nombre": "Krita", "licencia": "GPL 3.0", "estrellas": "22k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Software de pintura digital e ilustración.", "por_que": ["Diseñado por ilustradores", "Pinceles avanzados"], "url": "https://krita.org/"}
        ]
    },
    "adobe.com/products/illustrator": {
        "privativo": "Adobe Illustrator",
        "alternativas": [
            {"nombre": "Inkscape", "licencia": "GPL 3.0", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de gráficos vectoriales de código abierto.", "por_que": ["Formato nativo SVG", "Herramientas de dibujo profesional"], "url": "https://inkscape.org/"}
        ]
    },
    "adobe.com/products/premiere": {
        "privativo": "Adobe Premiere Pro",
        "alternativas": [
            {"nombre": "Kdenlive", "licencia": "GPL 3.0", "estrellas": "12k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Edición de video no lineal multipista profesional.", "por_que": ["Soporta múltiples formatos", "Interfaz personalizable"], "url": "https://kdenlive.org/"},
            {"nombre": "Shotcut", "licencia": "GPL 3.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vídeo multiplataforma gratuito y de código abierto.", "por_que": ["Sin marcas de agua", "Soporte 4K"], "url": "https://shotcut.org/"},
            {"nombre": "Olive Video Editor", "licencia": "GPL 3.0", "estrellas": "6k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vídeo de nueva generación en desarrollo.", "por_que": ["Motor de renderizado rápido", "Basado en nodos"], "url": "https://olivevideoeditor.org/"}
        ]
    },
    "adobe.com/products/audition": {
        "privativo": "Adobe Audition",
        "alternativas": [
            {"nombre": "Audacity", "licencia": "GPL 2.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "El grabador y editor de audio libre más famoso.", "por_que": ["Fácil de usar", "Soporte para plugins VST"], "url": "https://www.audacityteam.org/"},
            {"nombre": "Tenacity", "licencia": "GPL 3.0", "estrellas": "4k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Un fork de Audacity enfocado en la privacidad estricta.", "por_que": ["Libre de telemetría", "Mismas herramientas potentes"], "url": "https://tenacityaudio.org/"}
        ]
    },
    "autodesk.com/products/autocad": {
        "privativo": "AutoCAD",
        "alternativas": [
            {"nombre": "FreeCAD", "licencia": "LGPL 2.0", "estrellas": "16k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Modelador 3D paramétrico para diseño CAD.", "por_que": ["Arquitectura modular", "Sin licencias restrictivas"], "url": "https://www.freecad.org/"},
            {"nombre": "LibreCAD", "licencia": "GPL 2.0", "estrellas": "5k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Aplicación de diseño asistido por ordenador para 2D.", "por_que": ["Especializado en planos 2D", "Muy ligero"], "url": "https://librecad.org/"}
        ]
    },

    # --- COMUNICACIÓN Y REDES ---
    "zoom.us": {
        "privativo": "Zoom",
        "alternativas": [
            {"nombre": "Jitsi Meet", "licencia": "Apache 2.0", "estrellas": "20k", "plataformas": ["Web", "Android", "iOS"], "descripcion": "Videoconferencias seguras y de código abierto.", "por_que": ["Sin necesidad de cuenta", "Sin límite de tiempo"], "url": "https://meet.jit.si/"},
            {"nombre": "BigBlueButton", "licencia": "LGPL", "estrellas": "8k", "plataformas": ["Web"], "descripcion": "Conferencias web diseñadas para el aprendizaje.", "por_que": ["Pizarra interactiva", "Salas de grupos"], "url": "https://bigbluebutton.org/"}
        ]
    },
    "whatsapp.com": {
        "privativo": "WhatsApp",
        "alternativas": [
            {"nombre": "Signal", "licencia": "GPL 3.0", "estrellas": "30k", "plataformas": ["iOS", "Android", "Desktop"], "descripcion": "La app de mensajería más segura del mundo.", "por_que": ["Cifrado inquebrantable", "Sin recolección de metadatos"], "url": "https://signal.org/"},
            {"nombre": "Session", "licencia": "GPL 3.0", "estrellas": "12k", "plataformas": ["iOS", "Android", "Desktop"], "descripcion": "Mensajería privada que no requiere número de teléfono.", "por_que": ["Descentralizada (tipo Tor)", "Anonimato total"], "url": "https://getsession.org/"}
        ]
    },
    "slack.com": {
        "privativo": "Slack",
        "alternativas": [
            {"nombre": "Element", "licencia": "Apache 2.0", "estrellas": "18k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Mensajería cifrada basada en el protocolo Matrix.", "por_que": ["Cifrado E2E", "Red descentralizada"], "url": "https://element.io/"},
            {"nombre": "Mattermost", "licencia": "AGPL 3.0", "estrellas": "26k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Plataforma de colaboración segura y auto-alojable.", "por_que": ["Control total de datos", "Integraciones empresariales"], "url": "https://mattermost.com/"}
        ]
    },

    # --- DESARROLLO Y ANÁLISIS ---
    "analytics.google.com": {
        "privativo": "Google Analytics",
        "alternativas": [
            {"nombre": "Matomo", "licencia": "GPL 3.0", "estrellas": "18k", "plataformas": ["Web", "Auto-alojable"], "descripcion": "Analítica web ética que respeta la privacidad.", "por_que": ["Cumple 100% con GDPR", "Eres dueño de los datos"], "url": "https://matomo.org/"},
            {"nombre": "Plausible", "licencia": "AGPL 3.0", "estrellas": "16k", "plataformas": ["Web", "Auto-alojable"], "descripcion": "Analítica ultraligera y sin cookies.", "por_que": ["Script de < 1KB", "Sin banners de cookies"], "url": "https://plausible.io/"}
        ]
    },

    # --- CLOUD, HERRAMIENTAS Y SISTEMAS ---
    "google.com/drive": {
        "privativo": "Google Drive",
        "alternativas": [
            {"nombre": "Nextcloud", "licencia": "AGPL 3.0", "estrellas": "24k", "plataformas": ["Win", "Mac", "Linux", "Web", "Móvil"], "descripcion": "Tu propia nube de archivos, contactos y calendarios.", "por_que": ["Soberanía de datos", "Cifrado E2E"], "url": "https://nextcloud.com/"},
            {"nombre": "Syncthing", "licencia": "MPL 2.0", "estrellas": "60k", "plataformas": ["Win", "Mac", "Linux", "Android"], "descripcion": "Sincronización P2P descentralizada.", "por_que": ["Sin servidores centrales", "Rápido y privado"], "url": "https://syncthing.net/"}
        ]
    },
    "winrar.com": {
        "privativo": "WinRAR / WinZip",
        "alternativas": [
            {"nombre": "7-Zip", "licencia": "LGPL", "estrellas": "N/A", "plataformas": ["Win", "Linux"], "descripcion": "Archivador de ficheros con un altísimo ratio de compresión.", "por_que": ["Soporta casi cualquier formato", "Extremadamente ligero"], "url": "https://www.7-zip.org/"},
            {"nombre": "PeaZip", "licencia": "LGPL 3.0", "estrellas": "3k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor de archivos comprimidos con interfaz amigable.", "por_que": ["Cifrado fuerte", "Más de 200 formatos"], "url": "https://peazip.github.io/"}
        ]
    },
    "1password.com": {
        "privativo": "1Password / LastPass",
        "alternativas": [
            {"nombre": "Bitwarden", "licencia": "GPL 3.0", "estrellas": "15k", "plataformas": ["Multiplataforma"], "descripcion": "Gestor de contraseñas seguro y de código abierto.", "por_que": ["Auditorías públicas", "Nube cifrada o local"], "url": "https://bitwarden.com/"},
            {"nombre": "KeePassXC", "licencia": "GPL 2.0", "estrellas": "18k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor de contraseñas 100% offline y local.", "por_que": ["Tu BD nunca sale del PC", "Altamente cifrado"], "url": "https://keepassxc.org/"}
        ]
    }
}

directorio_actual = os.path.dirname(os.path.abspath(__file__))
ruta_logos = os.path.join(directorio_actual, "../src/data/logos/")
ruta_json = os.path.join(directorio_actual, "../src/data/alternativas.json")
os.makedirs(ruta_logos, exist_ok=True)
base_final = {}

print("🤖 Iniciando Motor Dual de Extracción de Logos...")
headers_educados = {'User-Agent': 'Mozilla/5.0'}

for web_privativa, datos in fuente_datos.items():
    base_final[web_privativa] = {"privativo": datos["privativo"], "alternativas": []}
    
    for alt in datos["alternativas"]:
        nombre_archivo = f"{alt['nombre'].lower().replace(' ', '_').replace('+', '')}.png"
        ruta_local_archivo = os.path.join(ruta_logos, nombre_archivo)
        ruta_extension = f"src/data/logos/{nombre_archivo}"
        
        if not os.path.exists(ruta_local_archivo):
            dominio = urllib.parse.urlparse(alt["url"]).netloc
            url_api_1 = f"https://logo.clearbit.com/{dominio}"
            url_api_2 = f"https://www.google.com/s2/favicons?domain={dominio}&sz=128"
            
            descargado = False
            print(f"📥 Buscando logo de {alt['nombre']}...")
            try:
                req = urllib.request.Request(url_api_1, headers=headers_educados)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as response, open(ruta_local_archivo, 'wb') as out_file:
                    out_file.write(response.read())
                descargado = True
            except Exception:
                try:
                    req = urllib.request.Request(url_api_2, headers=headers_educados)
                    with urllib.request.urlopen(req, context=ctx, timeout=5) as response, open(ruta_local_archivo, 'wb') as out_file:
                        out_file.write(response.read())
                    descargado = True
                except Exception as e:
                    pass
            
            if not descargado:
                ruta_extension = ""
            time.sleep(0.5)

        alt_limpia = {
            "nombre": alt["nombre"], "licencia": alt["licencia"], "estrellas": alt["estrellas"],
            "plataformas": alt["plataformas"], "descripcion": alt["descripcion"],
            "por_que": alt["por_que"], "url": alt["url"], "icono": ruta_extension
        }
        base_final[web_privativa]["alternativas"].append(alt_limpia)

with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_final, f, indent=2, ensure_ascii=False)

print("🎉 Base de datos generada.")
