#!/bin/bash

echo "⚙️ [Conciencia Libre] Añadiendo Bloque 10 Final: Sistemas, Utilidades y Meta-Herramientas (10 URLs)..."

cat << 'EOF' > scripts/generar_bd10.py
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

# SEMILLA BLOQUE 10: Sistemas, Utilidades y Meta-Herramientas
nuevos_datos = {
    "google.com/drive": {
        "privativo": "Google Drive",
        "alternativas": [
            {"nombre": "Nextcloud", "licencia": "AGPLv3", "estrellas": "24k", "plataformas": ["Web", "Win", "Mac", "Linux"], "descripcion": "Tu propia nube privada con control absoluto de tus archivos.", "por_que": ["Privacidad garantizada.", "Sin minería de datos."], "url": "https://nextcloud.com/"},
            {"nombre": "Filen", "licencia": "GPLv3", "estrellas": "1k", "plataformas": ["Web", "Desktop"], "descripcion": "Almacenamiento en la nube con cifrado de extremo a extremo de código abierto.", "por_que": ["Seguridad máxima.", "Sede en Alemania (GDPR strico)."], "url": "https://filen.io/"}
        ]
    },
    "onedrive.live.com": {
        "privativo": "Microsoft OneDrive",
        "alternativas": [
            {"nombre": "Seafile", "licencia": "GPLv2", "estrellas": "12k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Almacenamiento en la nube de alto rendimiento para equipos profesionales.", "por_que": ["Sincronización ultra-rápida.", "Fiabilidad empresarial."], "url": "https://www.seafile.com/"}
        ]
    },
    "github.com": {
        "privativo": "GitHub (Propiedad de Microsoft)",
        "alternativas": [
            {"nombre": "GitLab", "licencia": "MIT", "estrellas": "22k", "plataformas": ["Web", "Self-hosted"], "descripcion": "Plataforma completa de DevOps y gestión de repositorios.", "por_que": ["Ciclo de vida completo del software.", "Auto-alojable para máxima soberanía."], "url": "https://about.gitlab.com/"},
            {"nombre": "Forgejo", "licencia": "MIT", "estrellas": "4k", "plataformas": ["Linux", "Web"], "descripcion": "Forja de software ligera, rápida y verdaderamente comunitaria.", "por_que": ["Sin intereses corporativos.", "Muy bajo consumo de recursos."], "url": "https://forgejo.org/"}
        ]
    },
    "chatgpt.com": {
        "privativo": "ChatGPT (OpenAI)",
        "alternativas": [
            {"nombre": "Hugging Face Chat", "licencia": "Apache 2.0", "estrellas": "N/A", "plataformas": ["Web"], "descripcion": "Interfaz de chat que utiliza los mejores modelos abiertos (Llama, Mistral).", "por_que": ["Modelos transparentes.", "Comunidad abierta de IA."], "url": "https://huggingface.co/chat/"},
            {"nombre": "Ollama", "licencia": "MIT", "estrellas": "70k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Ejecuta potentes modelos de lenguaje localmente en tu ordenador.", "por_que": ["Tus conversaciones nunca salen de tu PC.", "Funciona offline."], "url": "https://ollama.com/"}
        ]
    },
    "grammarly.com": {
        "privativo": "Grammarly",
        "alternativas": [
            {"nombre": "LanguageTool", "licencia": "LGPL 2.1", "estrellas": "12k", "plataformas": ["Web", "Extensión"], "descripcion": "Corrector ortográfico y gramatical multilingüe de código abierto.", "por_que": ["Soporta más de 30 idiomas.", "Respetuoso con la privacidad del texto."], "url": "https://languagetool.org/"}
        ]
    },
    "bitly.com": {
        "privativo": "Bitly",
        "alternativas": [
            {"nombre": "Shlink", "licencia": "MIT", "estrellas": "3k", "plataformas": ["Self-hosted"], "descripcion": "Acortador de URLs auto-alojable con estadísticas detalladas.", "por_que": ["Tú eres el dueño de tus enlaces.", "Sin límites de clics ni cuotas."], "url": "https://shlink.io/"},
            {"nombre": "Kutt", "licencia": "MIT", "estrellas": "8k", "plataformas": ["Web", "Linux"], "descripcion": "Acortador de enlaces moderno y minimalista.", "por_que": ["Interfaz limpia.", "Soporta dominios personalizados."], "url": "https://kutt.it/"}
        ]
    },
    "linktr.ee": {
        "privativo": "Linktree",
        "alternativas": [
            {"nombre": "LittleLink", "licencia": "MIT", "estrellas": "5k", "plataformas": ["Web", "Self-hosted"], "descripcion": "Página de enlaces personalizada, ligera y libre.", "por_que": ["Sin rastreadores de terceros.", "Fácil de desplegar."], "url": "https://littlelink.io/"}
        ]
    },
    "mcafee.com": {
        "privativo": "McAfee Antivirus",
        "alternativas": [
            {"nombre": "ClamAV", "licencia": "GPL 2.0", "estrellas": "N/A", "plataformas": ["Win", "Linux"], "descripcion": "Motor antivirus de código abierto estándar para detectar malware.", "por_que": ["Sin procesos en segundo plano intrusivos.", "Base de datos comunitaria."], "url": "https://www.clamav.net/"}
        ]
    },
    "norton.com": {
        "privativo": "Norton Antivirus",
        "alternativas": [
            {"nombre": "OpenSnitch", "licencia": "GPLv3", "estrellas": "10k", "plataformas": ["Linux"], "descripcion": "Firewall a nivel de aplicación para controlar qué hace cada programa.", "por_que": ["Transparencia total de red.", "Protección contra telemetría."], "url": "https://github.com/evilsocket/opensnitch"}
        ]
    },
    "logmein.com": {
        "privativo": "LogMeIn",
        "alternativas": [
            {"nombre": "MeshCentral", "licencia": "Apache 2.0", "estrellas": "5k", "plataformas": ["Web", "Linux"], "descripcion": "Plataforma completa de gestión y control remoto de dispositivos.", "por_que": ["Soporte multi-plataforma total.", "Control total del servidor de gestión."], "url": "https://meshcentral.com/"}
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

print(f"🤖 Procesando logos finales (Bloque 10)...")
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
                print(f"   📥 Logo: {alt['nombre']}")
                req = urllib.request.Request(url_logo, headers=headers)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                    f.write(r.read())
            except:
                try:
                    url_fb = f"https://www.google.com/s2/favicons?domain={dominio}&sz=128"
                    req = urllib.request.Request(url_fb, headers=headers)
                    with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                        f.write(r.read())
                except:
                    alt["icono"] = ""
            time.sleep(0.5)

with open(ruta_json, 'w', encoding='utf-8') as f:
    json.dump(base_datos, f, indent=2, ensure_ascii=False)

print("🎉 ¡Base de datos COMPLETADA! 100% de los bloques integrados.")
EOF

python3 scripts/generar_bd10.py
