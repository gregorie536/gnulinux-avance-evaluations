# Exercice 2 - Reverse Proxy avec Caddy et sécurisation Fail2ban

---

## 1. Présentation du besoin

- Mise en place d'un serveur web dynamique.
- Mise en place d'un reverse proxy avec Caddy.
- Protection de la ressource `/login` via Fail2ban.

> **Remarque** : Le site doit être dynamique et non un simple HTML statique.

---

## 2. Création du site web dynamique

- Technologie utilisée : Python Flask
- Description rapide du fonctionnement :
  - `/login` : page de connexion avec authentification simple (credentials en dur).
  - `/private` : page accessible uniquement après authentification réussie.

- Présentation rapide du code (fichier `app.py` par exemple).

> **Remarque** : Les identifiants sont codés en dur pour les besoins de l'exercice.

### Installation de Flask

Sur une machine Debian neuve :

```bash
sudo apt update
sudo apt install python3-pip
pip3 install Flask
```

> **Remarque** : Flask est un micro-framework léger et adapté pour des applications web simples.


Lancement du site web
Se placer dans le dossier contenant l'application :

```bash
cd exercice2/scripts/site_web
FLASK_APP=app.py flask run
```


Le site sera disponible sur :
```bash
http://localhost:5000/login
```


---

## 3. Mise en place de Caddy en tant que reverse proxy

- Installation de Caddy.
- Configuration du fichier `caddyfile` :
  - Proxy pass vers l'application web locale.
  - Redirections HTTP → HTTPS si nécessaire.

> **Remarque** : Caddy est un serveur web moderne avec reverse proxy intégré et support automatique du HTTPS.

---

## 4. Sécurisation avec Fail2ban

- Installation de Fail2ban.
- Création d'un filtre spécifique pour `/login`.
- Configuration de la jail (`jail.local`).
- Explication des actions sur IPs suspectes.

> **Remarque** : Fail2ban permet de bloquer les adresses IP effectuant des tentatives d'accès malveillantes.

---

## 5. Test du mécanisme de bannissement

- Méthodologie pour tester Fail2ban :
  - Faire plusieurs tentatives de connexion incorrectes.
  - Vérifier que l'IP est bannie.
  - Vérifier via les logs et `fail2ban-client status` que la jail est active.

```bash
sudo fail2ban-client status flask-login
```

---

## 6. Instructions d'installation et de déploiement

- Liste de toutes les étapes pour installer et configurer le projet sur Debian.
- Commandes à exécuter :
  - Installation des paquets nécessaires
  - Déploiement du site web
  - Configuration de Caddy
  - Activation de Fail2ban

> **Remarque** : Les commandes sont données pour un environnement Debian neuf appartenant au groupe sudo.

### Lancement de Caddy

Se placer dans le dossier contenant le `caddyfile` :

```bash
cd exercice2/scripts
```
Puis lancer Caddy en spécifiant le fichier de configuration :

```bash
sudo caddy run --config ./caddyfile
```
---

## 7. Conclusion

- Récapitulatif du système mis en place.
- Points forts et limites éventuelles du système.

