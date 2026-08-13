
=== CONFIGURATION INJECTEE PAR VAULT AGENT ===

[DATABASE]
# L'Agent va chercher le secret statique du Niveau 1
{{ with secret "secret/data/database/config" }}
Mot de passe = {{ .Data.data.password }}
{{ end }}

[TLS]
# L'Agent génère un certificat dynamique du Niveau 4 (valide 5 minutes)
{{ with secret "pki/issue/role-serveur-web" "common_name=api.mon-app.local" "ttl=5m" }}
Certificat = {{ .Data.certificate }}
{{ end }}
