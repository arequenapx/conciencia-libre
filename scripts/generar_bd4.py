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

# SEMILLA BLOQUE 4
nuevos_datos = {
    "autodesk.com/products/autocad": {
        "privativo": "AutoCAD",
        "alternativas": [
            {"nombre": "FreeCAD", "licencia": "LGPL 2.0", "estrellas": "16k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Modelador 3D paramétrico para diseño CAD y CAE.", "por_que": ["Arquitectura modular.", "Sin licencias restrictivas."], "url": "https://www.freecad.org/"},
            {"nombre": "LibreCAD", "licencia": "GPL 2.0", "estrellas": "5k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Diseño asistido por ordenador 2D de código abierto.", "por_que": ["Especializado en dibujo 2D.", "Interfaz clásica y ligera."], "url": "https://librecad.org/"}
        ]
    },
    "autodesk.com/products/revit": {
        "privativo": "Autodesk Revit (BIM)",
        "alternativas": [
            {"nombre": "FreeCAD BIM", "licencia": "LGPL 2.0", "estrellas": "16k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Módulo BIM avanzado para arquitectura y construcción.", "por_que": ["Formato nativo IFC.", "Control total de la geometría."], "url": "https://www.freecad.org/wiki/BIM_Workbench"}
        ]
    },
    "autodesk.com/products/maya": {
        "privativo": "Autodesk Maya",
        "alternativas": [
            {"nombre": "Blender", "licencia": "GPL 3.0", "estrellas": "100k+", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Suite de creación 3D líder en la industria libre.", "por_que": ["Modelado, animación y esculpido.", "Motor de renderizado Cycles."], "url": "https://www.blender.org/"}
        ]
    },
    "autodesk.com/products/3ds-max": {
        "privativo": "Autodesk 3ds Max",
        "alternativas": [
            {"nombre": "Blender", "licencia": "GPL 3.0", "estrellas": "100k+", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Potente alternativa para visualización y modelado 3D.", "por_que": ["Nodo de composición integrado.", "Comunidad masiva de addons."], "url": "https://www.blender.org/"}
        ]
    },
    "autodesk.com/products/fusion-360": {
        "privativo": "Autodesk Fusion 360",
        "alternativas": [
            {"nombre": "SolveSpace", "licencia": "GPL 3.0", "estrellas": "3k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Modelador paramétrico 2D/3D minimalista y rápido.", "por_que": ["Instalador de <10MB.", "Restricciones geométricas potentes."], "url": "https://solvespace.com/"}
        ]
    },
    "solidworks.com": {
        "privativo": "SolidWorks",
        "alternativas": [
            {"nombre": "FreeCAD", "licencia": "LGPL 2.0", "estrellas": "16k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Modelado paramétrico basado en croquis similar a SolidWorks.", "por_que": ["Banco de trabajo Part Design.", "Simulación por elementos finitos (FEM)."], "url": "https://www.freecad.org/"}
        ]
    },
    "sketchup.com": {
        "privativo": "SketchUp",
        "alternativas": [
            {"nombre": "Sweet Home 3D", "licencia": "GPL 2.0", "estrellas": "4k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Aplicación de diseño de interiores rápida y fácil.", "por_que": ["Vista 2D y 3D simultánea.", "Gran catálogo de mobiliario libre."], "url": "http://www.sweethome3d.com/"}
        ]
    },
    "maxon.net": {
        "privativo": "Cinema 4D",
        "alternativas": [
            {"nombre": "Blender", "licencia": "GPL 3.0", "estrellas": "100k+", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Excelente para motion graphics y efectos visuales.", "por_que": ["Geometry Nodes (Nodos).", "Completamente gratuito."], "url": "https://www.blender.org/"}
        ]
    },
    "unity.com": {
        "privativo": "Unity Engine",
        "alternativas": [
            {"nombre": "Godot Engine", "licencia": "MIT", "estrellas": "80k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Motor de videojuegos 2D/3D ligero y versátil.", "por_que": ["Arquitectura basada en nodos.", "Sin royalties ni comisiones."], "url": "https://godotengine.org/"}
        ]
    },
    "unrealengine.com": {
        "privativo": "Unreal Engine",
        "alternativas": [
            {"nombre": "Godot Engine", "licencia": "MIT", "estrellas": "80k", "plataformas": ["Win", "Mac", "Linux"], "descripcion": "Potente motor con soporte para C# y GDScript.", "por_que": ["100% de código abierto.", "Ideal para equipos pequeños y medianos."], "url": "https://godotengine.org/"},
            {"nombre": "O3DE", "licencia": "Apache 2.0", "estrellas": "6k", "plataformas": ["Win", "Linux"], "descripcion": "Open 3D Engine: motor AAA de alto rendimiento.", "por_que": ["Modularidad total.", "Tecnología de nivel cinematográfico."], "url": "https://o3de.org/"}
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

print(f"🤖 Procesando logos para el Bloque 4...")
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

print("🎉 Bloque 4 integrado.")
