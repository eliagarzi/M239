# Protokollierung

## Inhaltsverzeichnis
- [Protokollierung](#protokollierung)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [1 Ziele](#1-ziele)
  - [2 Wozu werden Logfiles geschrieben?](#2-wozu-werden-logfiles-geschrieben)
  - [3 Ablageort der Logfiles und Einstellungsmöglichkeiten](#3-ablageort-der-logfiles-und-einstellungsmöglichkeiten)
    - [Linux Logging im allgemeinen](#linux-logging-im-allgemeinen)
      - [Syslog](#syslog)
      - [Journalctl](#journalctl)
    - [Reverse Proxy](#reverse-proxy)
    - [Container-Host](#container-host)
    - [Website Container](#website-container)
    - [Wordpress-Container](#wordpress-container)
    - [Nextcloud](#nextcloud)
    - [Mailserver](#mailserver)
      - [Postfix](#postfix)
      - [Dovecot](#dovecot)

## 1 Ziele 

**Im Bezug auf die Praxisarbeit:**

- Welche Services werden protokollieren?
- Wohin protokollieren die Services und zu welchem Zweck
- Wo die protokollierung definiert wird und was angepasst werden kann
- Welche Berechtigung gebraucht wird, um die protokollierung anzusehen oder zu ändern

## 2 Wozu werden Logfiles geschrieben?

Logfiles werden für verschiedene Zwecke geschrieben. Es gibt Accesslogs, mit welchem z.B. der Zugiff auf Dateien oder Websiten nachvollzogen werden kann. Es gibt aber auch Error-Logs, welche Fehler im Programmablauf erfassen. Dies hilft enorm, wenn es darum geht, Probleme mit dem Service zu lösen.

Logfiles werden also zur Hilfe für den Administrator oder Support geschrieben. 

## 3 Ablageort der Logfiles und Einstellungsmöglichkeiten

Im folgenden habe ich die einzelnen Pfade der Logfiles erfasst

### Linux Logging im allgemeinen

#### Syslog 

Syslog ist ein Service, welcher entweder auf dem Ursprungshost läuft oder als eigenständiger Server. Die meisten Services können so konfiguriert werden, dass sie den Syslog Service nutzen. Über einen Syslog Service lassen sich Logfiles besser managen und administrieren. Für viele Umgebungen macht ein solcher Server auf jedenfall Sinn. 

#### Journalctl

Journald ist ein Daemon, welcher eng mit Systemd arbeitet. Ein zentraler Teil von Systemd ist der init-Prozess, also der erste Prozess beim booten eines Linux Betriebssystemes. 

Journald sammelt nun alle Daten von Systemd einheitlich und erlaubt es, über die Befehlszeile mit Journalctl auf diese zuzugreifen. Der Vorteil ist, dass Journald unabhängig von mehreren Logfiles ist, der Administrator muss also nicht mehrere Logfiles anschauen. 

### Reverse Proxy

Services: Nginx

Access-Logs: /var/log/nginx/access.log

Error-Logs: /var/log/nginx/error.log

Unter Nginx werden die Log-Einstellungen in den jeweiligen Nginx-Konfiguration Files eingestellt. Das heisst, man kann für jeden Server oder Location ein eigenes Logging bestimmen. 

Die Logs können mit "acess_log" und "error_log" gesetzt werden.

### Container-Host

Services: Docker

Error-Logs: /var/lib/docker/containers/container-id/container-id-json.log

Die Docker Logs können ebenfalls über die Kommandozeile gelesen werden. Mit dem Befehl  

### Website Container

Services: Nginx

Access-Logs: /var/log/nginx/access.log

Error-Logs: /var/log/nginx/error.log

Unter Nginx werden die Log-Einstellungen in den jeweiligen Nginx-Konfiguration Files eingestellt. Das heisst, man kann für jeden Server oder Location ein eigenes Logging bestimmen. 

Die Logs können mit "acess_log" und "error_log" gesetzt werden. Mit Log_format kann das Format der Logs eingestellt werden: Bspw: 

      log_format compression '$remote_addr - $remote_user [$time_local] '
                            '"$request" $status $body_bytes_sent '
                            '"$http_referer" "$http_user_agent" "$gzip_ratio"';

### Wordpress-Container

Services: httpd, php

Error-Log: /var/log/apache2

Error-Log: /wp-content/debug.log

### Nextcloud

Services: httpd, php, mysql

Error-Log: /var/log/nextcloud/nextcloud.log

### Mailserver

Services: Postfix, Dovecot, Nginx

#### Postfix

Allgemeiner Log: /var/log/maillog 

Hier wird der gesamte Mailtraffic geloggt. 

**Log Einstellen**

Die Log-Files könne über /etc/postfix/master.cf angepasst werden.

#### Dovecot

Wenn Dovecot nicht mit Syslog konfiuriert ist, werden folgende Pfade genutzt:

Allgemeiner Log: /var/log/dovecot.log 

Info-Log: /var/log/dovecot-info.log

Debug Log: /var/log/dovecot-debug.log

**Log Einstellen:**

Der Log von Dovecot kann unter /etc/dovecot/dovecot.conf mit folgenden 