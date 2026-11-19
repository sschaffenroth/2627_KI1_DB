# Übung vor der Schulaufgabe · Datenbanken

**Freiwillig · zur Vorbereitung auf die Schulaufgabe am 26.11.**

*Lesefassung. Die Vorlage zum Ausfüllen bekommen Sie im Unterricht auf Papier — hier sind die Schreiblinien entfernt.*

Dieselben Aufgabenarten wie in der Probe-Schulaufgabe, an einem neuen Text. Nehmen Sie sich 45 Minuten am Stück, ohne Unterlagen — und vergleichen Sie erst danach mit der Lösung im Repository. Alles hier ist ausgedacht.

---

## Der Sachtext: Musikschule Klangwerk

> Die Musikschule Klangwerk bietet Kurse an. Jeder Kurs hat eine Kursnummer, einen Titel, ein Instrument, einen Wochentag und eine Monatsgebühr. Manche Kurse, etwa die Musiktheorie, haben kein festes Instrument.
>
> Die Lehrkräfte werden mit Lehrkraftnummer, Name und Telefonnummer geführt. Jeder Kurs wird von genau einer Lehrkraft geleitet; eine Lehrkraft leitet meist mehrere Kurse.
>
> Die Musikschule hat Unterrichtsräume mit Raumnummer und Größe. Jeder Raum ist fest einer Lehrkraft zugeordnet, die dort ihre Instrumente und Noten aufbewahrt. Nicht jede Lehrkraft hat einen eigenen Raum — die Honorarkräfte unterrichten bei den Familien zu Hause.
>
> Schülerinnen und Schüler werden mit Schülernummer, Name und Geburtsjahr erfasst. Sie können mehrere Kurse belegen, und ein Kurs hat mehrere Teilnehmende. Für jede Anmeldung wird das Anmeldedatum festgehalten.

---

## Aufgabe 1 — ER-Modell

Entitäten mit Merkmalen und ID-Merkmal, Beziehungen mit Namen und Anzahlangaben. Wohin gehört das Anmeldedatum?

## Aufgabe 2 — Überführung

a) Die Tabellen wie im Buch (Kopfzeile, Schlüssel unterstrichen), hinter jeder Tabelle die Regel.

b) Lehrkraft und Raum: In welche Tabelle kommt der Fremdschlüssel? Begründen Sie mit den leeren Datenfeldern. *(Vorsicht — andersherum als bei der Werkstatt.)*

## Aufgabe 3 — SQL

**kurs**

| kurs_nr | titel | instrument | wochentag | gebuehr | max_plaetze | lehrkraft_nr |
|---|---|---|---|---|---|---|
| 1 | Gitarre für Einsteiger | Gitarre | Montag | 45.00 | 6 | 1 |
| 2 | Klavier Grundstufe | Klavier | Dienstag | 60.00 | 4 | 2 |
| 3 | Band-Workshop | | Freitag | 35.00 | 10 | 1 |
| 4 | Klavier Mittelstufe | Klavier | Donnerstag | 65.00 | 4 | 2 |
| 5 | Schlagzeug | Schlagzeug | Mittwoch | 55.00 | 3 | 3 |
| 6 | Gitarre Fortgeschrittene | Gitarre | Donnerstag | 50.00 | 6 | 1 |
| 7 | Gesang | Gesang | Montag | 40.00 | 8 | 4 |
| 8 | Musiktheorie | | Samstag | 20.00 | 12 | 2 |

a) Titel und Wochentag aller Gitarrenkurse, der günstigste zuerst.

b) Die Titel aller Kurse ohne festes Instrument.

c) Titel und Gebühr aller Kurse, die zwischen 40 und 55 Euro kosten (beide Grenzen gehören dazu).

d) Alle Kurse, deren Titel mit „Klavier" beginnt.

e) An welchen Wochentagen findet überhaupt Unterricht statt? Jeder Tag nur einmal.

f) Die zwei Kurse mit den meisten Plätzen: Titel und Plätze.

g) Ergebnis angeben — und dann so korrigieren, dass nur Kurse über 60 Euro herauskommen:

```sql
SELECT titel
FROM   kurs
WHERE  wochentag = 'Montag' OR wochentag = 'Donnerstag' AND gebuehr > 60;
```

Wer es am Rechner nachprüfen will: Die Datei `06_Musikschule_Kurs.sql` legt die Tabelle an — im DB Browser eine neue Datenbank, Reiter *SQL ausführen*, Datei laden, F5.
