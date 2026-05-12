const toggle = document.getElementById('ext-status');

// Cargar estado inicial
chrome.storage.local.get('enabled', (data) => {
    toggle.checked = data.enabled !== false;
});

// Guardar cambios
toggle.onchange = () => {
    chrome.storage.local.set({ enabled: toggle.checked });
};
