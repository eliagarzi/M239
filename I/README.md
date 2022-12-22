# Know-How & Begriffe

## Inhaltsverzeichnis

- [Know-How & Begriffe](#know-how--begriffe)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [1 Wie kann derselbe Webserver unterschiedliche Websites hosten (Virtual Hosts)?](#1-wie-kann-derselbe-webserver-unterschiedliche-websites-hosten-virtual-hosts)
  - [2 Wie funktioniert DNS?](#2-wie-funktioniert-dns)
    - [2.1 Arten von DNS-Servern](#21-arten-von-dns-servern)
    - [2.2 DNS-Records](#22-dns-records)
  - [3 Wie können Angaben über einen beliebigen fremden Server herausgefunden werden?](#3-wie-können-angaben-über-einen-beliebigen-fremden-server-herausgefunden-werden)
  - [4 Proxy und Reverse Proxy](#4-proxy-und-reverse-proxy)
    - [4.1 Forward Proxy](#41-forward-proxy)
    - [4.2 Reverse Proxy](#42-reverse-proxy)
  - [5 DMZ](#5-dmz)

## 1 Wie kann derselbe Webserver unterschiedliche Websites hosten (Virtual Hosts)?

Beim Virtual Hosting können mehrere Webseiten über einen Webserver gehostet werden. Dies verringert die Anzahl an benötigten Webservern und erlaubt es gleichzeitig, für eine Applikation die mehrere Websiten hat, unterschiedliche Serverparameter (Wie Caching oder wo Logs gespeichert werden sollen) zu setzen.

Hierbei wird für die Website eine entsprechende Konfiguration erstellt. Bspw:

    #Virtual Host Konfiguration für den Nextcloud Server
    <VirtualHost *:80>
        ServerAdmin master@domain.com
        DocumentRoot /usr/share/nextcloud/
        ServerName zuericloud.ch/nextcloud
      
        Alias /nextcloud "/usr/share/nextcloud/"
        <Directory /usr/share/nextcloud/>
            Options +FollowSymlinks
            AllowOverride All
            Require all granted
              <IfModule mod_dav.c>
                Dav off
              </IfModule>
            SetEnv HOME /usr/share/nextcloud/
            SetEnv HTTP_HOME /usr/share/nextcloud/
        </Directory>
        ErrorLog /var/log/nextcloudserver/error.log
        CustomLog /var/log/nextcloudserver/access.log combined
    </VirtualHost>

Virtual Hosts unterscheiden sich entweder durch ihren Port oder durch ihren Hostnamen.

## 2 Wie funktioniert DNS?

DNS ist ein weltweites System aus Servern. Diese Server ermöglichen es, dass man heuzutage mit Domains arbeiten kann und wir im Browser google.com eingeben können. Computer kommunizieren unterhalb von DNS mit IP-Adressen, deshalb ist es wichtig, dass Domains in IP-Adressen aufgelöst werden können. Dies ist die Aufgabe des DNS.

DNS speichert aber noch mehr Informationen zu einer Domain. Zum einen die die IP-Adressen, auf die die Domain zeigt. Aber auch weitere Informationen wie MX-Records, welche Informationen zu Mailservern speichern. Oder Aliase einer Domain.

Das DNS ist dabei hierarchisch aufgebaut. domainname.topleveldomain.rootdomain. Dieser Aufbau wird genutzt, um Einträge in der "Baumstruktur" zu finden. Die Rootdomain . ist die oberste Domain. Die Server der Rootdomain werden angefragt, sobald man eine Domain nicht finden kann. Die Root-DNS-Server kennen nur die Server zur Topleveldomain der angefragten Domain. 

Jede Domain hat dabei ein eigenes Zonenfile. Hier sind alle DNS-Records eingetragen. Das Zonenfile liegt auf einem authoritative DNS-Server. Dies ist der einzige Server, der die Informationen zu Domain ändern kann.

Um das gesamte DNS schneller zu machen, kommen zu den authoritative DNS-Server noch DNS-Resolver hinzu. Diese nehmen Anfragen von Clients entgegen und lösen den Domainnamen nun recursiv oder iterativ auf.

**Iterative DNS-Request:**

Der DNS-Resolver antwortet mit dem nächsten authoritativen DNS-Server in der Hierarchie. Er löst keine DNS-Requests auf, sondern verweist den Client nur an den nächsten DNS-Server.

**Recursive  DNS-Request:**

Der DNS-Resolver löst den DNS-Request hierarchisch auf und antwortet dem Client mit der Antwort, die er aus den Ergebnissen seiner iterativen Abfragen erhält.

Der Eintrag würde nun für weitere Anfragen auf den Server für eine bestimmte Zeit gespeichert werden. Diese Zeit, die TTL, wird mit jedem DNS-Entry im Zonenfile gespeichert.

### 2.1 Arten von DNS-Servern

**Root DNS Server:** Diese DNS-Server speichern Informationen zu der Root Domain. Als Antwort geben sie die Adressen der entsprechenden TLD-Server.

**TLD DNS Server:** Diese DNS-Server speichern Informationen zu den Top-Level-Domains. Bspw. .ch oder .com. Als Antwort geben sie Informationen zu den authoritativen DNS-Server, welche die DNS-Zone speichern.

**Authoritative:** Dieser DNS-Server speichert das Zonenfile und ist der einzige, der es ändern kann.

**DNS-Resolver:** Dieser DNS-Server speichert Informationen zu einer Domain zusammen mit der TTL der jeweiligen DNS-Einträge. Sobald die TTL abgelaufen ist, werden die Einträge gelöscht. Die TTL existiert, damit das DNS einerseits schneller ist (Caching von Anfragen), andererseits bleiben die Datenbanken auf den DNS-Resolver immer aktuell

### 2.2 DNS-Records

Einige Beispiele für DNS-Records.

|Record       |Erklärung                                    | Beispiel                                   |
|-------------|---------------------------------------------|--------------------------------------------|
| A-Record    | Ein Domainname zeigt auf eine IPv4 Adresse  | tbz.ch -> 149.126.4.25                     |
| AAAA-Record | Ein Domainname zeigt auf eine IPv6 Adresse  | google.ch -> 2a00:1450:4010:c07::5e        |
| MX-Record   | Angaben zum Mailserver der Domain           | alt3.aspmx.l.google.com.                   |
| CNAME       | Domainname auf einen anderen Domainname, man spricht auch von einem Alias | example.net -> example.com  |
| PTR         | Genutzt für Reverse-Lookup, IP-Adresse zeigt auf FQDN  | 10.72.38.3 -> srzhdc1.domain.net|


## 3 Wie können Angaben über einen beliebigen fremden Server herausgefunden werden?

- IP-Adresse über DNS und umgekehrt
- HTTP-Server Produkt über "Server" key/value pair im HTTP-Header
- Offene Ports: Portscan-Tools wie NMAP

## 4 Proxy und Reverse Proxy

### 4.1 Forward Proxy

Der Forward Proxy ist ein Server, welcher die HTTP-Anfragen seiner Clients weiterleitet. In Firmen wird ein Forward Proxy häufig eingesetzt, um verschlüsselten Traffic auf Layer 7 (HTTPS) zu untersuchen. Hier baut der Client mit dem Proxy Server eine Ende-zu-Ende verschlüsselte Verbindung auf und dieser baut daraufhin eine Ende-zu-Ende verschlüsselte Verbindung zum Webserver auf. Dieser Aufbau kann nun genutzt werden, um den HTTPS Traffic auf Malware zu untersuchen und zu blockieren.

Der Forwards Proxy kann auch verwendet werden, um den Traffic zu cachen und so die Antwortzeiten zu verringern.

**Aufgaben des Forwards Proxys:**

- Caching von Websiten
- Filterung von ganz bestimmten Websiten und Domains auf Layer 7
- Untersuchen von verschlüsseltem Webtraffic
- Anonymisieren des Senders

### 4.2 Reverse Proxy

Ein reverse Proxy ist das Gegenteil vom Standardproxy / Forward Proxy. Reverse Proxys werden vor einen oder mehrere Zielserver geschalten. Beispielsweise ein Cluster aus Webservern. Der Reverse Proxy hat hier nun einerseits die Aufgabe, die Last auf die verschiedenen Zielserver zu verteilen, aber auch, um deren Zertifikate zu verwalten.

**Aufgaben des Reverse Proxys:**

- Load Balancing
- Zertifikatsverwaltung
- Das anonymisieren des Empfängers

Ein bekanntes Produkt ist HAProxy.

## 5 DMZ

In der DMZ (Demilitarisierte Zone) werden Server betrieben, die aus dem Internet erreichbar sein müssen. Die Idee dabei ist, dass für diese Server eine eigene Firewall-Zone erstellt wird. Nun könnten zonenbasierte Regeln erstellt werden. Häufige Regeln sind dabei, dass neuer Traffic aus dem WAN nicht ins LAN, aber in die DMZ verbinden darf.

**Server die häufig in einer DMZ stehen:**

- Reverse-Proxys (Für interne Webdienste, die von aussen erreichbar sein müssen)
- VDI-Gateways  (Virtual Desktop Infrastructure)
- RADIUS AAA-Server
- Mail-Gateway-Server

**Funktionen der DMZ:**

- Abgrenzen von Exposed Hosts vom LAN
- LAN speziell absichern durch eine Trennung
