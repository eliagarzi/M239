# Anforderungen

## Inhaltsverzeichnis

- [Anforderungen](#anforderungen)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [1 Züri Cloud AG](#1-züri-cloud-ag)
  - [1.1 Vorstellung Züri Cloud AG](#11-vorstellung-züri-cloud-ag)
  - [1.2 Art des Hostings](#12-art-des-hostings)
    - [1.3 Art des Hostings für das Modul 239](#13-art-des-hostings-für-das-modul-239)
  - [2 Cloud](#2-cloud)
  - [2.1 Cloud Modelle](#21-cloud-modelle)
    - [2.1.1 Public Cloud](#211-public-cloud)
    - [2.1.2 Private Cloud](#212-private-cloud)
    - [2.1.3 Hybrid Cloud](#213-hybrid-cloud)
  - [3  On Premise](#3--on-premise)
  - [4 Colo](#4-colo)

## 1 Züri Cloud AG

Im folgenden mussten wir uns ein fiktives Unternehmen ausdenken und einige theoretische Aspekte durchdenken.

## 1.1 Vorstellung Züri Cloud AG

Die Züricloud AG ist ein Cloudprovider aus Zürich. Hierfür setzt das Unternehmen auf drei Rechenzentren in der Schweiz.

Services der Züricloud AG:

- Bereitstellung von Virtuellen Maschinen und Containern
- Bereitstellung von Mailservern
- Bereitstellung von Nextcloud als Datenspeicher

## 1.2 Art des Hostings

Die Züricloud AG setzt für ihr Hosting auf ein modernes Rechenzentrum, welches zusammen mit der Rechenzentrum AG gebaut und betrieben wird. Also On Premise Hosting. Als IaaS (Virtuelle Maschinen und Container) und SaaS (Mail und Filestorage) Betreiber, braucht die Züricloud AG Raum für schnelles Wachstum und flexibilität, deshalb setzt die Zuercloud auf moderne HCI (Hyperconverged) Umgebungen.

Die Vorteile eines eigenen Rechenzentrums / On-Premise:

- Schnelle Anbindung in ganz Zürich
- Unabhängig von Cloud Providern
- Durch effiziente Nutzung mit HCI können wir das Rechenzentrums mit anderen Cloudprovidern konkurrenzfähig machen

### 1.3 Art des Hostings für das Modul 239

Mein Projekt realisiere ich auf der Google Cloud Platform. GCP nutze ich aktuell auch für das Modul 242 (Container für eine Node.js basierte API) und die Cloud-Plattform schenkt einem 400 Dollar Guthaben für die ersten 90 Tage.

Ich wollte die Google Cloud Platform schon immer einmal ausprobieren und denke es eignet sich nun für dieses Modul sehr gut.

## 2 Cloud

Vorteile:

- Für Unternehmen ist die CapEX (Capital Expense), also die Investitionskosten, entscheidend.
- Für Unternehmen ist die OpEx (Operational Expense) günstiger
- Man benötigt weniger operatives Personal
- Man kann Software schneller ausrollen

Nachteile:

- Man ist abhängig von einer Internetverbindung 
- Daten werden einem Cloud-Provider anvertraut
- Man ist abhängig vom Cloud-Provider
- Cloud kann schnell sehr teuer werden
- Bestehendes Personal muss umgeschult werden

## 2.1 Cloud Modelle

### 2.1.1 Public Cloud

In der Public Cloud werden Kunden ebenfalls Ressourcen über einen Self-Service bereitgestellt. Hier werden die darunterliegenden Hardwareressourcen allerdings meist geteilt genutzt. Es gibt oft aber auch die Möglichkeit für die Nutzung dedizierter Server (z.B. Azure Dedicated Host).

### 2.1.2 Private Cloud

Private Clouds sind Clouds die ausschliesslich für einen Kunden betrieben werden. Ein Beispiel aus Zürich wäre die Netrics AG, welchen Kunden VMware vSphere als IaaS anbieten. Netrics übernimmt die gesamte Verwaltung der Hardware und des physischen Netzwerkes, auch die Stromversorgung, der Standort und die physische Sicherheit.

### 2.1.3 Hybrid Cloud

Die Hybrid Cloud ist die Mischung aus Public und Private Cloud. Ein Beispiel währe hier VMware Cloud Foundation, welches es ermöglicht seine Workloads, unabhängig des Standortes, virtualisiert zu betreiben. So kann ein bestehendes vSphere Rechenzentrum mit Cloudplattformen wie Azure oder AWS verbunden werden. Virtuelle Maschinen können über vMotion unterbrechungsfrei zwischen den Standorten migriert werden.

## 3  On Premise

On Premise Hosting ist das klassische Hosting an einem eigenen Standort. Hier verwaltet das Unternehmen alles. Strom, Kühlung, physische Sicherheit, physische Server, Netzwerk etc.

Vorteile:

- Man ist unabhängig von jeglichen Cloud- oder Colo-Providern
- Man besitzt jegliche Hardware und Informationen im Rechenzentrum
- Man hat die volle Kontrolle über alles

Nachteile:

- Die Erstanschaffungskosten sind sehr hoch (CapEx)
- Die Betreibungskosten sind ebenfalls hoch, da man grundsätzlich immer mehr Ressourcen wie Strom und Kühlung verbraucht, als man effektiv nutzt.
- Man benötigt mehr Personal

## 4 Colo

Ein Colo - Colocation Data Center ist Rack-Space der gemietet werden kann. Dabei stellt der Provider nur Platz, Strom, Kühlung und physische Sicherheit bereit. Es ist also noch kein IaaS. Bekannte Unternehmen wären hier Equinix.

Vorteile:

- Gut für Replication-Sites, die im Falle einer Störung für ein On-Premise Datacenter

Nachteile:

- Für das ganze eigene Rechenzentrum wird es schnell teuer
- Man ist abhängig vom Colo-Provider
