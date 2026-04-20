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

# SEMILLA BLOQUE 6: Desarrollo e Infraestructura
nuevos_datos = {
    "jetbrains.com/idea": {
        "privativo": "IntelliJ IDEA",
        "alternativas": [
            {"nombre": "VSCodium", "licencia": "MIT", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Binarios de VS Code 100% libres de telemetría y trackers.", "por_que": ["Sin rastreo de Microsoft.", "Totalmente abierto."], "url": "https://vscodium.com/"},
            {"nombre": "Eclipse IDE", "licencia": "EPL 2.0", "estrellas": "5k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "El entorno de desarrollo clásico para Java y empresa.", "por_que": ["Extremadamente extensible.", "Arquitectura probada."], "url": "https://www.eclipse.org/"}
        ]
    },
    "jetbrains.com/webstorm": {
        "privativo": "WebStorm",
        "alternativas": [
            {"nombre": "VSCodium", "licencia": "MIT", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Editor ligero y potente para desarrollo web moderno.", "por_que": ["Gran ecosistema de extensiones.", "Rapidez de desarrollo."], "url": "https://vscodium.com/"}
        ]
    },
    "jetbrains.com/pycharm": {
        "privativo": "PyCharm",
        "alternativas": [
            {"nombre": "Spyder", "licencia": "MIT", "estrellas": "8k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "IDE potente para científicos, ingenieros y analistas de datos.", "por_que": ["Integración con Conda.", "Explorador de variables avanzado."], "url": "https://www.spyder-ide.org/"}
        ]
    },
    "sublimetext.com": {
        "privativo": "Sublime Text",
        "alternativas": [
            {"nombre": "Pulsar", "licencia": "MIT", "estrellas": "3k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Continuación comunitaria del editor Atom, altamente hackeable.", "por_que": ["Personalización infinita.", "Comunidad abierta."], "url": "https://pulsar-edit.dev/"},
            {"nombre": "Micro", "licencia": "MIT", "estrellas": "22k", "plataformas": ["Terminal"], "descripcion": "Editor basado en terminal moderno e intuitivo.", "por_que": ["Uso nativo de ratón.", "Sencillo y ligero."], "url": "https://micro-editor.github.io/"}
        ]
    },
    "navicat.com": {
        "privativo": "Navicat",
        "alternativas": [
            {"nombre": "DBeaver", "licencia": "Apache 2.0", "estrellas": "35k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Herramienta de base de datos universal para desarrolladores y administradores.", "por_que": ["Soporta SQL, NoSQL y Cloud.", "Visualizador ER integrado."], "url": "https://dbeaver.io/"},
            {"nombre": "Beekeeper Studio", "licencia": "GPL 3.0", "estrellas": "15k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor de bases de datos moderno, limpio y fácil de usar.", "por_que": ["Interfaz minimalista.", "Enfocado en la experiencia de usuario."], "url": "https://www.beekeeperstudio.io/"}
        ]
    },
    "postman.com": {
        "privativo": "Postman",
        "alternativas": [
            {"nombre": "Bruno", "licencia": "MIT", "estrellas": "25k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Cliente API rápido y ligero que almacena colecciones localmente.", "por_que": ["Control total de tus datos.", "Sin necesidad de cuenta en la nube."], "url": "https://www.usebruno.com/"},
            {"nombre": "Hoppscotch", "licencia": "MIT", "estrellas": "60k", "plataformas": ["Web", "Desktop"], "descripcion": "Ecosistema de desarrollo de APIs ligero y de código abierto.", "por_que": ["Basado en la web.", "Muy rápido."], "url": "https://hoppscotch.io/"}
        ]
    },
    "docker.com/products/docker-desktop": {
        "privativo": "Docker Desktop",
        "alternativas": [
            {"nombre": "Podman Desktop", "licencia": "Apache 2.0", "estrellas": "6k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestión de contenedores sin demonios, segura y compatible con Docker.", "por_que": ["Sin procesos root necesarios.", "Compatible con imágenes Docker."], "url": "https://podman-desktop.io/"}
        ]
    },
    "vmware.com/products/workstation-pro": {
        "privativo": "VMware Workstation",
        "alternativas": [
            {"nombre": "VirtualBox", "licencia": "GPL 2.0", "estrellas": "N/A", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La solución líder de código abierto para virtualización x86.", "por_que": ["Gran comunidad.", "Soporta casi cualquier SO."], "url": "https://www.virtualbox.org/"}
        ]
    },
    "parallels.com": {
        "privativo": "Parallels Desktop",
        "alternativas": [
            {"nombre": "UTM", "licencia": "Apache 2.0", "estrellas": "25k", "plataformas": ["Mac", "iOS"], "descripcion": "Máquinas virtuales para Mac basadas en QEMU.", "por_que": ["Optimizado para Apple Silicon.", "Interfaz nativa y limpia."], "url": "https://getutm.app/"}
        ]
    },
    "oracle.com/database": {
        "privativo": "Oracle Database",
        "alternativas": [
            {"nombre": "PostgreSQL", "licencia": "PostgreSQL License", "estrellas": "20k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "La base de datos relacional de código abierto más avanzada.", "por_que": ["Rendimiento empresarial.", "Cumplimiento estricto de SQL."], "url": "https://www.postgresql.org/"},
            {"nombre": "MariaDB", "licencia": "GPL 2.0", "estrellas": "5k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Base de datos rápida, escalable y robusta, nacida de MySQL.", "por_que": ["Desarrollada por la comunidad.", "Alta disponibilidad."], "url": "https://mariadb.org/"}
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

print(f"🤖 Procesando logos para el Bloque 6...")
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

print("🎉 Bloque 6 integrado correctamente.")
