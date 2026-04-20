---
marp: true
theme: default
paginate: true
header: 'Conciencia Libre: Proyecto de Soberanía Tecnológica'
footer: 'Antonio José Requena Baena - Universidad de Córdoba'
style: |
  section {
    background-color: #ffffff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #1e293b;
  }
  section.lead {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    color: #f8fafc;
  }
  h1 { color: #2563eb; border-bottom: 4px solid #f97316; }
  section.lead h1 { color: #ffffff; border-bottom: 4px solid #22c55e; }
  h2 { color: #0f172a; }
  strong { color: #f97316; }
  .columns {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 1rem;
  }
  .cite-box {
    background: #f1f5f9;
    padding: 10px;
    border-left: 5px solid #22c55e;
    font-size: 0.8em;
    margin-top: 20px;
  }
---

![w:120](image_49ad05.png) 
# Conciencia Libre
### Educando en Soberanía Tecnológica proactivamente

![w:100](logo.svg)

**Autor:** Antonio José Requena Baena
**Asignatura:** Software Libre y Compromiso Social (UCO)

---

# 1. Filosofía y Objetivo del Proyecto

- **El Problema:** El software libre suele ser "pasivo"; espera a que el usuario lo busque.
- **La Solución:** Una extensión **proactiva** que interviene en el "momento de la decisión".
- **Funcionamiento:** Detecta cuando visitas una web de software privativo y sugiere alternativas libres equivalentes.

<div class="cite-box">
💡 <b>Dato para el examen:</b> El objetivo es informar al usuario justo cuando está en el sitio oficial del software propietario.
</div>

---

# 2. Tecnologías Utilizadas

<div class="columns">
<div>

- **Manifest V3:** El estándar más moderno para extensiones, priorizando seguridad y rendimiento.
- **Vanilla JavaScript (ES6+):** No se usaron frameworks (React/Angular) para asegurar:
  - Máxima ligereza.
  - Ausencia de dependencias externas.
  - Facilidad de auditoría de código.
</div>
<div>

![w:250](https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg)
</div>
</div>

---

# 3. Privacidad y Datos (Local First)

- **Procesamiento Local:** La comparación de URLs se hace íntegramente en el navegador.
- **Sin servidores:** No se envía el historial de navegación a ninguna API externa.
- **Base de Datos:** El archivo `alternativas.json` reside dentro del paquete de la extensión.

<div class="cite-box">
🔒 <b>Justificación técnica:</b> El uso de una base de datos local garantiza la privacidad absoluta del usuario (Privacy by Design).
</div>

---

# 4. Aislamiento con Shadow DOM

**Problema:** Al inyectar nuestro modal en webs externas (ej. Adobe), el CSS de esa web "rompía" nuestro diseño.

**Solución:** Uso de **Shadow DOM API**.
- Crea un árbol DOM encapsulado y aislado.
- Impide que los estilos de la web anfitriona afecten a nuestra interfaz.

![w:500 shadow](captura.png)

---

# 5. Seguridad: Superando la Auditoría

Durante la revisión para **Mozilla Firefox AMO**:
- **Rechazo Inicial:** El uso de `innerHTML` fue detectado como un riesgo de vulnerabilidad **XSS** (Cross-Site Scripting).
- **La Solución:** Sustitución por la API **DOMParser**.
- **Resultado:** Código sanitizado y aprobado por los estándares de seguridad de Firefox y Chrome.

---

# 6. Automatización: El Bot de Datos

<div class="columns">
<div>

Para manejar más de **100 URLs** y logos:
- Se desarrolló un **Bot en Python 3**.
- **Funciones:**
  - Consulta las APIs de **Clearbit** y **Google** para obtener logos.
  - Descarga las imágenes localmente.
  - Genera el `alternativas.json` automáticamente.
</div>
<div>

![w:200](https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg)
</div>
</div>

---

# 7. ¿Por qué usamos `<all_urls>`?

Para cumplir su fin educativo, la extensión necesita:
1. Leer la URL de la pestaña activa.
2. Compararla con la base de datos local en tiempo real.
3. Este permiso de host global es indispensable para actuar de forma **proactiva**.

<div class="cite-box">
⚠️ <b>Nota de estudio:</b> Aunque Google es estricto con este permiso, es necesario para que la detección sea automática y local.
</div>

---

# 8. Conclusiones y Licencia

- **Soberanía:** Recuperar el control sobre nuestras herramientas digitales.
- **Licencia:** Distribuido bajo **GNU GPLv3**.
  - Garantiza que el software será siempre libre.
  - Permite auditar, modificar y mejorar el código por la comunidad.

> "Tu libertad termina donde empieza el código que no puedes auditar."

---

# ¡Es tu turno!
### Accede a los recursos y prepárate para el cuestionario

- [📂 Repositorio del Proyecto en GitHub](#)
- [📝 Realizar el Cuestionario de Evaluación](#)
- [🐧 Más sobre Software Libre en la UCO](#)

**Antonio José Requena Baena**
*Universidad de Córdoba*
