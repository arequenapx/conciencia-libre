import json
import os
import random

ruta_json = 'fuente_datos.json'

# Diccionario con motivos específicos para las "Estrellas" de la presentación
motivos_especificos = {
    "GIMP": [
        "Sin suscripciones mensuales abusivas (Adobe Creative Cloud).",
        "Altamente personalizable mediante scripts y extensiones libres."
    ],
    "Krita": [
        "Diseñado específicamente por y para ilustradores y artistas conceptuales.",
        "Motor de pinceles avanzado sin requerir hardware restrictivo."
    ],
    "PhotoFlow": [
        "Edición no destructiva que rivaliza con Lightroom.",
        "Procesamiento de imágenes RAW sin telemetría de Adobe."
    ],
    "LibreOffice Writer": [
        "Uso estricto de formatos OpenDocument (estándar ISO).",
        "Privacidad total: tus textos no se analizan en la nube corporativa."
    ],
    "Ubuntu": [
        "Ausencia de keyloggers y publicidad integrada en el sistema.",
        "Gestión de paquetes centralizada y segura frente a malware."
    ],
    "VLC media player": [
        "Reproduce cualquier formato sin necesidad de descargar códecs oscuros.",
        "Ligero, sin anuncios y respaldado por una fundación sin ánimo de lucro."
    ],
    "OBS Studio": [
        "Estándar de la industria para streaming sin coste de licencias.",
        "Grabación y transmisión sin marcas de agua ni límites de tiempo."
    ],
    "Mozilla Firefox": [
        "Motor de renderizado independiente que combate el monopolio de Chromium.",
        "Bloqueo avanzado de rastreadores y cookies de terceros por defecto."
    ]
}

# Razones genéricas de alta calidad para el resto del software libre
motivos_genericos = [
    "Código abierto y auditable por la comunidad de forma independiente.",
    "Respeta tu privacidad al no incluir módulos de telemetría oculta.",
    "Libre de modelos de suscripción, licencias abusivas y pagos recurrentes.",
    "Fomenta la soberanía tecnológica y el control real sobre tu equipo.",
    "Evita la dependencia tecnológica (vendor lock-in) con formatos estándar.",
    "Mayor eficiencia energética y menor consumo de recursos del sistema."
]

def enriquecer():
    if not os.path.exists(ruta_json):
        print("❌ Error: No se encuentra fuente_datos.json")
        return

    with open(ruta_json, 'r', encoding='utf-8') as f:
        db = json.load(f)

    programas_actualizados = 0

    for priv_url, info in db.items():
        for alt in info.get("alternativas", []):
            # Solo actualizar si no tiene "por_que" o si está vacío
            if "por_que" not in alt or not alt["por_que"]:
                nombre_alt = alt.get("nombre", "")
                
                # Si está en la lista de estrellas, le ponemos sus motivos
                if nombre_alt in motivos_especificos:
                    alt["por_que"] = motivos_especificos[nombre_alt]
                else:
                    # Si no, elegimos 2 motivos genéricos aleatorios pero coherentes
                    alt["por_que"] = random.sample(motivos_genericos, 2)
                
                programas_actualizados += 1

    with open(ruta_json, 'w', encoding='utf-8') as f:
        json.dump(db, f, indent=2, ensure_ascii=False)

    print(f"✨ ¡Enriquecimiento completado!")
    print(f"✅ Se han inyectado motivos éticos y técnicos a {programas_actualizados} alternativas.")

if __name__ == "__main__":
    enriquecer()
