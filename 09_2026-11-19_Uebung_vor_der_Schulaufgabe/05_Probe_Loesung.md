<!-- leistungsnachweis titel="Lösung zur Probe-Schulaufgabe Datenbanken" punkte="60" -->
# Lösung zur Probe-Schulaufgabe · Datenbanken · 19.11.2026

**Zum Selbstkontrollieren nach der Probe.** Ihre Antwort muss nicht wörtlich gleich sein. Entscheidend ist, dass der Kern drinsteht. Die Punkte zeigen, wie in der Schulaufgabe am 26.11. bewertet wird. Alle Ergebnisse und Fehlermeldungen sind in SQLite nachgeprüft.

| Aufgabe | möglich | meine Punkte |
|---|---|---|
| A1 ER-Modell | 14 | |
| A2 Überführung | 8 | |
| A3 SQL lesen | 6 | |
| A4 Schlüssel | 2 | |
| B1 Abfragen | 20 | |
| B2 Zählen und Rechnen | 10 | |
| **Summe** | **60** | |

Für die Probe gibt es keine Note. Faustregel: Mindestens die Hälfte der Punkte in jeder Aufgabe sollte sitzen — wo nicht, dort bis zur Schulaufgabe nacharbeiten.

## Teil A — schriftlich (30 P)

### A1 — ER-Modell (14 P)

**Entitäten** (5 P, je 1 P mit Merkmalen und unterstrichenem ID-Merkmal)

| Entität | Merkmale (ID-Merkmal unterstrichen) |
|---|---|
| FAHRZEUG | <u>kennzeichen</u>, marke, modell, baujahr |
| AUFTRAG | <u>auftrag_nr</u>, datum, beschreibung, status |
| MECHANIKER | <u>personalnummer</u>, name, fachgebiet |
| WERKZEUGWAGEN | <u>wagennummer</u>, standplatz |
| ERSATZTEIL | <u>teilenummer</u>, bezeichnung, preis |

**Beziehungen** (Namen 2 P, je 0,5 · Anzahlangaben 4 P, je 1 · `menge` an der richtigen Stelle 1 P)

| Beziehung | Anzahl | Woran man es im Text erkennt |
|-----------------------------|-------|-------------------------------------|
| FAHRZEUG — *betrifft* — AUFTRAG | **1 : m** | viele Aufträge je Fahrzeug, jeder Auftrag genau ein Fahrzeug |
| MECHANIKER — *bearbeitet* — AUFTRAG | **1 : m** | jeder Auftrag genau eine Person, jede Person viele Aufträge |
| MECHANIKER — *hat* — WERKZEUGWAGEN | **1 : 1** | genau ein eigener Wagen; ein Wagen gehört höchstens einer Person |
| AUFTRAG — *verbaut* — ERSATZTEIL | **m : m** | mehrere Teile je Auftrag, dasselbe Teil in vielen Aufträgen; Merkmal `menge` |

Andere sinnvolle Namen für die Beziehungen zählen genauso. `menge` gehört an die Beziehung *verbaut*: Sie sagt, wie viel von **diesem** Teil in **diesen** Auftrag ging.

**1:1-Begründung** (2 P) Das ID-Merkmal `wagennummer` kommt zu MECHANIKER: Jede Person hat genau einen Wagen, das Feld ist also immer gefüllt. Bei WERKZEUGWAGEN bliebe es für die zwei Reservewagen leer. **Andersherum als beim Gehege im Tierheim.** Ohne Begründung mit den leeren Feldern gibt es nur den Punkt für die Seite.

### A2 — Überführung (8 P)

| Tabelle | Kopfzeile (Primärschlüssel unterstrichen, Fremdschlüssel ↑) |
|---|---|
| **fahrzeug** | <u>kennzeichen</u> · marke · modell · baujahr |
| **auftrag** | <u>auftrag_nr</u> · datum · beschreibung · status · kennzeichen ↑ · personalnummer ↑ |
| **mechaniker** | <u>personalnummer</u> · name · fachgebiet · wagennummer ↑ |
| **werkzeugwagen** | <u>wagennummer</u> · standplatz |
| **ersatzteil** | <u>teilenummer</u> · bezeichnung · preis |
| **verbaut** | <u>auftrag_nr</u> ↑ · <u>teilenummer</u> ↑ · menge |

- je Tabelle mit Name, Kopfzeile und unterstrichenem Primärschlüssel 0,5 P (3 P)
- `kennzeichen ↑` und `personalnummer ↑` in `auftrag` je 1 P (2 P)
- `wagennummer ↑` in `mechaniker` (1 P) — passend zu Ihrer Begründung in A1
- `verbaut`: Primärschlüssel aus beiden Fremdschlüsseln 1 P, `menge` hier 1 P (2 P)

