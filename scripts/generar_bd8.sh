#!/bin/bash

echo "🌐 [Conciencia Libre] Añadiendo Bloque 8: Navegación, Marketing y CRM (10 URLs)..."

cat << 'EOF' > scripts/generar_bd8.py
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

# SEMILLA BLOQUE 8: Navegación, Marketing y CRM
nuevos_datos = {
    "google.com/chrome": {
        "privativo": "Google Chrome",
        "alternativas": [
            {"nombre": "Firefox", "licencia": "MPL 2.0", "estrellas": "N/A", "plataformas": ["Multiplataforma"], "descripcion": "Navegador rápido, privado y ético que no espía tus datos.", "por_que": ["Motor independiente (Gecko).", "Gran ecosistema de extensiones."], "url": "https://www.mozilla.org/firefox/"},
            {"nombre": "Brave", "licencia": "MPL 2.0", "estrellas": "16k", "plataformas": ["Multiplataforma"], "descripcion": "Bloquea anuncios y rastreadores de forma nativa.", "por_que": ["Basado en Chromium pero privado.", "Navegación más veloz."], "url": "https://brave.com/"}
        ]
    },
    "microsoft.com/edge": {
        "privativo": "Microsoft Edge",
        "alternativas": [
            {"nombre": "Firefox", "licencia": "MPL 2.0", "estrellas": "N/A", "plataformas": ["Multiplataforma"], "descripcion": "La alternativa libre definitiva para navegar sin telemetría de Microsoft.", "por_que": ["Menor consumo de recursos.", "Soberanía tecnológica."], "url": "https://www.mozilla.org/firefox/"}
        ]
    },
    "opera.com": {
        "privativo": "Opera",
        "alternativas": [
            {"nombre": "Vivaldi", "licencia": "Prop/Source available", "estrellas": "N/A", "plataformas": ["Multiplataforma"], "descripcion": "Navegador ultra-personalizable con enfoque en la privacidad.", "por_que": ["Sin rastreadores chinos.", "Productividad extrema."], "url": "https://vivaldi.com/"}
        ]
    },
    "analytics.google.com": {
        "privativo": "Google Analytics",
        "alternativas": [
            {"nombre": "Matomo", "licencia": "GPLv3", "estrellas": "19k", "plataformas": ["Web", "Self-hosted"], "descripcion": "La plataforma de analítica ética que te devuelve el control de tus datos.", "por_que": ["100% propiedad de los datos.", "Cumple con GDPR/RGPD de forma nativa."], "url": "https://matomo.org/"},
            {"nombre": "Plausible", "licencia": "AGPLv3", "estrellas": "17k", "plataformas": ["Web"], "descripcion": "Analítica web ligera, abierta y sin cookies.", "por_que": ["Script de <1KB.", "Privacidad absoluta para el usuario."], "url": "https://plausible.io/"}
        ]
    },
    "salesforce.com": {
        "privativo": "Salesforce CRM",
        "alternativas": [
            {"nombre": "Odoo", "licencia": "LGPLv3", "estrellas": "33k", "plataformas": ["Web", "On-premise"], "descripcion": "Suite de aplicaciones empresariales integradas (ERP/CRM).", "por_que": ["Modular y escalable.", "Gran comunidad internacional."], "url": "https://www.odoo.com/"},
            {"nombre": "SuiteCRM", "licencia": "AGPLv3", "estrellas": "4k", "plataformas": ["Web"], "descripcion": "El CRM de código abierto más popular del mundo.", "por_que": ["Sin costes de licencia por usuario.", "Altamente flexible."], "url": "https://suitecrm.com/"}
        ]
    },
    "hubspot.com": {
        "privativo": "HubSpot",
        "alternativas": [
            {"nombre": "Mautic", "licencia": "GPLv3", "estrellas": "7k", "plataformas": ["Web"], "descripcion": "La primera plataforma de automatización de marketing de código abierto.", "por_que": ["Automatización de correos sin límites.", "Tú controlas la base de datos de leads."], "url": "https://www.mautic.org/"},
            {"nombre": "ERPNext", "licencia": "GPLv3", "estrellas": "17k", "plataformas": ["Web"], "descripcion": "ERP moderno con un potente módulo de CRM y ventas.", "por_que": ["Interfaz muy limpia.", "Excelente gestión de flujos."], "url": "https://erpnext.com/"}
        ]
    },
    "mailchimp.com": {
        "privativo": "Mailchimp",
        "alternativas": [
            {"nombre": "Listmonk", "licencia": "AGPLv3", "estrellas": "14k", "plataformas": ["Server", "Linux"], "descripcion": "Gestor de newsletters y listas de correo extremadamente rápido.", "por_que": ["Soporta millones de correos.", "Uso de base de datos propia."], "url": "https://listmonk.app/"}
        ]
    },
    "intercom.com": {
        "privativo": "Intercom",
        "alternativas": [
            {"nombre": "Chatwoot", "licencia": "MIT", "estrellas": "19k", "plataformas": ["Web", "Self-hosted"], "descripcion": "Plataforma de atención al cliente omnicanal (Live Chat).", "por_que": ["Conecta WhatsApp, FB y Chat en un sitio.", "Código abierto y auditable."], "url": "https://www.chatwoot.com/"}
        ]
    },
    "zendesk.com": {
        "privativo": "Zendesk",
        "alternativas": [
            {"nombre": "Zammad", "licencia": "AGPLv3", "estrellas": "5k", "plataformas": ["Web"], "descripcion": "Sistema de Helpdesk y tickets moderno y profesional.", "por_que": ["Hilos de chat inteligentes.", "Integración telefónica."], "url": "https://zammad.org/"},
            {"nombre": "FreeScout", "licencia": "AGPLv3", "estrellas": "8k", "plataformas": ["Web"], "descripcion": "La alternativa ligera y potente a Zendesk.", "por_que": ["Interfaz similar a Help Scout.", "Sin suscripciones por agente."], "url": "https://freescout.net/"}
        ]
    },
    "shopify.com": {
        "privativo": "Shopify",
        "alternativas": [
            {"nombre": "PrestaShop", "licencia": "OSL 3.0", "estrellas": "9k", "plataformas": ["Web"], "descripcion": "Solución de comercio electrónico líder en Europa.", "por_que": ["Control total del checkout.", "Miles de módulos libres."], "url": "https://www.prestashop.com/"},
            {"nombre": "Saleor", "licencia": "BSD-3", "estrellas": "19k", "plataformas": ["Web", "Python"], "descripcion": "E-commerce moderno basado en GraphQL y Django.", "por_que": ["Alto rendimiento.", "Arquitectura headless."], "url": "https://saleor.io/"}
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

print(f"🤖 Procesando logos para el Bloque 8...")
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

print("🎉 Bloque 8 integrado correctamente.")
EOF

python3 scripts/generar_bd8.py
