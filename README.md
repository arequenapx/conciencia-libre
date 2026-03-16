# 🐧 Conciencia Libre

Una extensión de navegador (Manifest V3) que detecta cuando visitas la web de un programa privativo y te sugiere una alternativa de Software Libre mediante un banner no intrusivo.

## 🎯 Objetivo
Promover el uso de herramientas de código abierto frente a los monopolios del software privativo (ej. sugerir GIMP cuando el usuario visita la página de descarga de Photoshop).

## ⚖️ Licencia
Este proyecto está licenciado bajo la **GNU GPLv3**. Eres libre de usar, estudiar, compartir y modificar el código.

graph TD
    A[Navegador Web] -->|Instala la extensión| B(manifest.json)
    
    B -->|Define permisos e inyecta| C(content.js : El Agente)
    B -->|Registra interfaz| D(popup.html / popup.js)
    
    C -->|Paso 1: Lee la URL| E{¿Es URL privativa?}
    
    F[(alternativas.json)] -.->|Provee base de datos local| E
    
    E -->|Sí hay coincidencia| G[Paso 3: Crea nodo HTML y CSS]
    E -->|No hay coincidencia| H[Modo silencioso / No hace nada]
    
    G -->|Inyecta en el document.body| I[Muestra Banner de Conciencia Libre]
    
    D -.->|Activa/Desactiva avisos| C