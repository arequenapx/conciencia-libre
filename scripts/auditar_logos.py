import json
import os
import urllib.request
from urllib.parse import urlparse
import time

ruta_json = 'fuente_datos.json'
dir_logos = 'src/data/logos/'

def auditar():
    if not os.path.exists(ruta_json): return
    os.makedirs(dir_logos, exist_ok=True)
    
    with open(ruta_json, 'r', encoding='utf-8') as f:
        db = json.load(f)

    print("🔍 Comprobando iconos locales...")
    for key, info in db.items():
        for alt in info.get("alternativas", []):
            nombre_file = "".join([c if c.isalnum() else "_" for c in alt['nombre']]).lower() + ".png"
            ruta_img = os.path.join(dir_logos, nombre_file)
            
            if not os.path.exists(ruta_img):
                try:
                    dominio = urlparse(alt['url']).netloc
                    url_logo = f"https://www.google.com/s2/favicons?domain={dominio}&sz=128"
                    print(f"📥 Descargando logo: {alt['nombre']}")
                    urllib.request.urlretrieve(url_logo, ruta_img)
                    time.sleep(0.1)
                except:
                    print(f"⚠️ Falló: {alt['nombre']}")
    print("✅ Auditoría de logos terminada.")

if __name__ == "__main__":
    auditar()
