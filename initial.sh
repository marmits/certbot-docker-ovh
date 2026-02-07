#!/bin/bash
# Génération d'un certificat Let's Encrypt via Docker (local)
# Usage : ./initial.sh
# Geoffroy Stolaric - 2026

# Charger variables .env
set -o allexport
source "$HOME/docker/cerbot-docker/.env"
set +o allexport

cd "$CERTBOT_DIR" || exit 1


/bin/bash ./init_clean.sh


# Déterminer le serveur LE selon le mode
if [ "$MODE" = "prod" ]; then
    SERVER_ARG="--server $LE_SERVER"
else
    SERVER_ARG="--server https://acme-staging-v02.api.letsencrypt.org/directory"
fi


echo "=== Début de la génération du certificat ==="

docker compose run --rm certbot \
  certonly \
  --dns-ovh \
  --dns-ovh-credentials "$OVH_CREDENTIALS" \
  --dns-ovh-propagation-seconds "$PROPAGATION" \
  --non-interactive \
  --agree-tos \
  --email "$EMAIL" \
  $SERVER_ARG \
  $DOMAINS


  $WEB_RELOAD_CMD || true
