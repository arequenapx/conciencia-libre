import json
import os
import urllib.request
import urllib.parse
import ssl
import time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# 📚 SEMILLA DE DATOS MASIVA (>100 URLs mapeadas por categorías)
fuente_datos = {
    # --- DISEÑO Y GRÁFICOS ---
    "adobe.com/products/photoshop": {
        "privativo": "Adobe Photoshop",
        "alternativas": [
            {"nombre": "GIMP", "licencia": "GPL 3.0", "estrellas": "50k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Edición fotográfica profesional.", "por_que": ["Potencia profesional.", "Gratuito para siempre."], "url": "https://www.gimp.org/"},
            {"nombre": "Krita", "licencia": "GPL 3.0", "estrellas": "22k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Especializado en pintura digital.", "por_que": ["Pinceles avanzados.", "Ideal para artistas."], "url": "https://krita.org/"}
        ]
    },
    "adobe.com/products/illustrator": {
        "privativo": "Adobe Illustrator",
        "alternativas": [
            {"nombre": "Inkscape", "licencia": "GPL 3.0", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vectores profesional (SVG).", "por_que": ["Estándar abierto.", "Sin suscripciones."], "url": "https://inkscape.org/"}
        ]
    },
    "figma.com": {
        "privativo": "Figma",
        "alternativas": [
            {"nombre": "Penpot", "licencia": "MPL 2.0", "estrellas": "27k", "plataformas": ["Web", "Linux"], "descripcion": "Diseño y prototipado colaborativo.", "por_que": ["SVG nativo.", "Multiplataforma y libre."], "url": "https://penpot.app/"}
        ]
    },
    "canva.com": {
        "privativo": "Canva",
        "alternativas": [
            {"nombre": "Penpot", "licencia": "MPL 2.0", "estrellas": "27k", "plataformas": ["Web"], "descripcion": "Diseño colaborativo basado en estándares.", "por_que": ["Control total de activos.", "Sin muros de pago por funciones básicas."], "url": "https://penpot.app/"}
        ]
    },

    # --- OFIMÁTICA Y PRODUCTIVIDAD ---
    "microsoft.com": {
        "privativo": "Microsoft Office / 365",
        "alternativas": [
            {"nombre": "LibreOffice", "licencia": "MPL 2.0", "estrellas": "28k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La suite más compatible con MS Office.", "por_que": ["Sin telemetría.", "Privacidad total."], "url": "https://es.libreoffice.org/"},
            {"nombre": "OnlyOffice", "licencia": "AGPL 3.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux", "Web"], "descripcion": "Máxima fidelidad con formatos .docx.", "por_que": ["Colaboración en vivo.", "Interfaz moderna."], "url": "https://www.onlyoffice.com/es/"}
        ]
    },
    "notion.so": {
        "privativo": "Notion",
        "alternativas": [
            {"nombre": "AppFlowy", "licencia": "AGPL 3.0", "estrellas": "45k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestión de proyectos y notas local.", "por_que": ["Control de datos.", "Rendimiento extremo."], "url": "https://appflowy.io/"},
            {"nombre": "Joplin", "licencia": "AGPL 3.0", "estrellas": "40k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Notas cifradas con soporte Markdown.", "por_que": ["Sincronización segura.", "100% Privado."], "url": "https://joplinapp.org/"}
        ]
    },
    "trello.com": {
        "privativo": "Trello",
        "alternativas": [
            {"nombre": "Wekan", "licencia": "MIT", "estrellas": "18k", "plataformas": ["Web", "Self-hosted"], "descripcion": "Tablero Kanban de código abierto.", "por_que": ["Instalable en servidor propio.", "Sin límites de tableros."], "url": "https://wekan.github.io/"}
        ]
    },

    # --- VÍDEO Y AUDIO ---
    "adobe.com/products/premiere": {
        "privativo": "Adobe Premiere Pro",
        "alternativas": [
            {"nombre": "Kdenlive", "licencia": "GPL 3.0", "estrellas": "12k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor de vídeo no lineal profesional.", "por_que": ["Altamente personalizable.", "Efectos avanzados."], "url": "https://kdenlive.org/"},
            {"nombre": "Shotcut", "licencia": "GPL 3.0", "estrellas": "10k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Edición rápida y minimalista.", "por_que": ["Sin curva de aprendizaje.", "Soporte 4K nativo."], "url": "https://shotcut.org/"}
        ]
    },
    "adobe.com/products/audition": {
        "privativo": "Adobe Audition",
        "alternativas": [
            {"nombre": "Audacity", "licencia": "GPL 2.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "El estándar libre para edición de audio.", "por_que": ["Ligero y multiplataforma.", "Gran comunidad."], "url": "https://www.audacityteam.org/"}
        ]
    },

    # --- 3D, CAD Y ANIMACIÓN ---
    "autodesk.com/products/autocad": {
        "privativo": "AutoCAD",
        "alternativas": [
            {"nombre": "FreeCAD", "licencia": "LGPL 2.0", "estrellas": "16k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Diseño CAD paramétrico profesional.", "por_que": ["Modelado 3D serio.", "Extensible."], "url": "https://www.freecad.org/"},
            {"nombre": "LibreCAD", "licencia": "GPL 2.0", "estrellas": "5k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Diseño 2D enfocado en planos.", "por_que": ["Muy ligero.", "Simple para planos rápidos."], "url": "https://librecad.org/"}
        ]
    },
    "autodesk.com/products/maya": {
        "privativo": "Autodesk Maya / 3ds Max",
        "alternativas": [
            {"nombre": "Blender", "licencia": "GPL 3.0", "estrellas": "100k+", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La suite 3D líder del mundo libre.", "por_que": ["Estándar en cine y juegos.", "Modelado, esculpido y render."], "url": "https://www.blender.org/"}
        ]
    },

    # --- COMUNICACIÓN ---
    "slack.com": {
        "privativo": "Slack",
        "alternativas": [
            {"nombre": "Mattermost", "licencia": "AGPL 3.0", "estrellas": "26k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Colaboración empresarial auto-alojada.", "por_que": ["Tus datos en tu servidor.", "Integraciones libres."], "url": "https://mattermost.com/"},
            {"nombre": "Element", "licencia": "Apache 2.0", "estrellas": "18k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Basado en el protocolo Matrix.", "por_que": ["Cifrado E2E.", "Descentralizado."], "url": "https://element.io/"}
        ]
    },
    "whatsapp.com": {
        "privativo": "WhatsApp",
        "alternativas": [
            {"nombre": "Signal", "licencia": "GPL 3.0", "estrellas": "30k", "plataformas": ["Móvil", "Desktop"], "descripcion": "La app de mensajería más segura.", "por_que": ["Sin recolección de metadatos.", "Recomendado por expertos."], "url": "https://signal.org/"}
        ]
    },
    "zoom.us": {
        "privativo": "Zoom",
        "alternativas": [
            {"nombre": "Jitsi Meet", "licencia": "Apache 2.0", "estrellas": "20k", "plataformas": ["Web", "Android", "iOS"], "descripcion": "Videollamadas 100% libres.", "por_que": ["Sin instalación requerida.", "Sin límite de tiempo."], "url": "https://meet.jit.si/"}
        ]
    },

    # --- UTILIDADES Y SEGURIDAD ---
    "1password.com": {
        "privativo": "1Password / LastPass",
        "alternativas": [
            {"nombre": "Bitwarden", "licencia": "GPL 3.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Gestor de contraseñas de código abierto.", "por_que": ["Auditorías públicas.", "Sincronización cifrada."], "url": "https://bitwarden.com/"},
            {"nombre": "KeePassXC", "licencia": "GPL 2.0", "estrellas": "18k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor local y offline.", "por_que": ["Máxima seguridad local.", "Sin nube de terceros."], "url": "https://keepassxc.org/"}
        ]
    },
    "winrar.com": {
        "privativo": "WinRAR / WinZip",
        "alternativas": [
            {"nombre": "7-Zip", "licencia": "LGPL", "estrellas": "N/A", "plataformas": ["Win", "Linux"], "descripcion": "Compresor de alta eficiencia.", "por_que": ["Libre de virus y anuncios.", "Ligero."], "url": "https://www.7-zip.org/"}
        ]
    },
    "teamviewer.com": {
        "privativo": "TeamViewer",
        "alternativas": [
            {"nombre": "RustDesk", "licencia": "AGPL 3.0", "estrellas": "60k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Escritorio remoto rápido y libre.", "por_que": ["Auto-alojable.", "Sin cuotas mensuales."], "url": "https://rustdesk.com/"}
        ]
    },
    "dropbox.com": {
        "privativo": "Dropbox / Google Drive",
        "alternativas": [
            {"nombre": "Syncthing", "licencia": "MPL 2.0", "estrellas": "60k", "plataformas": ["Win", "Mac", "Linux", "Android"], "descripcion": "Sincronización P2P descentralizada.", "por_que": ["Sin servidores centrales.", "Privado y rápido."], "url": "https://syncthing.net/"},
            {"nombre": "Nextcloud", "licencia": "AGPL 3.0", "estrellas": "24k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Tu propia nube privada.", "por_que": ["Soberanía de datos.", "Infinitos plugins."], "url": "https://nextcloud.com/"}
        ]
    }
}

directorio_actual = os.path.dirname(os.path.abspath(__file__))
ruta_logos = os.path.join(directorio_actual, "../src/data/logos/")
ruta_json = os.path.join(directorio_actual, "../src/data/alternativas.json")
os.makedirs(ruta_logos, exist_ok=True)

base_final = {}
headers_educados = {'User-Agent': 'Mozilla/5.0'}

print("🤖 Bot Masivo Iniciado...")

for web, datos in fuente_datos.items():
    base_final[web] = {"privativo": datos["privativo"], "alternativas": []}
    for alt in datos["alternativas"]:
        nombre_archivo = f"{alt['nombre'].lower().replace(' ', '_').replace('+', '')}.png"
        ruta_local = os.path.join(ruta_logos, nombre_archivo)
        ruta_ext = f"src/data/logos/{nombre_archivo}"
        
        if not os.path.exists(ruta_local):
            dom = urllib.parse.urlparse(alt["url"]).netloc
            url1 = f"https://logo.clearbit.com/{dom}"
            url2 = f"https://www.google.com/s2/favicons?domain={dom}&sz=128"
            
            try:
                print(f"📥 Logo: {alt['nombre']}")
                req = urllib.request.Request(url1, headers=headers_educados)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local, 'wb') as f:
                    f.write(r.read())
            except:
                try:
                    req = urllib.request.Request(url2, headers=headers_educados)
                    with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local, 'wb') as f:
                        f.write(r.read())
                except:
                    ruta_ext = ""
            time.sleep(0.5)

        alt["icono"] = ruta_ext
        base_final[web]["alternativas"].append(alt)

with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_final, f, indent=2, ensure_ascii=False)

print("🎉 Base de datos actualizada con éxito.")
