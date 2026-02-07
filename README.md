# Certbot Docker + OVH
- Ce projet permet de générer et renouveler des certificats Let's Encrypt via Docker et le plugin DNS OVH.
- Workflow compatible **staging** et **production**.

## Fonctionnalités

* Génération de certificats **wildcard** (`*.exemple.com`) via DNS-01.
* Gestion indépendante des certificats **en production** et **en local**.
* Scripts prêts pour l’**initialisation** et le **renouvellement automatique**.
* Stockage sécurisé des credentials OVH dans `.ovhsecrets/ovh.ini`.

## Paramétrage
dans `.ovhsecrets/ovh.ini`

```bash
dns_ovh_endpoint = ovh-eu
dns_ovh_application_key = key
dns_ovh_application_secret = secret
dns_ovh_consumer_key = consumer_key
```
voir: [WIKI OVH](https://marmits.com/wiki/Ovh_letsencrypt)


## Génération d’un certificat

* **Staging** (tests) :

```bash
./initial.sh
```

* **Production** :

* Passer `MODE="prod"` dans `.certbot`.

* Lancer à nouveau :

```bash
./initial.sh
```

> 💡 **Astuce pratique** : Grâce aux certificats **wildcard** (`*.exemple.com`) via DNS-01, il est possible d'utiliser les mêmes certificats **en production et en local** si il existe un serveur DNS local pour résoudre les sous-domaines (ex. `local.exemple.com`). Cela permet de tester HTTPS/TLS avec de vrais certificats sans impacter le VPS ou l’environnement de production.

---

## Renouvellement automatique

* Le script `renew.sh` peut être exécuté via **cron**.
* Certbot ne renouvellera que si le certificat est proche de l’expiration (moins de 30 jours), donc pas de risque de dépasser les quotas Let's Encrypt.

Exemple de cron quotidien :

```cron
0 3 * * * /home/docker/cerbot-docker/renew.sh >> /home/docker/cerbot-docker/renew.log 2>&1
```

---

## Bonnes pratiques
Toujours tester en **staging** avant de passer en production.

---

## Vérification 
Apres redémarrage apache (ou autre)
 
`sudo openssl s_client -connect local.exemple.com:443 -servername local.exemple.com`  
- Si le certificat est en production, aucun STAGING dans la réponse
