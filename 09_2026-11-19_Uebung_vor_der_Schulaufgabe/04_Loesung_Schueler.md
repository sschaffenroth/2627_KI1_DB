# Lösungen · Stunde 09 · Übung vor der Schulaufgabe

**Datenbanken · Fachschule für Künstliche Intelligenz · 19.11.2026**

> Schreibweise: Primärschlüssel <u>unterstrichen</u>, Fremdschlüssel am Namen erkennbar (wie im Buch). Alle Ergebnisse und Fehlermeldungen sind in SQLite nachgeprüft. Alles ausgedacht.

---

## Fehler-Schnellcheck

| | Fehler | Richtig |
|---|---|---|
| **F1** | Fremdschlüssel auf der 1-Seite — Abteilung 1 bräuchte drei Personalnummern in einem Feld | `mitarbeiter`: … · abteilung_nr |
| **F2** | Nur `halter_id` als Schlüssel — Petras zweite Übernahme wird abgelehnt (`UNIQUE constraint failed: uebernahme.halter_id`) | beide unterstreichen: halter_id und tier_nr |
| **F3** | `datum` und `schutzgebuehr` gehören zur Übernahme, nicht zum Tier | `uebernahme`: halter_id · tier_nr · datum · schutzgebuehr |
| **F4** | 1:1 auf der falschen Seite — bei Springern bleibt das Feld leer | `gehege`: … · personalnummer — 0 leere Felder |
| **F5** | `= NULL` findet nie etwas, ohne Fehlermeldung | `WHERE email IS NULL` |
| **F6** | Text ohne Hochkommas — `no such column: Tyll` | `WHERE titel = 'Tyll'` |
| **F7** | `ORDER BY` vor `WHERE` — `near "WHERE": syntax error` | erst `WHERE`, dann `ORDER BY` |
| **F8** | `AND` bindet stärker als `OR` — Sofia Wagner (2024) rutscht hinein | `WHERE (ort = 'Dachau' OR ort = 'Freising') AND eintrittsdatum >= '2025-01-01'` |

---

## Probe-Schulaufgabe

### Teil A — schriftlich

**A1 ER-Modell**

| Entität | Merkmale (ID-Merkmal unterstrichen) |
|---|---|
| FAHRZEUG | <u>kennzeichen</u>, marke, modell, baujahr |
| AUFTRAG | <u>auftrag_nr</u>, datum, beschreibung, status |
| MECHANIKER | <u>personalnummer</u>, name, fachgebiet |
| WERKZEUGWAGEN | <u>wagennummer</u>, standplatz |
| ERSATZTEIL | <u>teilenummer</u>, bezeichnung, preis |

| Beziehung | Anzahl | Woran man es im Text erkennt |
|-----------------------------|-------|-------------------------------------|
| FAHRZEUG — *betrifft* — AUFTRAG | **1 : m** | viele Aufträge je Fahrzeug, jeder Auftrag genau ein Fahrzeug |
| MECHANIKER — *bearbeitet* — AUFTRAG | **1 : m** | jeder Auftrag genau eine Person, jede Person viele Aufträge |
| MECHANIKER — *hat* — WERKZEUGWAGEN | **1 : 1** | genau ein eigener Wagen; ein Wagen gehört höchstens einer Person |
| AUFTRAG — *verbaut* — ERSATZTEIL | **m : m** | mehrere Teile je Auftrag, dasselbe Teil in vielen Aufträgen; Merkmal `menge` |

`menge` gehört an die Beziehung *verbaut*: Sie sagt, wie viel von diesem Teil in diesen Auftrag ging.

**1:1:** `wagennummer` kommt zu MECHANIKER — jede Person hat genau einen Wagen, das Feld ist immer gefüllt. Bei WERKZEUGWAGEN bliebe es für die zwei Reservewagen leer. **Andersherum als beim Gehege im Tierheim.**

**A2 Überführung**

| Tabelle | Kopfzeile (Primärschlüssel unterstrichen, Fremdschlüssel ↑) |
|---|---|
| **fahrzeug** | <u>kennzeichen</u> · marke · modell · baujahr |
| **auftrag** | <u>auftrag_nr</u> · datum · beschreibung · status · kennzeichen ↑ · personalnummer ↑ |
| **mechaniker** | <u>personalnummer</u> · name · fachgebiet · wagennummer ↑ |
| **werkzeugwagen** | <u>wagennummer</u> · standplatz |
| **ersatzteil** | <u>teilenummer</u> · bezeichnung · preis |
| **verbaut** | <u>auftrag_nr</u> ↑ · <u>teilenummer</u> ↑ · menge |

**A3 SQL lesen**

a) M-NW 512 Passat, M-AB 123 Golf, M-RS 310 Polo — die drei VW, das neueste zuerst.

