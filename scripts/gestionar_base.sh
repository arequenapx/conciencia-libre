#!/bin/bash

# Rutas de archivos
FUENTE_DATOS="scripts/fuente_datos.json"
SCRIPT_PYTHON="scripts/generar_bd.py"
SCRIPT_DESPLIEGUE="despliegue_dinamico.sh"

echo "===================================================="
echo "   🛡️  GESTOR DE BASE DE CONOCIMIENTO - CONCIENCIA LIBRE"
echo "===================================================="

# 1. Formulario de Software Privativo
read -p "🌐 URL del software privativo (ej: adobe.com/photoshop): " URL_PRIV
read -p "🚫 Nombre del software privativo (ej: Adobe Photoshop): " NOM_PRIV

# Inicializar el array de alternativas en formato JSON
ARRAY_ALTS="[]"

# 2. Bucle para múltiples alternativas
while true; do
    echo "----------------------------------------------------"
    echo "➕ Añadiendo ALTERNATIVA LIBRE para $NOM_PRIV"
    read -p "   ✅ Nombre: " ALT_NOM
    read -p "   🔗 URL oficial: " ALT_URL
    read -p "   📜 Licencia (ej: GPLv3): " ALT_LIC
    read -p "   ⭐ Estrellas/Popularidad: " ALT_EST
    read -p "   📱 Plataformas (ej: Win, Mac, Linux): " ALT_PLAT
    read -p "   📝 Descripción corta: " ALT_DESC
    read -p "   💡 ¿Por qué elegirla? (separado por comas): " ALT_PORQUE

    # Convertir los 'por qué' en un array JSON
    PORQUE_JSON=$(echo "[$ALT_PORQUE]" | jq -R 'split(",") | map(ltrimstr(" ") | rtrimstr(" "))')
    PLAT_JSON=$(echo "[$ALT_PLAT]" | jq -R 'split(",") | map(ltrimstr(" ") | rtrimstr(" "))')

    # Crear el objeto de la alternativa
    NUEVA_ALT=$(jq -n \
        --arg nom "$ALT_NOM" \
        --arg url "$ALT_URL" \
        --arg lic "$ALT_LIC" \
        --arg est "$ALT_EST" \
        --arg desc "$ALT_DESC" \
        --argjson pq "$PORQUE_JSON" \
        --argjson pl "$PLAT_JSON" \
        '{nombre: $nom, url: $url, licencia: $lic, estrellas: $est, plataformas: $pl, descripcion: $desc, por_que: $pq}')

    # Añadir al array principal
    ARRAY_ALTS=$(echo $ARRAY_ALTS | jq ". += [$NUEVA_ALT]")

    read -p "❓ ¿Añadir otra alternativa para este mismo software? (s/n): " OTRA
    [[ "$OTRA" != "s" ]] && break
done

# 3. Guardar en el archivo fuente_datos.json
# Si el archivo no existe, crearlo vacío
if [ ! -f "$FUENTE_DATOS" ]; then echo "{}" > "$FUENTE_DATOS"; fi

# Insertar el nuevo bloque en el JSON
cat "$FUENTE_DATOS" | jq --arg key "$URL_PRIV" --arg priv "$NOM_PRIV" --argjson alts "$ARRAY_ALTS" \
    '. + {($key): {privativo: $priv, alternativas: $alts}}' > tmp.json && mv tmp.json "$FUENTE_DATOS"

echo "===================================================="
echo "✅ Datos guardados en $FUENTE_DATOS"
echo "===================================================="

# 4. Automatización de limpieza y generación
read -p "🚀 ¿Deseas procesar la base de datos y subir a GitHub ahora? (s/n): " DESPLEGAR
if [[ "$DESPLEGAR" == "s" ]]; then
    echo "🐍 Ejecutando generador Python..."
    python3 "$SCRIPT_PYTHON"
    
    echo "🌐 Iniciando despliegue dinámico..."
    bash "$SCRIPT_DESPLIEGUE"
fi

echo "🏁 Proceso finalizado."
