#!/bin/bash
# Aguarda o ngrok subir
echo "Aguardando ngrok..."
sleep 5
NGROK_API="http://localhost:4040/api/tunnels"
WEBHOOK_URL=$(curl -s $NGROK_API | grep -o 'https://[a-zA-Z0-9.-]*.ngrok-free.app' | head -1)
echo "Webhook gerado: $WEBHOOK_URL"

# Atualiza o docker-compose.yml (ou .env) com o novo webhook
if [ -n "$WEBHOOK_URL" ]; then
  export MERCADO_PAGO_WEBHOOK=$WEBHOOK_URL
  docker-compose up --build
else
  echo "Não foi possível capturar o endpoint do ngrok."
fi