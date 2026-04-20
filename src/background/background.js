// URL raw del JSON en tu repositorio de GitHub
const GITHUB_DB_URL = "https://raw.githubusercontent.com/arequenapx/conciencia-libre/main/src/data/alternativas.json";

chrome.runtime.onInstalled.addListener(() => {
  console.log("[Conciencia Libre] Comprobando actualizaciones de la base de conocimiento...");
  fetch(GITHUB_DB_URL, { cache: "no-store" })
    .then(response => response.json())
    .then(data => {
      chrome.storage.local.set({ "db_remota": data }, () => {
        console.log("✅ Base de datos sincronizada desde GitHub.");
      });
    })
    .catch(err => console.log("⚠️ Sin conexión. Se usará la base de datos local."));
});
