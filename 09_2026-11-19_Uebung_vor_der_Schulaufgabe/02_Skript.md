# Stunde 09 · Übung vor der Schulaufgabe

**Datenbanken · Do 19.11.2026 · Fachschule für KI**

*Lesefassung. Die Vorlage zum Ausfüllen bekommen Sie im Unterricht auf Papier — hier sind die Schreiblinien entfernt.*

Heute ist die letzte Stunde vor der Schulaufgabe am **26.11.** Es gibt keinen neuen Stoff — die Aggregation vom 12.11. kommt in der Schulaufgabe nicht dran. Sie schreiben eine Probe-Schulaufgabe unter echten Bedingungen, **wie am 26.11. in zwei Teilen: schriftlich und am Rechner**, und sehen danach genau, wo Sie stehen.

---

## Der Fahrplan der Stunde

| | Phase | Frage |
|---|---|---|
| **1** | Probe Teil A — schriftlich, 30 Minuten | Schaffe ich ER-Modell, Überführung und SQL lesen ohne Rechner? |
| **2** | Probe Teil B — am Rechner, 30 Minuten | Schreibe ich SQL, das läuft und das Richtige liefert — auch beim Zählen und Rechnen? |
| **3** | Besprechung | Wo habe ich Punkte verloren? |
| **4** | Was in der Schulaufgabe kommt | Was lerne ich bis zum 26.11.? |

---

## 1 und 2 — Probe-Schulaufgabe

Zwei eigene Blätter, Einzelarbeit: kein Austausch, Handy weg. Teil A ohne Hilfsmittel; in Teil B DB Browser und eigene Unterlagen, kein Internet, keine KI.

- **Teil A — schriftlich, 30 Minuten:** ER-Modell aus einem Sachtext, Überführung, SQL lesen (kein SQL schreiben), Schlüssel. Wird nach 30 Minuten eingesammelt.
- **Teil B — am Rechner, 30 Minuten:** Sie bekommen einen USB-Stick mit der Datenbank der Werkstatt (`Werkstatt.db`). Abfragen schreiben, zählen und rechnen (`COUNT`, `SUM`, `AVG`, `MAX`); alle Befehle in `DB_Vorname_Nachname.sql` auf dem Stick.

---

## 3 — Meine Punkte

| Aufgabe | Thema | möglich | erreicht | Was ich wiederholen muss |
|-----------|----------------|-----------|------------|-------------------------------|
| A1 | ER-Modell | 14 | | |
| A2 | Überführung | 8 | | |
| A3 | SQL lesen | 6 | | |
| A4 | Schlüssel | 2 | | |
| B1 | Abfragen | 20 | | |
| B2 | Zählen und Rechnen | 10 | | |
| | **Summe** | **60** | | |

---

## 4 — Was in der Schulaufgabe am 26.11. kommt

