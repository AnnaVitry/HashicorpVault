# HashiCorp Vault : Ingénierie des Secrets & Automatisation

Ce dépôt contient un environnement d'apprentissage et de validation d'architecture centré sur **HashiCorp Vault**. L'objectif n'est pas seulement de manipuler l'outil, mais de comprendre la philosophie de sécurité sous-jacente : séparation des privilèges, automatisation Machine-to-Machine (M2M) et résilience d'infrastructure.

## Philosophie de l'Architecture

Ce projet aborde HashiCorp Vault non pas comme un simple coffre-fort, mais comme le cœur cryptographique dynamique d'une infrastructure moderne :
*   **Idempotence :** Déploiement destructif et reconstructif des politiques et des rôles.
*   **Résilience :** Gestion du problème de l'œuf et de la poule (Bootstrapping) pour l'amorçage des secrets.
*   **Zero Trust :** Application stricte du principe de moindre privilège via des jetons éphémères et des politiques restrictives.

---

## Structure des Modules (Carnet Jupyter)

Le cœur de la pratique se trouve dans le document interactif `vault.ipynb`[cite: 1], divisé en quatre niveaux d'expertise :

### Niveau 1 : Fondamentaux et Stockage Statique (KV-V2)
*   Configuration du moteur Key/Value v2 avec prévention d'écrasement concurrent via le mécanisme Check-And-Set (CAS)[cite: 1].
*   Séparation conceptuelle des données et des métadonnées (exploration via les sous-clés sans exposer les secrets)[cite: 1].
*   Imposition de politiques centralisées de mots de passe dictées par le serveur[cite: 1].

### Niveau 2 : Automatisation M2M (AppRole)
*   Remplacement des jetons codés en dur par une architecture M2M (Machine-to-Machine) via le couple `RoleID` et `SecretID`[cite: 1].
*   Stratégie de "Pull" applicatif pour éviter la manipulation d'identifiants par les outils de déploiement tiers[cite: 1].

### Niveau 3 : Cryptographie & Response Wrapping (Transit)
*   Utilisation de Vault comme un HSM logiciel ("Encryption as a Service") sans jamais exposer la clé cryptographique[cite: 1].
*   Encodage obligatoire en Base64 pour garantir l'intégrité des structures JSON lors du chiffrement de données binaires[cite: 1].
*   Transmission sécurisée de données critiques via le "Response Wrapping" (Cubbyhole) et détection d'interception par jeton à usage unique[cite: 1].

### Niveau 4 : Secrets Dynamiques & Vault Agent (PKI)
*   Génération d'une Autorité de Certification (CA) interne et création de rôles pour l'émission de certificats TLS à durée de vie très courte[cite: 1].
*   Délégation complète de l'authentification (Auto-Auth) et du cycle de vie des secrets à un processus démon autonome (Vault Agent)[cite: 1].
*   Génération de configurations applicatives à la volée via le moteur de Templating, mixant données statiques (KV) et dynamiques (PKI)[cite: 1].

---

## Démarrage Rapide (Environnement Local)

L'environnement suppose l'utilisation d'un système basé sur Debian/Ubuntu et l'installation du binaire natif d'HashiCorp[cite: 1].

1.  **Démarrer le serveur de développement :**
    ```bash
    vault server -dev
    ```
2.  **Conserver le `Root Token`** affiché dans le terminal. Le serveur fonctionnant exclusivement en mémoire vive (RAM), toutes les données sont réinitialisées à chaque arrêt.
3.  **Lancer le carnet Jupyter** et renseigner le token éphémère dans les variables d'environnement au début du document[cite: 1].

## Stack Technique
*   **Infrastructure :** HashiCorp Vault
*   **Langage :** Python 3
*   **SDK et Outils :** `hvac` (HashiCorp Vault API Client), `requests`, Jupyter Notebook[cite: 1]