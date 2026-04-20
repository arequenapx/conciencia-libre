const GITHUB_DB_URL = "https://raw.githubusercontent.com/arequenapx/conciencia-libre/main/src/data/alternativas.json";

chrome.runtime.onInstalled.addListener(() => {
  fetch(GITHUB_DB_URL, { cache: "no-store" })
    .then(r => r.json())
    .then(data => chrome.storage.local.set({ "db_remota": data }))
    .catch(e => console.log("Usando DB local."));
});
