import json
import urllib.request
import concurrent.futures

def check_url(alt_name, url):
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=10) as response:
            return None if response.status == 200 else f"Error {response.status}: {alt_name}"
    except Exception as e:
        return f"Caído: {alt_name} ({url}) - {str(e)}"

def validar():
    with open('fuente_datos.json', 'r', encoding='utf-8') as f:
        db = json.load(f)
    
    urls = [(a['nombre'], a['url']) for info in db.values() for a in info['alternativas']]
    print(f"🌍 Verificando {len(urls)} enlaces...")
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
        resultados = list(executor.map(lambda p: check_url(*p), urls))
    
    errores = [r for r in resultados if r]
    if not errores: print("✅ Todas las URLs están operativas.")
    else: 
        for err in errores: print(err)

if __name__ == "__main__":
    validar()
