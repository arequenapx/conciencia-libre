#!/bin/bash

echo "💬 [Conciencia Libre] Añadiendo Bloque 5: Comunicación y Colaboración (10 URLs)..."

cat << 'EOF' > scripts/generar_bd5.py
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

# SEMILLA BLOQUE 5: Comunicación y Colaboración
nuevos_datos = {
    "zoom.us": {
        "privativo": "Zoom",
        "alternativas": [
            {"nombre": "Jitsi Meet", "licencia": "Apache 2.0", "estrellas": "20k", "plataformas": ["Web", "Android", "iOS"], "descripcion": "Videollamadas seguras, totalmente gratuitas y sin cuentas.", "por_que": ["Sin límites de tiempo.", "No requiere instalación de software."], "url": "https://meet.jit.si/"},
            {"nombre": "BigBlueButton", "licencia": "LGPL 3.0", "estrellas": "8k", "plataformas": ["Web"], "descripcion": "Sistema de conferencias web enfocado en el e-learning.", "por_que": ["Pizarra multiusuario.", "Integración con Moodle."], "url": "https://bigbluebutton.org/"}
        ]
    },
    "webex.com": {
        "privativo": "Cisco Webex",
        "alternativas": [
            {"nombre": "Jitsi Meet", "licencia": "Apache 2.0", "estrellas": "20k", "plataformas": ["Web"], "descripcion": "Alternativa ligera y segura a las grandes plataformas corporativas.", "por_que": ["Privacidad por diseño.", "Fácil de usar."], "url": "https://meet.jit.si/"}
        ]
    },
    "skype.com": {
        "privativo": "Skype",
        "alternativas": [
            {"nombre": "Linphone", "licencia": "GPL 3.0", "estrellas": "2k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Software de voz sobre IP (VoIP) y videollamadas estándar.", "por_que": ["Uso de protocolos abiertos (SIP).", "Cifrado de llamadas."], "url": "https://www.linphone.org/"}
        ]
    },
    "microsoft.com/microsoft-teams": {
        "privativo": "Microsoft Teams",
        "alternativas": [
            {"nombre": "Mattermost", "licencia": "AGPL 3.0", "estrellas": "26k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Plataforma de colaboración empresarial segura y flexible.", "por_que": ["Soberanía de datos.", "Autogestionado."], "url": "https://mattermost.com/"},
            {"nombre": "Zulip", "licencia": "Apache 2.0", "estrellas": "19k", "plataformas": ["Web", "Desktop"], "descripcion": "Chat en tiempo real con organización por hilos eficiente.", "por_que": ["Productividad sin distracciones.", "Ideal para equipos remotos."], "url": "https://zulip.com/"}
        ]
    },
    "slack.com": {
        "privativo": "Slack",
        "alternativas": [
            {"nombre": "Element", "licencia": "Apache 2.0", "estrellas": "18k", "plataformas": ["Win", "Mac", "Linux", "Móvil"], "descripcion": "Comunicación descentralizada y cifrada basada en Matrix.", "por_que": ["Sin servidores centrales obligatorios.", "Cifrado de extremo a extremo."], "url": "https://element.io/"},
            {"nombre": "Rocket.Chat", "licencia": "MIT", "estrellas": "35k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Centro de comunicación omnicanal totalmente personalizable.", "por_que": ["Control total del servidor.", "Integraciones infinitas."], "url": "https://rocket.chat/"}
        ]
    },
    "whatsapp.com": {
        "privativo": "WhatsApp",
        "alternativas": [
            {"nombre": "Signal", "licencia": "GPL 3.0", "estrellas": "30k", "plataformas": ["Android", "iOS", "Desktop"], "descripcion": "Mensajería privada recomendada por expertos en seguridad.", "por_que": ["Sin ánimo de lucro.", "Cero rastreo de metadatos."], "url": "https://signal.org/"},
            {"nombre": "Session", "licencia": "GPL 3.0", "estrellas": "2k", "plataformas": ["Móvil", "Desktop"], "descripcion": "Mensajería sin número de teléfono, totalmente anónima.", "por_que": ["Basado en red cebolla.", "Privacidad extrema."], "url": "https://getsession.org/"}
        ]
    },
    "discord.com": {
        "privativo": "Discord",
        "alternativas": [
            {"nombre": "Revolt", "licencia": "AGPL 3.0", "estrellas": "10k", "plataformas": ["Web", "Desktop"], "descripcion": "La alternativa moderna y libre a Discord.", "por_que": ["Respeto a la privacidad.", "Interfaz familiar."], "url": "https://revolt.chat/"},
            {"nombre": "Mumble", "licencia": "BSD", "estrellas": "9k", "plataformas": ["Desktop", "Móvil"], "descripcion": "Chat de voz de baja latencia para juegos.", "por_que": ["Sonido de alta calidad.", "Uso mínimo de recursos."], "url": "https://www.mumble.info/"}
        ]
    },
    "viber.com": {
        "privativo": "Viber",
        "alternativas": [
            {"nombre": "Signal", "licencia": "GPL 3.0", "estrellas": "30k", "plataformas": ["Móvil"], "descripcion": "Alternativa ética para llamadas y mensajes gratuitos.", "por_que": ["Transparente y auditado.", "Seguridad máxima."], "url": "https://signal.org/"}
        ]
    },
    "gotomeeting.com": {
        "privativo": "GoToMeeting",
        "alternativas": [
            {"nombre": "Jam", "licencia": "MIT", "estrellas": "1k", "plataformas": ["Web"], "descripcion": "Videollamadas grupales rápidas y sencillas.", "por_que": ["Minimalista.", "Sin registro."], "url": "https://jam.systems/"}
        ]
    },
    "bluejeans.com": {
        "privativo": "BlueJeans",
        "alternativas": [
            {"nombre": "Jitsi Meet", "licencia": "Apache 2.0", "estrellas": "20k", "plataformas": ["Web"], "descripcion": "Solución de nivel profesional para conferencias web libres.", "por_que": ["Escalable.", "Sin cuotas de suscripción."], "url": "https://meet.jit.si/"}
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

print(f"🤖 Procesando logos para el Bloque 5...")
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

print("🎉 Bloque 5 integrado.")
EOF

python3 scripts/generar_bd5.py
