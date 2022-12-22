# Modul 239 Internetservices betreiben

## Einleitung 

Im Modul M239 geht es darum, Internetservices zu betreiben. Gemeint sind damit hauptsächlich Webserver und Mailserver.

Ich wollte die Modularbeit dazu nutzen, um Docker und Google Cloud zu lernen. Für das Modul 300 (Plattformübergreifende Dienste) wird das Wissen in Docker sehr hilfreich sein, da Docker unteranderem auch für Kubernetes eingesetzt wird.

Für das Modul M239 habe ich folgendes Umgesetzt:

![](./Konfiguration/images/M239_Architektur.png)

## Aufbau

**Nginx Reverseproxy**

- Weiterleitung von Requests an die dahinterliegenden Webserver
- Ubuntu

**Mailserver**

- iRedMail gesamtlösung
- Ubuntu 20.04 Server
- Postfix als SMTP-Server
- Dovecot als IMAP-Server
- Sendgrid als SMTP-Relay
- STARTTLS und SASL
- SPF/Dmarc Records und DKIM signing

**Nextcloud Server**

- Apache2 Webserver
- PHP7 
- MySQL Datenbankserver
- Google Cloud Compute Engine
- RHEL

**Zuericloud Website**

- HTML, CSS
- Nginx
- Docker

**Monitoring API**

- JavaScript und Node.js
- Python
- Docker

Für dieses habe ich ebenso eine API mit JavaScript auf Basis von Node.js programmiert. Dabei senden alle Server regelmässig eine Art "Heartbeat" Signal an die API, welche den Status aller Dienste auf status.zuericloud.ch darstellt.

https://github.com/eliagarzi/zuericloudmonitoring

## Technologien

Mit den folgenden Technologien habe ich im Modul 239 gearbeitet:

- Google Cloud Platform
- Docker & Docker Compose
- Nginx & Apache Webserver
- Postfix und Dovecot als SMTP und IMAP Dienst
- Ubuntu 20.04
- Red Hat Enterprise Linux 8
- Node.js

## Erweiterung mit Kubernetes

Nach dem Modul habe ich die Infrastruktur noch erweitert, dabei habe ich mit folgenden Technologien gearbeitet:

- Kubernetes als Containerorchestrator
- Terraform als IaC Tool

# Inhaltsverzeichnis

## [A: Anforderungen](A/README.md)

## [I: Know-How & Begriffe](I/README.md)

## [V: Vorgaben (Security / Service Operation)](V/README.md)

## [SW1: Webserver installieren/konfigurieren](SW1/README.md)

## [SW2: Mailserver installieren/konfigurieren](SW2/README.md)

## [SW3: Weiterer Serverdienst installieren/konfigurieren](SW3/README.md)

## [SW4: Protokollierung](SW4/README.md)

## [B2: Zertifikate](B2/README.md)

## [T: Testing](T/README.md)

## [Reflexion](R/README.md)


- - -
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/ch/88x31.png" /></a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 3.0 Schweiz Lizenz</a>
- - -
