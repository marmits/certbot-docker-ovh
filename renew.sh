#!/bin/bash
# Renew certificat Let's Encrypt via Docker + log (local)
# Geoffroy Stolaric - 2026

# Charger variables .env
set -o allexport
source "$HOME/docker/cerbot-docker/.env"
set +o allexport

# Nettoyage du log
echo "" > "$LOGFILE"

cd "$CERTBOT_DIR" || exit 1

# Déterminer le serveur LE selon le mode
if [ "$MODE" = "prod" ]; then
    SERVER_ARG="--server $LE_SERVER"
else
    SERVER_ARG="--server https://acme-staging-v02.api.letsencrypt.org/directory"
fi

echo "=== Début du renouvellement Certbot ===" >> "$LOGFILE"
date >> "$LOGFILE"

docker compose run --rm certbot renew \
  --dns-ovh-credentials "$OVH_CREDENTIALS" \
  --dns-ovh-propagation-seconds "$PROPAGATION" \
  $SERVER_ARG \
  >> "$LOGFILE" 2>&1

RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo "✅ CERTBOT Renew réussi" >> "$LOGFILE"
    # Recharger serveur web si défini
    if [ -n "$WEB_RELOAD_CMD" ]; then
        eval "$WEB_RELOAD_CMD"
    fi
else
    echo "❌ CERTBOT Renew ÉCHEC" >> "$LOGFILE"
fi

echo "=== Fin du renouvellement ===" >> "$LOGFILE"
date >> "$LOGFILE"
exit 0
