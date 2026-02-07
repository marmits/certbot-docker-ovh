echo "=== Nettoyage des anciens certificats (staging ou prod existants) ==="

# Supprimer le dossier des certificats staging
sudo rm -rf letsencrypt/*

# Supprimer le dossier des données internes de Certbot
sudo rm -rf lib/*
