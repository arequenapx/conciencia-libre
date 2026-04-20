import json, os, urllib.request, urllib.parse, ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

dir_actual = os.path.dirname(os.path.abspath(__file__))
ruta_fuente = os.path.join(dir_actual, "fuente_datos.json")
ruta_logos = os.path.join(dir_actual, "../src/data/logos/")
ruta_json_final = os.path.join(dir_actual, "../src/data/alternativas.json")

os.makedirs(ruta_logos, exist_ok=True)

with open(ruta_fuente, 'r', encoding='utf-8') as f:
    datos = json.load(f)

headers = {'User-Agent': 'Mozilla/5.0'}
for web, info in datos.items():
    for alt in info["alternativas"]:
        nombre_logo = f"{alt['nombre'].lower().replace(' ', '_').replace('+', '')}.png"
        ruta_local_logo = os.path.join(ruta_logos, nombre_logo)
        alt["icono"] = f"src/data/logos/{nombre_logo}"
        
        if not os.path.exists(ruta_local_logo):
            dominio = urllib.parse.urlparse(alt["url"]).netloc
            try:
                req = urllib.request.Request(f"https://logo.clearbit.com/{dominio}", headers=headers)
                with urllib.request.urlopen(req, context=ctx, timeout=5) as r, open(ruta_local_logo, 'wb') as f:
                    f.write(r.read())
            except: pass

with open(ruta_json_final, 'w', encoding='utf-8') as f:
    json.dump(datos, f, indent=2, ensure_ascii=False)
print("✅ Base de datos unificada generada.")
