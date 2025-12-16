#!/bin/bash
# start.sh - 100% FUNCIONAL

echo "========================================"
echo "🔄 REINICIANDO SISTEMA COMPLETO"
echo "========================================"

cd /opt/render/project/src

# PASO 1: LIMPIEZA EXTREMA
echo "🔥 LIMPIEZA EXTREMA..."
pkill -9 -f "python" 2>/dev/null || true
find /opt/render -name "*.session*" -exec rm -f {} \; 2>/dev/null
rm -rf .pyrogram_session 2>/dev/null

# PASO 2: ESPERA MUY LARGA (Render necesita esto)
echo "😴 ESPERANDO 90 SEGUNDOS (CRÍTICO)..."
sleep 90

# PASO 3: SERVIDOR WEB BÁSICO
echo "🌐 CONFIGURANDO SERVIDOR WEB..."
mkdir -p server
cat > server/index.html << EOF
<h1>Bot Activo</h1>
<p>$(date)</p>
EOF
python3 -m http.server 8080 -d server --bind 0.0.0.0 &
WEB_PID=$!
sleep 10

# PASO 4: VERIFICACIÓN
if ps -p $WEB_PID > /dev/null; then
    echo "✅ Servidor web: ACTIVO"
else
    echo "❌ Servidor web: FALLÓ"
fi

# PASO 5: EJECUTAR BOT
echo "🤖 EJECUTANDO BOT..."
echo "========================================"
exec python3 bot.py
