# Certbot Docker + OVH

Ce projet permet de générer et renouveler des certificats Let's Encrypt via Docker et le plugin DNS OVH.


## Paramétrage
dans `.ovhsecrets/ovh.ini`

```bash
dns_ovh_endpoint = ovh-eu
dns_ovh_application_key = key
dns_ovh_application_secret = secret
dns_ovh_consumer_key = consumer_key
```
voir: [WIKI OVH](https://marmits.com/wiki/Ovh_letsencrypt)

## Installation

```bash
docker compose build
```

## (staging pour tester) :
dans `.env`
```bash
MODE="staging"
```

## Générer un certificat 
`./initial.sh` 


## Renouvellement 
`./renew.sh`

## Vérification 
Apres redemarrage apache 
 
`sudo openssl s_client -connect local.marmits.com:443 -servername local.marmits.com`  
- Si le certificat est en production, aucun STAGING dans la réponse
