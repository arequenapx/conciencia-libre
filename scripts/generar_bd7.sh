#!/bin/bash

echo "🛡️ [Conciencia Libre] Añadiendo Bloque 7: Seguridad, Utilidades y Almacenamiento (10 URLs)..."

cat << 'EOF' > scripts/generar_bd7.py
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

# SEMILLA BLOQUE 7: Seguridad, Utilidades y Almacenamiento
nuevos_datos = {
    "win-rar.com": {
        "privativo": "WinRAR",
        "alternativas": [
            {"nombre": "7-Zip", "licencia": "LGPL", "estrellas": "N/A", "plataformas": ["Win", "Linux"], "descripcion": "Archivador de archivos con una alta tasa de compresión.", "por_que": ["Totalmente gratuito y libre.", "Soporta casi todos los formatos."], "url": "https://www.7-zip.org/"},
            {"nombre": "PeaZip", "licencia": "LGPLv3", "estrellas": "4k", "plataformas": ["Win", "Linux", "Mac"], "descripcion": "Herramienta de compresión con interfaz moderna y segura.", "por_que": ["Gestor de contraseñas integrado.", "Borrado seguro de archivos."], "url": "https://peazip.github.io/"}
        ]
    },
    "winzip.com": {
        "privativo": "WinZip",
        "alternativas": [
            {"nombre": "7-Zip", "licencia": "LGPL", "estrellas": "N/A", "plataformas": ["Win", "Linux"], "descripcion": "La alternativa más eficiente y ligera para comprimir archivos.", "por_que": ["Sin anuncios ni periodos de prueba.", "Soporta formato .7z de alta densidad."], "url": "https://www.7-zip.org/"}
        ]
    },
    "1password.com": {
        "privativo": "1Password",
        "alternativas": [
            {"nombre": "Bitwarden", "licencia": "GPLv3", "estrellas": "25k", "plataformas": ["Multiplataforma"], "descripcion": "Gestor de contraseñas de código abierto para individuos y empresas.", "por_que": ["Sincronización en la nube segura.", "Auditado por terceros."], "url": "https://bitwarden.com/"},
            {"nombre": "KeePassXC", "licencia": "GPLv2", "estrellas": "18k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Gestor de contraseñas offline para máxima privacidad local.", "por_que": ["Tú eres dueño de tu base de datos.", "Sin dependencia de la nube."], "url": "https://keepassxc.org/"}
        ]
    },
    "dashlane.com": {
        "privativo": "Dashlane",
        "alternativas": [
            {"nombre": "Bitwarden", "licencia": "GPLv3", "estrellas": "25k", "plataformas": ["Multiplataforma"], "descripcion": "Solución ética y transparente para gestionar tus credenciales.", "por_que": ["Código fuente disponible públicamente.", "Funciones premium a precio justo."], "url": "https://bitwarden.com/"}
        ]
    },
    "dropbox.com": {
        "privativo": "Dropbox",
        "alternativas": [
            {"nombre": "Nextcloud", "licencia": "AGPLv3", "estrellas": "24k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Plataforma de colaboración y almacenamiento autogestionada.", "por_que": ["Tus archivos en tu propio servidor.", "Cientos de extensiones disponibles."], "url": "https://nextcloud.com/"},
            {"nombre": "Syncthing", "licencia": "MPL 2.0", "estrellas": "60k", "plataformas": ["Win", "Mac", "Linux", "Android"], "descripcion": "Sincronización de archivos continua y descentralizada.", "por_que": ["Sin servidores centrales.", "Privacidad P2P extrema."], "url": "https://syncthing.net/"}
        ]
    },
    "box.com": {
        "privativo": "Box",
        "alternativas": [
            {"nombre": "Seafile", "licencia": "GPLv2", "estrellas": "12k", "plataformas": ["Desktop", "Server"], "descripcion": "Sincronización de archivos de alto rendimiento para equipos.", "por_que": ["Velocidad de sincronización superior.", "Enfoque en la fiabilidad de datos."], "url": "https://www.seafile.com/"}
        ]
    },
    "icloud.com": {
        "privativo": "iCloud Storage",
        "alternativas": [
            {"nombre": "Nextcloud", "licencia": "AGPLv3", "estrellas": "24k", "plataformas": ["Web", "Móvil"], "descripcion": "Alternativa soberana a la nube de Apple.", "por_que": ["Tú controlas las claves de cifrado.", "Compatible con calendarios y contactos."], "url": "https://nextcloud.com/"}
        ]
    },
    "ccleaner.com": {
        "privativo": "CCleaner",
        "alternativas": [
            {"nombre": "BleachBit", "licencia": "GPLv3", "estrellas": "3k", "plataformas": ["Win", "Linux"], "descripcion": "Limpia rápidamente el disco y protege tu privacidad.", "por_que": ["Totalmente libre de bloatware.", "Tritura archivos para evitar recuperación."], "url": "https://www.bleachbit.org/"},
            {"nombre": "Stacer", "licencia": "MIT", "estrellas": "10k", "plataformas": ["Linux"], "descripcion": "Optimizador de sistema y monitor de recursos todo en uno.", "por_que": ["Interfaz visual moderna.", "Control total de servicios."], "url": "https://github.com/oguzhaninan/Stacer"}
        ]
    },
    "teamviewer.com": {
        "privativo": "TeamViewer",
        "alternativas": [
            {"nombre": "RustDesk", "licencia": "AGPLv3", "estrellas": "65k", "plataformas": ["Win", "Mac", "Linux", "Android"], "descripcion": "Infraestructura de escritorio remoto de código abierto.", "por_que": ["Funciona sin configuración.", "Permite usar tu propio servidor de relay."], "url": "https://rustdesk.com/"}
        ]
    },
    "anydesk.com": {
        "privativo": "AnyDesk",
        "alternativas": [
            {"nombre": "RustDesk", "licencia": "AGPLv3", "estrellas": "65k", "plataformas": ["Multiplataforma"], "descripcion": "La alternativa más rápida y segura al acceso remoto privativo.", "por_que": ["Código auditable.", "Seguridad de nivel empresarial."], "url": "https://rustdesk.com/"}
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

print(f"🤖 Procesando logos para el Bloque 7...")
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

print("🎉 Bloque 7 integrado correctamente.")
EOF

python3 scripts/generar_bd7.py
