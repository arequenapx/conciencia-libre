import json
import os

ruta_fuente = 'fuente_datos.json'
ruta_destino = 'src/data/alternativas.json'

def generar():
    if not os.path.exists(ruta_fuente):
        print("❌ Error: No se encuentra fuente_datos.json en la raíz")
        return

    with open(ruta_fuente, 'r', encoding='utf-8') as f:
        datos = json.load(f)

    os.makedirs(os.path.dirname(ruta_destino), exist_ok=True)
    with open(ruta_destino, 'w', encoding='utf-8') as f:
        json.dump(datos, f, indent=2, ensure_ascii=False)
    
    print(f"✅ alternativas.json generado con {len(datos)} registros.")

if __name__ == "__main__":
    generar()
