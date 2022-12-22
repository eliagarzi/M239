# Anforderungen

## Inhaltsverzeichnis

- [Anforderungen](#anforderungen)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [1 Gefahren und Risiken](#1-gefahren-und-risiken)
  - [1.1 Inventar](#11-inventar)
  - [1.2 Gefahren](#12-gefahren)
  - [2 Sicherheitskonzept](#2-sicherheitskonzept)
    - [Konkrete Massnahmen im Modul](#konkrete-massnahmen-im-modul)
    - [Infrastruktur](#infrastruktur)
    - [Betreiber](#betreiber)
    - [Klienten](#klienten)
  - [2 Betriebskonzept](#2-betriebskonzept)
    - [2.1 Internes Maintanance-Window](#21-internes-maintanance-window)
    - [2.2 Backup & Replikation Kerninfrastruktur Zeiten](#22-backup--replikation-kerninfrastruktur-zeiten)
    - [2.3 Backup & Replikation Kunden](#23-backup--replikation-kunden)
    - [2.4 Service Level Agreements](#24-service-level-agreements)
    - [2.5 Arbeitszeiten](#25-arbeitszeiten)
      - [2.5.1 Wochen & Jahresplan](#251-wochen--jahresplan)
    - [2.6 Vertrag](#26-vertrag)

## 1 Gefahren und Risiken

## 1.1 Inventar

Inventar, dass geschützt werden muss:

- Nginx Reverse Proxy
- Nextcloud Server
- Mail-Server
- Züricloud Website
- API Container
- Wireguard Server
- Mitarbeiter
- Kunden

## 1.2 Gefahren

- Serivceunterbruch
- Verlust der Kundendaten
- Zero-Day Exploit
- Denial of Service Angriff
- Stromunterbruch
- Störung mit der Internleitung
- Erfolgreicher Ransomwareangriff
  
## 2 Sicherheitskonzept

### Konkrete Massnahmen im Modul

Viele der theoretischen Sicherheitsmassnahmen wären im Modul nicht umsetzbar. Im Folgen sind alle Sicherheitsmassnahmen, die im Modul ebenfalls umgesetzt werden:

**Wireguard Server:**

Um sicher auf die Server zu verbinden, ist es ungünstig, wenn man diese einfach so per SSH über das Internet erreichen kann. Ich nutze also einen Wireguard VPN in die GCP. Somit kann nur ich auf die SSH Schnittstellen zugreifen.

<https://gitlab.com/eliagarzi/test/-/tree/main/Wireguard>

**Firewall-Konzept:**

| Netzwerk    | Typ | Ziel (Tag)           | Quelle               | Protokoll |
|-------------|-----|----------------------|----------------------|-----------|
| Management  | IN  | ssh-server           | Identity Aware Proxy | tcp:ssh   |
| Management  | IN  | ssh-server           | Management-Network   | tcp:ssh   |
| Management  | IN  | wireguard-server     | 0.0.0.0/0            | udp:51820 |
| Production  | IN  | Alle                 | 0.0.0.0/0            | IMCP      |
| Production  | IN  | http-server          | 0.0.0.0/0            | tcp:http  |
| Production  | IN  | https-server         | 0.0.0.0/0            | tcp:https |
| Production  | IN  | proxied-server-http  | Proxy-Server         | tcp:http  |
| Production  | IN  | proxied-server-https | Proxy-Server         | tcp:https |

In den Gruppen **http-server und https-server** ist nur der Reverseproxy. Eine direkt Verbindung auf die Server dahinter, wäre also über http nicht möglich.

**Snapshot:**

- Es wird täglich um 03:00 Uhr ein Snapshot der jeweiligen Instanzdisks gemacht.

**Reverse Proxy/Load-Balancer:**

- Nextcloud und der Apache Firmenwebserver ist nur über den NGINX Proxy erreichbar. Dies ermöglicht eine einheitliche Kontrolle der Zertifikate. In Zukunft könnte man die Umgebung so auch einfacher skalieren.  Nginx kann sehr schnell als Load-Blancer und Proxy konfiguriert werden

**Server VM Instanzen:**

- Bei Hostfehlern wird die VM automatisch auf einem anderen Host neugestartet

- Bei Hostwartung wird die VM automatisch auf einen anderen Host migriert

- Die Virtuellen Maschinen werden alle mit Löschschutz versehen, somit ist eine unbeabsichtigte Löschung einer VM nicht möglich.

**Monitoring:**

- Als Monitoring Lösung nutzt ich meine für das Modul programmierte Status-API. Diese ist erreichbar unter zuericloud.ch/status als Webinterface und /api als Schnittstelle.

- Die Status API nutzt zur Authentisierung API-Keys.

### Infrastruktur

- Zwei seperate Stromkreise. Einer mit USV & Generator.
- Redundante Netzinfrastruktur (Redundante Spine Switches und Firewalls)
- Redundante Internetanbindungen mit zwei verschiedenen Netzprovidern
- Hochverfügbares SAN
- Hochverfügbare Virtualisierungsumgebung
- Replikationszone in ein zweites Rechenzentrum
- Klare Maintanance Windows ()
- 24/7 Monitoring der Infrastruktur
- Backup der Infrastruktur (Full Backup für für jede Stunde für 24 Stunden auf Speichercluster, danach wirddas Backup in einer Tape-Library gespeichert)
- Nutzung eines IPS Systems (Z.b. Snort IPS)

### Betreiber

- Einführung eines ISO 27001 ISMS
- Jährliche Audits der Infrastruktur
- Genaue Dokumentation der Infrastruktur
- Schulung neuer Mitarbeiter (Risiken, exakter Umgang mit der Infrastruktur)
- Klarer Austrittsprozess für Mitarbeiter (Damit diese kein potenzielles Risiko darstellen)
- Accessmanagement & monatliches auditing
- Einstellung eines Security

### Klienten

- Die Webservices werden über hochverfügbare reverse Proxy-Server bereitgestellt. (Z.B. Nginx Cluster mit 3 Nodes)
- Isolation der Wordloads. Klienten teilen sich z.B. keine Nextcloud VM oder Mailcontainer.

## 2 Betriebskonzept

### 2.1 Internes Maintanance-Window

Jeden zweiten Tag von 03:00-06:00

Im internen Maintanance-Window wird die interne Infrastruktur (Netzwerk, Virtualisierungshosts, Storagesysteme).
Die interne Wartung soll für den Kunden umbemerkt beleiben durch die Nutzung von Hochverfügbarkeit und Replikationszone.

In dieser Zeit werden folgende Dinge getan:

- Updates & Patches installiert
- Sicherheitslücken geschlossen
- Fehler überprüft
- Neue Funktionen/Services ausgerollt

### 2.2 Backup & Replikation Kerninfrastruktur Zeiten

Die Kerninfrastruktur ist über zwei Zonen repliziert

- Inkrementelles Backup der Kerninfrastruktur werden zu jeder vollen Stunde gemacht. Die Backups werden für 24 Stunden aufbewahrt und anschliessend auf Tape geschrieben.
- Es wird jeden Tag ein Full-Backup gemacht. Zwischen 00:00-03:00, also vor dem Maintanance-Window

### 2.3 Backup & Replikation Kunden

Der Kunde kann für seine Services eine Zonenreplikation sowie ein Backup ermöglichen.

### 2.4 Service Level Agreements

Es gibt verschiedene Support SLA.

| SLA               | Kosten    | Abrechungszeitraum | Response Time | Resultion Time   | Support-Zeiten |
|-------------------|-----------|-----------|-----------|-----------|-------------------|
| Flex              | 150       | Stunde    | 30 Min    | Keine     | 8:00 - 18:00      |
| Business Standard | 9500      | Jahr      | 10 Min    | 4         | 8 Stunden/Tag     |
| Business Enterprise| 16500    | Jahr      | 10 Min    | 10 Min    | 24/7              |

### 2.5 Arbeitszeiten

Es gibt verschiedene Teams. Jedes Team hat eigene Aufgaben und Arbeitszeiten.

| Team          | Aufgabe | Zeiten |
|---------------|---|---|
| Projekt       | Einführung von neuen Services  | Fliesszeiten  |
| Infrastruktur | Betrieb der Infrastruktur | 7:30 - 19:00  |  
| Support       | Support der Kunden | 24/7 |

Der Support arbeitet im Schichtenbetrieb. Sowohl 1. wie auch 2nd Level.

Schicht 1: 08:00 - 17:00

Schicht 2: 17:00 - 00:00

Schicht 3: 00:00 - 08:00

#### 2.5.1 Wochen & Jahresplan

Grundsätzlich müssen Ferien 6 Monate vor dem Bezug der Ferien eingeplant werden. So ist es möglich einen Jährlichen Anwesenheitsplan zu führen.

Um den Mitarbeitern mehr flexibilität zu ermöglichen und dem Kunden gleichzeitig einen guten Service liefern zu können, wird auch ein Wochenplan geführt. Dieser soll garantieren, dass immer eine mindestanzahl Mitarbeiter für mögliche Supportfälle zur Verfügung steht.

### 2.6 Vertrag

Der Vertrag umfasst verschiedene Bestandteile. Im Vertrag müssen folgende Sachen geklärt werden:

- Service Modell, welches der Kunde haben möchte
- SLA Vertrag, der genutzt wird
- Rechtliche Absicherung beider Seiten
