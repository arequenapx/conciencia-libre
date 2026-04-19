async function inyectarInterfaz(datos) {
    const host = document.createElement('div');
    host.id = '__conciencia_libre_v1_root__';
    document.body.appendChild(host);
    const shadow = host.attachShadow({ mode: 'open' });

    // Cargar la ruta del logo proporcionado por el usuario
    const logoUrl = chrome.runtime.getURL('icons/logo.svg');

    const estilo = document.createElement('style');
    estilo.textContent = `
        * { box-sizing: border-box; }
        #cl-micro-banner {
            position: fixed; top: 20px; right: 20px; z-index: 2147483647;
            background: #1e293b; color: white; padding: 12px 18px;
            border-radius: 12px; font-family: 'Segoe UI', sans-serif;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            display: flex; align-items: center; gap: 15px; transition: 0.3s;
            border: 1px solid #334155;
        }
        .cl-brand-logo { width: 28px; height: 28px; }
        #cl-modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(15, 23, 42, 0.9); display: none;
            justify-content: center; align-items: center; z-index: 2147483647;
            font-family: 'Segoe UI', sans-serif;
        }
        #cl-modal-card {
            background: #1e293b; width: 500px; border-radius: 16px;
            color: white; overflow: hidden; box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            border: 1px solid #334155;
        }
        .cl-card-alt {
            background: #0f172a; padding: 18px; border-radius: 12px;
            margin-bottom: 15px; border: 1px solid #334155;
        }
        .cl-badge { background: #064e3b; color: #34d399; padding: 3px 8px; border-radius: 6px; font-size: 11px; font-weight: bold; }
        .cl-check-list { list-style: none; padding: 0; margin: 12px 0; font-size: 13px; color: #cbd5e1; }
        .cl-check-list li { margin-bottom: 6px; }
        .cl-btn-primario { background: #10b981; color: white; border: none; padding: 12px; border-radius: 8px; cursor: pointer; font-weight: bold; text-decoration: none; display: block; text-align: center; width: 100%; transition: 0.2s; }
        .cl-btn-primario:hover { background: #059669; }
    `;
    shadow.appendChild(estilo);

    const ui = document.createElement('div');
    ui.innerHTML = `
        <div id="cl-micro-banner">
            <img src="${logoUrl}" class="cl-brand-logo" alt="Conciencia Libre">
            <div style="font-size: 13px; line-height: 1.4;">
                <span style="color:#f97316; font-weight:bold;">Software PRIVATIVO encontrado:</span><br>
                ${datos.privativo}
            </div>
            <button id="btn-abrir" style="background:#10b981; color:white; border:none; padding:6px 12px; border-radius:6px; cursor:pointer; font-weight:bold; font-size:11px;">Alternativas</button>
            <span id="btn-cerrar-b" style="cursor:pointer; opacity:0.5; font-size:16px;">✕</span>
        </div>

        <div id="cl-modal-overlay">
            <div id="cl-modal-card">
                <div style="background:#0f172a; padding:20px; display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #334155;">
                    <div style="display:flex; align-items:center; gap:10px;">
                        <img src="${logoUrl}" style="width:24px; height:24px;">
                        <strong style="font-size:16px;">Alternativas a ${datos.privativo}</strong>
                    </div>
                    <span id="btn-cerrar-m" style="cursor:pointer; font-size:20px; color:#94a3b8;">✕</span>
                </div>
                <div style="padding:20px; max-height: 80vh; overflow-y: auto;">
                    ${datos.alternativas.map(alt => {
                        // Aquí está la MAGIA restaurada para inyectar el logo
                        const imgSrc = alt.icono ? chrome.runtime.getURL(alt.icono) : '';
                        const imgHtml = alt.icono ? `<img src="${imgSrc}" style="width: 36px; height: 36px; border-radius: 8px; object-fit: contain; background: white; padding: 3px; margin-right: 12px;" alt="${alt.nombre} logo" onerror="this.style.display='none'">` : '';
                        
                        return `
                        <div class="cl-card-alt">
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <div style="display:flex; align-items:center;">
                                    ${imgHtml}
                                    <strong style="font-size:18px; color:#f8fafc;">${alt.nombre}</strong>
                                </div>
                                <span class="cl-badge">${alt.licencia}</span>
                            </div>
                            <div style="font-size:12px; color:#94a3b8; margin-top: 8px;">⭐ ${alt.estrellas} | 💻 ${alt.plataformas.join(', ')}</div>
                            <p style="font-size:14px; color:#cbd5e1; margin-top: 12px; line-height: 1.4;">${alt.descripcion}</p>
                            <ul class="cl-check-list">
                                ${alt.por_que.map(p => `<li>✓ ${p}</li>`).join('')}
                            </ul>
                            <a href="${alt.url}" target="_blank" class="cl-btn-primario">Visitar Web Oficial</a>
                        </div>
                        `;
                    }).join('')}
                </div>
            </div>
        </div>
    `;
    shadow.appendChild(ui);

    shadow.getElementById('btn-abrir').onclick = () => {
        shadow.getElementById('cl-micro-banner').style.display = 'none';
        shadow.getElementById('cl-modal-overlay').style.display = 'flex';
    };
    shadow.getElementById('btn-cerrar-b').onclick = () => host.remove();
    shadow.getElementById('btn-cerrar-m').onclick = () => host.remove();
}

async function motor() {
    const state = await chrome.storage.local.get('enabled');
    if (state.enabled === false) return;

    try {
        const url = chrome.runtime.getURL('src/data/alternativas.json');
        const res = await fetch(url);
        const db = await res.json();
        
        const currentUrl = window.location.href.toLowerCase();
        
        for (const key in db) {
            if (currentUrl.includes(key)) {
                inyectarInterfaz(db[key]);
                break;
            }
        }
    } catch (e) { console.error("CL Error:", e); }
}
motor();