### A3 — SQL lesen (6 P)

**a)** (2 P: Zeilen 1, Reihenfolge 1) **M-NW 512 Passat, M-AB 123 Golf, M-RS 310 Polo** — die drei VW, das neueste zuerst.

**b)** (2 P: Bedingung 1, Sortierung 1) Welche Fahrzeuge wurden vor 2016 gebaut — das älteste zuerst? 2016 selbst ist nicht dabei.

**c)** (2 P: Werte 1, Spaltenüberschriften 1) Eine Zeile: **anzahl | aeltestes → 2 | 2015** — die beiden Opel im Ausschnitt sind der Corsa (2015) und der Astra (2019).

### A4### A4 — Schlüssel (2 P)

Nein. `VW` steht dreimal in der Tabelle, `Opel` und `Skoda` je zweimal. Ein Primärschlüssel muss jeden Datensatz eindeutig kennzeichnen; das leistet hier das `kennzeichen`.

## Teil B — am Rechner (30 P)

### B1 — Abfragen (20 P)

**a)** (4 P: Spalten 1, `WHERE status = 'offen'` mit Hochkommas 2, `ORDER BY datum` ohne `DESC` 1) → 8 Zeilen: 1017, 1022, 1025, 1026, 1027, 1028, 1029, 1030

```sql
SELECT auftrag_nr, datum, beschreibung FROM auftrag
WHERE status = 'offen' ORDER BY datum;
```

**b)** (3 P: Spalten 1, `LIKE` 1, Muster `'Brems%'` 1. `'%Brems%'` findet zusätzlich 1005 „Handbremse einstellen“ (8 Zeilen) — „enthält“ statt „beginnt mit“: 2 P) → 7 Zeilen: 1002, 1007, 1011, 1015, 1017, 1023, 1027

```sql
SELECT auftrag_nr, beschreibung FROM auftrag
WHERE beschreibung LIKE 'Brems%';
```

**c)** (3 P: Spalten 1, `ORDER BY preis DESC` 1, `LIMIT 3` 1) → Zahnriemensatz 189.0, Batterie 70 Ah 129.0, Bremsbelagsatz vorne 79.0

```sql
SELECT bezeichnung, preis FROM ersatzteil
ORDER BY preis DESC LIMIT 3;
```

**d)** (3 P: Spalten 1, `IS NULL` 2. Mit `= NULL` kommt keine Zeile: dafür 0 P) → 2 Zeilen: M-DW 1960 (VW Käfer), M-PE 480 (Audi A3)

```sql
SELECT kennzeichen, marke, modell FROM fahrzeug
WHERE baujahr IS NULL;
```

**e)** (3 P: `DISTINCT` 2 (ohne: 15 Zeilen, Marken doppelt), `ORDER BY` 1) → 7 Zeilen: Audi, BMW, Ford, Opel, Skoda, Toyota, VW

```sql
SELECT DISTINCT marke FROM fahrzeug ORDER BY marke;
```

**f)** (4 P: Spalten 1, `personalnummer = 12` 1, Datumsbereich 1, Datum in Hochkommas 1; `datum >= '2026-10-01' AND datum < '2026-11-01'` gleichwertig. Ohne Datum: 8 Zeilen) → 3 Zeilen: 1011, 1015, 1017

```sql
SELECT auftrag_nr, datum, beschreibung FROM auftrag
WHERE personalnummer = 12
  AND datum BETWEEN '2026-10-01' AND '2026-10-31';
```

### B2 — Zählen und Rechnen (10 P)

**a)** (2 P: `COUNT(*)` 1, `WHERE` 1) → 8

```sql
SELECT COUNT(*) FROM auftrag WHERE status = 'offen';
```

**b)** (3 P: `COUNT(*)` 1, `COUNT(baujahr)` 2 — es zählt nur gefüllte Felder) → 15 und 13

```sql
SELECT COUNT(*) AS fahrzeuge, COUNT(baujahr) AS mit_baujahr
FROM fahrzeug;
```

**c)** (2 P: `SUM(menge)` 1, `WHERE` 1. Mit `COUNT(*)` kommt 7 heraus — das zählt die Aufträge, nicht die Liter: 1 P) → 33

```sql
SELECT SUM(menge) AS liter FROM verbaut
WHERE teilenummer = 'T-41';
```

**d)** (3 P: `AVG` 1, `MAX` 1, Überschriften mit `AS` 1) → 45.3766… und 189.0

```sql
SELECT AVG(preis) AS durchschnitt, MAX(preis) AS teuerstes
FROM ersatzteil;
```
