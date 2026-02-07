# Dockerfile pour Certbot + plugin OVH
FROM certbot/certbot:v2.9.0

# Installer le plugin OVH
RUN pip install certbot-dns-ovh

