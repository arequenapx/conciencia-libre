---
marp: true
theme: default
paginate: true
header: 'Conciencia Libre: Guía Técnica y de Estudio'
footer: 'Antonio José Requena Baena - Universidad de Córdoba'
style: |
  section {
    background-color: #ffffff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #1e293b;
    font-size: 22px;
  }
  h1 { color: #0f172a; border-bottom: 5px solid #f97316; padding-bottom: 5px; }
  h2 { color: #166534; margin-top: 10px; }
  section.blue {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    color: #f8fafc;
  }
  section.blue h1 { color: #22c55e; border-bottom: 5px solid #f97316; }
  a { color: #3b82f6; text-decoration: none; font-weight: bold; }
  section.blue a { color: #fbbf24; }
  .box {
    border-left: 6px solid #22c55e;
    padding: 10px 20px;
    background-color: #f0fdf4;
    margin: 15px 0;
  }
  .tech-icons img { margin-right: 15px; vertical-align: middle; }
  .columns { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
---

<center>

![w:150](image_49ad05.png) 
# Conciencia Libre
### Soberanía Tecnológica Proactiva

![w:120](logo.svg)

**Antonio José Requena Baena**
[🌐 Repositorio en GitHub](https://github.com/arequenapx/conciencia-libre)

</center>

---

# 1. El Problema y el Objetivo

- **Problema:** El software libre suele ser "pasivo". El usuario debe buscarlo proactivamente.
- **Inercia:** Muchos usuarios descargan software privativo por desconocimiento de las alternativas.
- **Objetivo:** Informar al usuario justo en el **"Momento de la Decisión"** (al visitar la web del software propietario).

<div class="box">
<b>Clave de Estudio:</b> La extensión monitoriza la URL localmente y sugiere alternativas sin bloquear el acceso, fomentando la libertad de elección.
</div>

---

# 2. Stack Tecnológico y Enlaces

El proyecto se basa en estándares abiertos para ser coherente con su filosofía:

- **Lógica:** [JavaScript ES6+](https://developer.mozilla.org/es/docs/Web/JavaScript) (Vanilla JS).
- **Estándar:** [Manifest V3](https://developer.chrome.com/docs/extensions/mv3/intro/) (Seguridad y eficiencia).
- **Aislamiento:** [Shadow DOM API](https://developer.mozilla.org/es/docs/Web/API/Web_components/Using_shadow_DOM) (Encapsulamiento visual).
- **Seguridad:** [DOMParser API](https://developer.mozilla.org/es/docs/Web/API/DOMParser) (Prevención de ataques XSS).
- **Automatización:** [Python 3.x](https://www.python.org/) (Gestión de base de datos).

<div class="tech-icons">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg" width="50">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg" width="50">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/html5/html5-original.svg" width="50">
</div>

---

# 3. Privacidad y Seguridad (Examen)

Para cumplir con las auditorías de **Mozilla Firefox AMO** y proteger al usuario:

1. **Privacy by Design:** El procesamiento es **100% local**. El historial de navegación nunca sale del navegador del usuario. No usamos APIs externas de seguimiento.
2. **Seguridad contra XSS:** Se sustituyó el uso de `innerHTML` por `DOMParser`. Esto asegura que el contenido inyectado sea sanitizado por el navegador.
3. **Shadow DOM:** Garantiza que el código CSS de la página (ej. Adobe) no interfiera con nuestra interfaz educativa.

---

# 4. Instalación Local (Modo Desarrollador)

Si no dispones de conexión a la tienda oficial, sigue estos pasos:

1. **Navegadores Chromium (Chrome/Brave/Edge):**
   - Ve a `chrome://extensions`. Activa el **"Modo de desarrollador"** (arriba a la derecha).
   - Haz clic en **"Cargar descomprimida"** y selecciona la carpeta de la extensión.
2. **Mozilla Firefox:**
   - Ve a `about:debugging#/runtime/this-firefox`.
   - Haz clic en **"Cargar complemento temporal"** y selecciona el archivo `manifest.json`.



---

# 5. Laboratorio: ¡Prueba la extensión!

Visita estos enlaces durante la presentación para ver la extensión en acción:

- **Diseño:** [Adobe Photoshop](https://www.adobe.com/products/photoshop.html) o [Figma](https://www.figma.com/)
- **Ofimática:** [Microsoft Word](https://www.microsoft.com/microsoft-365/word) o [Notion](https://www.notion.so/)
- **Comunicación:** [Zoom](https://zoom.us/) o [Slack](https://slack.com/)
- **Seguridad:** [1Password](https://1password.com/) o [WinRAR](https://www.win-rar.com/)

![bg right:35% shadow](captura.png)

---

# 6. Automatización: Bot de Python

El script `generar_bd.py` es el corazón de la base de conocimiento:
- Mapea automáticamente **+100 URLs** de software privativo.
- Utiliza la API de [Clearbit Logos](https://clearbit.com/logo) y [Google Favicons](https://www.google.com/s2/favicons) para descargar los iconos de las alternativas libres.
- Genera el archivo `alternativas.json` que la extensión usa offline.

---

# 7. Conclusiones y Licencia

- **Soberanía:** El software que usamos define nuestra libertad digital.
- **GPLv3:** El proyecto está bajo la [Licencia Pública General de GNU v3](https://www.gnu.org/licenses/gpl-3.0.html).
- **Comunidad:** El código es auditable, modificable y distribuible.

> "La libertad no es poder elegir entre varios productos propietarios, sino tener el control sobre el código que ejecuta nuestras vidas."

---

# ¡Gracias por vuestra atención!

¿Preguntas sobre la implementación o la ética del proyecto?

- **Autor:** Antonio José Requena Baena
- **UCO:** [Software Libre y Compromiso Social](https://www.uco.es/softwarelibre)
- **Código:** [Repositorio GitHub](https://github.com/arequenapx/conciencia-libre)

![w:80](image_49ad05.png) ![w:80](logo.svg)