b) Welche Fahrzeuge wurden vor 2016 gebaut — das älteste zuerst? (2016 selbst ist nicht dabei.)

c) anzahl | aeltestes → 2 | 2015 (Corsa und Astra).

**A4**A4 Schlüssel:** Nein — `VW` steht dreimal in der Tabelle. Ein Primärschlüssel muss eindeutig sein; das leistet `kennzeichen`.

### Teil B — am Rechner

**B1 Abfragen**

| | Befehl | Ergebnis |
|--|----------------------------------|----------------|
| a | `SELECT auftrag_nr, datum, beschreibung FROM auftrag WHERE status = 'offen' ORDER BY datum;` | 8 Zeilen: 1017, 1022, 1025, 1026, 1027, 1028, 1029, 1030 |
| b | `SELECT auftrag_nr, beschreibung FROM auftrag WHERE beschreibung LIKE 'Brems%';` | 7 Zeilen: 1002, 1007, 1011, 1015, 1017, 1023, 1027 |
| c | `SELECT bezeichnung, preis FROM ersatzteil ORDER BY preis DESC LIMIT 3;` | Zahnriemensatz 189.0, Batterie 70 Ah 129.0, Bremsbelagsatz vorne 79.0 |
| d | `SELECT kennzeichen, marke, modell FROM fahrzeug WHERE baujahr IS NULL;` | 2 Zeilen: M-DW 1960 (VW Käfer), M-PE 480 (Audi A3) |
| e | `SELECT DISTINCT marke FROM fahrzeug ORDER BY marke;` | 7 Zeilen: Audi, BMW, Ford, Opel, Skoda, Toyota, VW |
| f | `SELECT auftrag_nr, datum, beschreibung FROM auftrag WHERE personalnummer = 12   AND datum BETWEEN '2026-10-01' AND '2026-10-31';` | 3 Zeilen: 1011, 1015, 1017 |

**B2 Zählen und Rechnen**

| | Befehl | Ergebnis |
|--|----------------------------------|----------------|
| a | `SELECT COUNT(*) FROM auftrag WHERE status = 'offen';` | 8 |
| b | `SELECT COUNT(*) AS fahrzeuge, COUNT(baujahr) AS mit_baujahr FROM fahrzeug;` | 15 und 13 |
| c | `SELECT SUM(menge) AS liter FROM verbaut WHERE teilenummer = 'T-41';` | 33 |
| d | `SELECT AVG(preis) AS durchschnitt, MAX(preis) AS teuerstes FROM ersatzteil;` | 45.3766… und 189.0 |

## Ferienübung — Musikschule Klangwerk

LEHRKRAFT 1 — *leitet* — m KURS · LEHRKRAFT 1 — *nutzt* — 1 RAUM · SCHUELER m — *belegt* — m KURS (mit `anmeldedatum`).

| Tabelle | Kopfzeile (Schlüssel unterstrichen) | Regel |
|---|---|---|
| **lehrkraft** | <u>lehrkraft_nr</u> · vorname · nachname · telefon | 1 |
| **raum** | <u>raum_nr</u> · groesse · lehrkraft_nr | 1, 3 |
| **kurs** | <u>kurs_nr</u> · titel · instrument · wochentag · gebuehr · lehrkraft_nr | 1, 2 |
| **schueler** | <u>schueler_nr</u> · vorname · nachname · geburtsjahr | 1 |
| **anmeldung** | <u>schueler_nr</u> · <u>kurs_nr</u> · anmeldedatum | 4 |

1:1 nach `raum`: Jeder Raum hat eine Lehrkraft, nicht jede Lehrkraft einen Raum — wie beim Gehege.

| | Abfrage | Ergebnis |
|---|---|---|
| a | `SELECT titel, wochentag FROM kurs WHERE instrument = 'Gitarre' ORDER BY gebuehr;` | Gitarre für Einsteiger, Gitarre Fortgeschrittene |
| b | `SELECT titel FROM kurs WHERE instrument IS NULL;` | Band-Workshop, Musiktheorie |
| c | `SELECT titel, gebuehr FROM kurs WHERE gebuehr BETWEEN 40 AND 55;` | Gitarre für Einsteiger, Schlagzeug, Gitarre Fortgeschrittene, Gesang |
| d | `SELECT titel FROM kurs WHERE titel LIKE 'Klavier%';` | Klavier Grundstufe, Klavier Mittelstufe |
| e | `SELECT DISTINCT wochentag FROM kurs;` | sechs Tage — alle außer Sonntag |
| f | `SELECT titel, max_plaetze FROM kurs ORDER BY max_plaetze DESC LIMIT 2;` | Musiktheorie (12), Band-Workshop (10) |
| g | wie gegeben: Gitarre für Einsteiger, Klavier Mittelstufe, Gesang. Korrigiert mit Klammern um die beiden Wochentage | Klavier Mittelstufe |
