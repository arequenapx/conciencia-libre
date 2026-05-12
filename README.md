# Conciencia Libre  

**Conciencia Libre** es una extensión de navegador (Manifest V3) diseñada para fomentar la **soberanía tecnológica**. Su objetivo es informar a los usuarios sobre la presencia de software privativo durante su navegación y sugerir alternativas de **Software Libre y Código Abierto (FOSS)** de manera ética y no intrusiva.

> Este proyecto ha sido desarrollado como parte de las prácticas de **Software Libre y Compromiso Social** en la **Universidad de Córdoba (UCO)**.

---

## Características Principales

-  **Detección en Tiempo Real:** Identifica más de **201 plataformas y programas privativos** mientras navegas.
-  **Alternativas Éticas:** Sugiere más de **422 alternativas libres** validadas.
-  **Privacidad Primero:** La detección se realiza 100% en local. Tu historial de navegación nunca sale de tu ordenador.
-  **Interfaz Resiliente:** Utiliza *Shadow DOM* para garantizar que el banner informativo se vea perfecto en cualquier sitio web sin interferir con el diseño original.
-  **Base de Datos Dinámica:** Sincronización asíncrona con el repositorio central para recibir actualizaciones de software sin necesidad de reinstalar la extensión.

---

## Tecnologías y Arquitectura

El proyecto se apoya en tecnologías abiertas y procesos de automatización:

- **Core de la Extensión:** JavaScript (ES6+), HTML5 y CSS3 bajo el estándar **Manifest V3**.
- **Automatización (Scripts):** - **Python:** Auditoría de integridad de URLs, descarga de activos y gestión de la base de conocimiento.
  - **Bash:** Automatización de flujos de trabajo, limpieza de repositorio y empaquetado.
- **Infraestructura:** Git para control de versiones y GitHub como "backend" para la sincronización de datos.

---

##  Licencia

Este proyecto está bajo la licencia **GNU General Public License v3.0 (GPLv3)**. 

Elegimos GPLv3 porque:
1.  Garantiza que el software siempre será libre (Copyleft).
2.  Obliga a que cualquier mejora o derivado sea también compartido con la comunidad.
3.  Protege a los usuarios y desarrolladores frente a amenazas de patentes de software.

---

##  Instalación para Desarrolladores

Si deseas probar la extensión o colaborar en su desarrollo:

1. **Clona el repositorio:**

   git clone [https://github.com/arequenapx/conciencia-libre.git](https://github.com/arequenapx/conciencia-libre.git)

Carga la extensión en el navegador:

Abre Brave o Chrome y ve a brave://extensions/ o chrome://extensions/.

Activa el Modo de desarrollador (esquina superior derecha).

Haz clic en Cargar descomprimida (Load unpacked) y selecciona la carpeta del proyecto.

En Firefox:

Ve a about:debugging#/runtime/this-firefox.

Haz clic en Cargar complemento temporalmente y selecciona el archivo manifest.json.

📂 Estructura del Repositorio
/src: Código fuente de la extensión (lógica, estilos y datos).

/scripts: Herramientas en Python y Bash para el mantenimiento de la base de datos.

/icons: Identidad visual de la extensión.

fuente_datos.json: Base de conocimiento maestra del proyecto.

👤 Autor
Antonio José Requena Baena Ingeniería Informática - Universidad de Córdoba (UCO)