| Teil | Was Sie können müssen | Nachlesen |
|---|---|---|
| **ER-Modell** | aus einem Sachtext Entitäten, Merkmale und ID-Merkmal finden (Nominalextraktion); Beziehungen benennen; Anzahlangaben 1:1, 1:m, m:m; Merkmale an Beziehungen | Skript 03, Buch Kap. 3, 4 |
| **Überführung** | die vier Regeln; Tabellen wie im Buch (Kopfzeile, Schlüssel unterstrichen); bei 1:1 mit den leeren Feldern begründen; Beziehungstabelle mit zusammengesetztem Schlüssel | Skript 04 und 05, Buch Kap. 5 |
| **Schlüssel** | was Primär- und Fremdschlüssel dürfen; ob ein Merkmal als Primärschlüssel taugt | Skript 05 |
| **Am Rechner** | an einer fertigen Datenbank im DB Browser Abfragen schreiben, ausführen und in einer `.sql`-Datei speichern | Skript 06, Teil B der Probe |
| **SQL auf einer Tabelle** | `SELECT`, `FROM`, `WHERE` mit Vergleichen, `AND`/`OR`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`; `ORDER BY`, `LIMIT`, `DISTINCT`, `AS`; **zählen und rechnen** mit `COUNT(*)`, `COUNT(spalte)`, `SUM`, `AVG`, `MIN`, `MAX`; ein Ergebnis aus einer Tabelle ablesen | Skript 06, Selbstlernkurs 12.11., Spickzettel Teil 1 |
| **nicht dabei** | Gruppieren (`GROUP BY`), mehrere Tabellen (`JOIN`, kommt am 03.12.), Normalisierung, `CREATE TABLE` von Hand | — |

**So läuft die Schulaufgabe am 26.11.:** 60 Minuten, aufgebaut wie die Probe — **Teil A schriftlich** (30 Minuten, keine Hilfsmittel), **Teil B am Rechner** (30 Minuten, DB Browser und eigene Unterlagen, kein Internet, keine KI; die Datenbank bekommen Sie auf einem USB-Stick). **Das Spickblatt entfällt.**

**Ich kann …** (abhaken, was sicher sitzt)

- [ ] in einem Text die Nomen finden und entscheiden: Entität, Merkmal oder unwichtig
- [ ] an einer Beziehung die Anzahlangaben mit zwei Sätzen begründen („Ein … hat …")
- [ ] sagen, wohin der Fremdschlüssel bei 1:m, 1:1 und m:m kommt — und warum
- [ ] den Primärschlüssel einer Beziehungstabelle bestimmen und mit „eindeutig und minimal" begründen
- [ ] an einer fertigen Datenbank Abfragen schreiben und in einer `.sql`-Datei speichern
- [ ] mit `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` zählen und rechnen — und `COUNT(*)` von `COUNT(spalte)` unterscheiden
- [ ] eine Abfrage mit `WHERE`, `ORDER BY` und `LIMIT` fehlerfrei schreiben
- [ ] das Ergebnis einer Abfrage aus einer gedruckten Tabelle ablesen
- [ ] erklären, warum `= NULL` nichts findet und warum `AND` vor `OR` Klammern braucht

---

## Zum Nachschlagen: fünf Prüffragen an eine Abfrage

| | Prüffrage | ✓ |
|---|---|---|
| 1 | Reihenfolge: `SELECT` → `FROM` → `WHERE` → `ORDER BY` → `LIMIT` | |
| 2 | Text und Datum in Hochkommas: `'Dachau'`, `'2025-01-01'` — Zahlen ohne | |
| 3 | Spalten- und Tabellennamen genau so wie in der Datenbank | |
| 4 | „Kein Wert" mit `IS NULL`, nie mit `= NULL` | |
| 5 | `AND` und `OR` gemischt? Dann Klammern | |

---

## Fehler-Schnellcheck — freiwillig bis zur Schulaufgabe

Nicht in der Stunde, sondern zum Üben zu Hause (Lösung im Repository). Jede Zeile enthält **einen** Fehler. Was ist falsch? Wie wird es richtig? Ein Satz genügt.

**A — Überführung** (Beispiele vom 15.10.)

| | Gegeben | Fehler und Korrektur |
|---|---|---|
| **F1** | ABTEILUNG 1 — *arbeitet in* — m MITARBEITER wird zur Tabelle `abteilung` mit der Kopfzeile <u>abteilung_nr</u> · bezeichnung · personalnummer | |
| **F2** | HALTER m — *übernimmt* — m TIER wird zur Tabelle `uebernahme` mit der Kopfzeile <u>halter_id</u> · tier_nr · datum · schutzgebuehr | |
| **F3** | Die Übernahme eines Tieres steht in der Tabelle `tier`: <u>tier_nr</u> · rufname · … · gehege_id · datum · schutzgebuehr | |
| **F4** | GEHEGE 1 — *ist verantwortlich* — 1 PFLEGEKRAFT (jedes Gehege hat einen Verantwortlichen, Springer haben keines): Die Gehegenummer kommt in die Tabelle `pflegekraft` — <u>personalnummer</u> · … · gehege_id | |

**B — SQL** (Stadtbibliothek)

| | Gegeben | Fehler und Korrektur |
|---|---|---|
| **F5** | Leser ohne E-Mail-Adresse: `SELECT vorname, nachname FROM leser WHERE email = NULL;` | |
| **F6** | `SELECT titel FROM buch WHERE titel = Tyll;` | |
| **F7** | `SELECT titel, seitenzahl FROM buch ORDER BY seitenzahl DESC WHERE erscheinungsjahr >= 2015;` | |
| **F8** | Leser aus Dachau oder Freising, eingetreten ab 2025: `SELECT vorname, nachname FROM leser WHERE ort = 'Dachau' OR ort = 'Freising' AND eintrittsdatum >= '2025-01-01';` | |

---

## Bis zur Schulaufgabe

**Freiwillig, keine Abgabe.** Die **Übung** (Musikschule Klangwerk) hat dieselben Aufgabenarten wie Teil A der Probe. Nehmen Sie sich 45 Minuten am Stück, ohne Unterlagen, und vergleichen Sie erst danach mit der Lösung im Repository. Für Teil B: die Tabellen der Musikschule im DB Browser anlegen (`06_Musikschule_Kurs.sql` als Start). Dazu: der Fehler-Schnellcheck oben und die Spalte „Was ich wiederholen muss" abarbeiten.
