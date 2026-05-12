const GITHUB_DB_URL = "https://raw.githubusercontent.com/arequenapx/conciencia-libre/main/src/data/alternativas.json";

console.log("🚀 Service Worker de Conciencia Libre despertando...");

chrome.runtime.onInstalled.addListener(() => {
  console.log("🔄 Evento onInstalled detectado. Buscando actualizaciones en GitHub...");
  
  fetch(GITHUB_DB_URL, { cache: "no-store" })
    .then(response => {
        if (!response.ok) throw new Error("Fallo en la red");
        return response.json();
    })
    .then(data => {
        chrome.storage.local.set({ "db_remota": data }, () => {
            console.log("✅ Base de datos sincronizada desde GitHub y guardada en Storage.");
            console.log("📦 Datos descargados:", data);
        });
    })
    .catch(error => console.error("⚠️ Error conectando con GitHub. Se usará la DB local.", error));
});