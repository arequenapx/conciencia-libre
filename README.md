# 🐧 Conciencia Libre

> **"Tu libertad termina donde empieza el código que no puedes auditar."**

## 🎯 Objetivo de la Práctica
Este proyecto nace en la **UCO (Universidad de Córdoba)** como una iniciativa práctica de **Divulgación y Promoción del Software Libre**. 

El objetivo fundamental es combatir el monopolio tecnológico y la inercia de los usuarios al consumir software privativo. En lugar de ser un simple repositorio o wiki pasiva, **Conciencia Libre actúa proactivamente en el momento de la decisión**: cuando un usuario navega por las páginas oficiales de programas propietarios (como Adobe, Microsoft o Autodesk), la extensión interviene de forma educada para mostrar alternativas de Código Abierto (FLOSS) viables, éticas y gratuitas.

## 🚀 Cómo Funciona (El Motor)
La extensión opera bajo un estricto enfoque de **"Privacidad por Diseño" (Privacy by Design)**:
1. **Detección Local:** Escucha la URL actual del navegador sin enviar tu historial a ningún servidor externo.
2. **Inyección de Shadow DOM:** Si detecta la presencia de software privativo, inyecta una interfaz visual completamente aislada de la página anfitriona, garantizando que el diseño y CSS de la extensión nunca sea bloqueado ni corrompido por la web.
3. **Base de Conocimiento Local:** Carga una base de datos pre-empaquetada y optimizada con las mejores alternativas libres, detallando sus licencias, plataformas compatibles y argumentos persuasivos de soberanía tecnológica.

## 🛠️ Tecnologías Utilizadas
Para mantener la coherencia con la filosofía del software libre, se ha evitado el uso de frameworks pesados o tecnologías propietarias:
- **JavaScript Vanilla (ES6+):** Lógica rápida y ligera, cero dependencias.
- **Manifest V3:** El estándar más moderno y seguro para extensiones de navegador.
- **Shadow DOM API:** Aislamiento absoluto de componentes web.
- **Python 3 (Bot Generador de Base de Datos):** Un script independiente de automatización que gestiona la base de conocimiento, extrae resoluciones, consume APIs de Favicons (Clearbit/Google) y descarga los logos para que la extensión funcione 100% offline.
- **Bash Scripting:** Automatización integral del despliegue local y control de versiones.

## ⚖️ Licencia
Este proyecto se distribuye bajo la licencia **GNU GPLv3**. 
Eres libre de usar, estudiar, modificar y compartir este código. Cualquier trabajo derivado debe heredar esta misma libertad y mantenerse abierto.

## 🤝 Contribuir
La base de conocimiento puede expandirse. Si conoces más software privativo y quieres aportar alternativas libres, eres bienvenido a modificar el archivo `scripts/generar_bd.py` y proponer un _Pull Request_ a este repositorio.
