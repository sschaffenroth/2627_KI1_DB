# SQL-Spickzettel

**Datenbanken · Fachschule für Künstliche Intelligenz · gilt das ganze Schuljahr**

Alle Beispiele laufen gegen die Stadtbibliothek und sind nachgemessen — die angegebenen
Ergebnisse bekommen Sie genau so. Was Sie noch nicht hatten, ist mit dem Termin markiert, an
dem es drankommt.

**Reiter *SQL ausführen*, Anweisung tippen, F5.** Jede Anweisung endet mit einem Semikolon.
Schlüsselwörter groß, eigene Namen klein — das ist Konvention, keine Vorschrift.

---

## Die Tabellen der Bibliothek

```
verlag(verlag_id, name, ort)                                         6 Zeilen
autor(autor_id, nachname, vorname, geburtsjahr, nationalitaet)       8
buch(buch_id, isbn, titel, erscheinungsjahr, seitenzahl,            13
     verlag_id→verlag)
buch_autor(buch_id→buch, autor_id→autor)                            14
exemplar(exemplar_id, inventarnummer, zustand, standort,            26
         buch_id→buch)
leser(leser_id, nachname, vorname, email, ort, eintrittsdatum)      12
ausleihe(ausleihe_id, ausleihdatum, rueckgabe_soll,                 32
         rueckgabe_ist, exemplar_id→exemplar, leser_id→leser)
```

---

## 1 · Abfragen — die Grundform *(ab 22.10.)*

```sql
SELECT  spalten
FROM    tabelle
WHERE   bedingung
GROUP BY spalte
HAVING  bedingung über Gruppen
ORDER BY spalte
LIMIT   anzahl;
```

**Diese Reihenfolge ist Pflicht.** Und sie ist nicht die Reihenfolge, in der gearbeitet wird:

```
FROM  →  WHERE  →  GROUP BY  →  HAVING  →  SELECT  →  ORDER BY  →  LIMIT
```

Deshalb kommt `LIMIT 3` **nach** dem Sortieren zum Zug und liefert wirklich die drei
größten — nicht drei zufällige.

### Auswählen und filtern

| Ziel | So |
|---|---|
| alle Spalten | `SELECT * FROM buch;` |
| bestimmte Spalten | `SELECT titel, erscheinungsjahr FROM buch;` |
| Bedingung | `SELECT * FROM leser WHERE ort = 'München';` → **7** |
| Bereich | `WHERE erscheinungsjahr BETWEEN 2015 AND 2020` → **5** |
| Aufzählung | `WHERE ort IN ('München','Freising')` → **9** |
| Textsuche | `WHERE titel LIKE '%Python%'` → **2** |
| leeres Datenfeld | `WHERE email IS NULL` → **1** (Paul Klein) |
| Verneinung | `WHERE NOT ort = 'München'` · `WHERE email IS NOT NULL` |
| Doppelte weg | `SELECT DISTINCT ort FROM leser;` → **4** |
| Sortieren | `ORDER BY seitenzahl DESC` · `ORDER BY ort, nachname` |
| Nur die ersten | `ORDER BY seitenzahl DESC LIMIT 3;` → Learning Python 1648, Python Cookbook 706, Unterleuten 640 |
| Spalte umbenennen | `SELECT titel AS buchtitel FROM buch;` |
| Texte verbinden | `SELECT vorname \|\| ' ' \|\| nachname FROM leser;` → `Anna Bauer` |

**Platzhalter bei `LIKE`:** `%` steht für beliebig viele Zeichen, `_` für genau eines.

### Die drei Fallen

```sql
WHERE email = NULL        -- FALSCH: liefert immer 0 Zeilen, ohne Fehlermeldung
WHERE email IS NULL       -- richtig
```
`NULL` heißt *unbekannt*. Unbekannt ist mit nichts gleich, nicht einmal mit sich selbst.

```sql
WHERE ort LIKE '%MÜNCHEN%'   -- 0 Zeilen!
WHERE ort LIKE '%münchen%'   -- 7 Zeilen
```
`LIKE` ignoriert Groß- und Kleinschreibung — **aber nur bei a–z**. `Ü` und `ü` sind für SQLite
zwei verschiedene Zeichen.

```sql
WHERE name = 'O'Reilly'      -- Syntaxfehler
WHERE name = 'O''Reilly'     -- richtig: Apostroph verdoppeln
```

---

## 2 · Rechnen und gruppieren *(ab 19.11.)*

| Funktion | Beispiel | Ergebnis |
|---|---|---|
| `COUNT(*)` | `SELECT COUNT(*) FROM ausleihe;` | **32** — zählt Datensätze |
| `COUNT(spalte)` | `SELECT COUNT(rueckgabe_ist) FROM ausleihe;` | **24** — zählt nur, wo etwas drinsteht |
| `COUNT(DISTINCT …)` | `SELECT COUNT(DISTINCT ort) FROM leser;` | **4** — zählt verschiedene Werte |
| `SUM` `AVG` `MIN` `MAX` | `SELECT SUM(seitenzahl), ROUND(AVG(seitenzahl),1), MIN(seitenzahl), MAX(seitenzahl) FROM buch;` | 6992 · 537,8 · 288 · 1648 |

**Der Unterschied zwischen `COUNT(*)` und `COUNT(spalte)` ist der wichtigste der Stunde:**
`COUNT(*)` zählt Datensätze, `COUNT(spalte)` überspringt `NULL`. Die Differenz 32 − 24 = **8** sind
genau die noch nicht zurückgegebenen Ausleihen.

### Gruppieren

```sql
SELECT   ort, COUNT(*) AS anzahl
FROM     leser
GROUP BY ort
ORDER BY anzahl DESC;
```
→ München 7 · Freising 2 · Dachau 2 · Erding 1

**`WHERE` oder `HAVING`?**

```sql
WHERE  ort = 'München'    -- filtert EINZELNE ZEILEN, vor dem Gruppieren
HAVING COUNT(*) > 1       -- filtert GRUPPEN, nach dem Gruppieren
```

Eine Aggregatfunktion in `WHERE` gibt es nicht. `WHERE COUNT(*) > 1` bricht ab — mit
`misuse of aggregate: COUNT()`, wenn ein `GROUP BY` dabeisteht, sonst mit
`misuse of aggregate function COUNT()`. Der Grund ist derselbe: Wenn `WHERE` arbeitet,
existieren noch gar keine Gruppen, die man zählen könnte.

---

## 3 · Mehrere Tabellen verbinden *(ab 26.11.)*

```sql
SELECT b.titel, v.name
FROM   buch b
JOIN   verlag v ON b.verlag_id = v.verlag_id;
```
→ **13** Datensätze. Das `b` und `v` sind Kurznamen (Alias), damit man `b.titel` schreiben kann.

**Ohne `ON` entsteht das kartesische Produkt:** `FROM buch, verlag` liefert 13 × 6 = **78**
sinnlose Kombinationen. Wer plötzlich viel zu viele Datensätze bekommt, hat die Bedingung
vergessen.

| Art | Was sie tut |
|---|---|
| `JOIN` (= `INNER JOIN`) | nur Datensätze, die auf beiden Seiten einen Partner haben |
| `LEFT JOIN` | **alle** Datensätze der linken Tabelle, auch die ohne Partner — die Merkmale der rechten Tabelle sind dann `NULL` |

```sql
SELECT COUNT(*) FROM leser l LEFT JOIN ausleihe a ON a.leser_id = l.leser_id;
```
→ **33**: die 32 Ausleihen plus ein Datensatz für Paul Klein, der noch nie etwas ausgeliehen hat.
Mit `JOIN` statt `LEFT JOIN` wären es 32 — Paul Klein fiele lautlos heraus.

**„Wer hat noch nie …" — das Muster mit `LEFT JOIN` und `IS NULL`:**

```sql
SELECT l.nachname
FROM   leser l
LEFT JOIN ausleihe a ON a.leser_id = l.leser_id
WHERE  a.ausleihe_id IS NULL;
```
→ **Klein**

**Über die Beziehungstabelle bei m:m** — zwei Sprünge statt einem:

```sql
SELECT b.titel, a.nachname
FROM   buch b
JOIN   buch_autor ba ON ba.buch_id  = b.buch_id
JOIN   autor a       ON a.autor_id = ba.autor_id;
```
→ **14** Datensätze. Mehr als 13, weil ein Buch zwei Autoren hat.

**`JOIN` und `GROUP BY` zusammen:**

```sql
SELECT   v.name, COUNT(b.buch_id) AS buecher
FROM     verlag v
LEFT JOIN buch b ON b.verlag_id = v.verlag_id
GROUP BY v.verlag_id
ORDER BY buecher DESC;
```
→ dtv 4 · O'Reilly 3 · Suhrkamp 2 · Rowohlt 2 · Hanser 1 · Springer 1

Hier ist `COUNT(b.buch_id)` und nicht `COUNT(*)` entscheidend: `COUNT(*)` würde bei einem
Verlag ohne Bücher den `NULL`-Datensatz mitzählen und **1** statt **0** liefern.

---

## 4 · Tabellen anlegen *(per Dialog seit 15.10., in SQL ab 17.12.)*

```sql
CREATE TABLE kunde (
    kunde_id INTEGER PRIMARY KEY,
    name     TEXT    NOT NULL,
    email    TEXT    UNIQUE,
    ort      TEXT    NOT NULL DEFAULT 'München'
) STRICT;

CREATE TABLE bestellung (
    bestellung_id INTEGER PRIMARY KEY,
    datum    TEXT NOT NULL,
    betrag   REAL NOT NULL CHECK (betrag > 0),
    status   TEXT NOT NULL DEFAULT 'offen'
             CHECK (status IN ('offen','bezahlt','storniert')),
    kunde_id INTEGER NOT NULL REFERENCES kunde(kunde_id)
) STRICT;
```

| Baustein | Bedeutung |
|---|---|
| `INTEGER PRIMARY KEY` | Schlüsselmerkmal. SQLite vergibt den nächsten freien Wert von selbst |
| `REFERENCES ziel(spalte)` | Fremdschlüssel — der Wert muss drüben existieren |
| `NOT NULL` | darf nicht leer bleiben |
| `UNIQUE` | darf nicht doppelt vorkommen |
| `CHECK (…)` | Wert muss die Bedingung erfüllen |
| `DEFAULT wert` | wird eingetragen, wenn nichts angegeben ist |
| `) STRICT;` | **Hausregel seit Stunde 02** — ohne dieses Wort ist der Datentyp nur ein Vorschlag |

**Datentypen in `STRICT`-Tabellen:** nur `INTEGER`, `REAL`, `TEXT`, `BLOB`, `ANY`. Ein Datum
wird als `TEXT` im Format `'2026-11-12'` geschrieben — so sortiert es richtig.
`VARCHAR(50)` oder `DATETIME` aus einem Internet-Beispiel lehnt SQLite ab.

**Die fünf Fehlermeldungen, die Sie kennen sollten** — sie sind kein Ärgernis, sondern die
Datenbank bei der Arbeit:

```
UNIQUE constraint failed: kunde.email
NOT NULL constraint failed: kunde.name
CHECK constraint failed: betrag > 0
FOREIGN KEY constraint failed
cannot store TEXT value in REAL column bestellung.betrag     ← nur mit STRICT
```

---

## 5 · Daten pflegen *(ab 17.12.)*

```sql
INSERT INTO verlag (name, ort) VALUES ('Diogenes', 'Zürich');

UPDATE leser SET ort = 'Freising' WHERE ort = 'München';

DELETE FROM verlag WHERE name = 'Diogenes';
```

> ### Die Regel, die Sie nie brechen dürfen
>
> **Jedes `UPDATE` und jedes `DELETE` wird zuerst als `SELECT` mit derselben
> `WHERE`-Bedingung geschrieben.** Stimmt die Anzahl der Datensätze, ersetzen Sie nur den
> vorderen Teil.

```sql
SELECT * FROM leser WHERE ort = 'München';      -- erst: 7 Zeilen. Passt das?
UPDATE leser SET ort='Freising' WHERE ort='München';   -- dann: 7 geändert
```

`UPDATE` ohne `WHERE` ändert **alle** Datensätze. Es kommt keine Rückfrage, keine Warnung, nur die
Meldung, dass es geklappt hat. Das ist der häufigste Datenverlust im Berufsalltag.

### Struktur ändern

```sql
ALTER TABLE leser ADD COLUMN telefon TEXT;    -- Spalte anhängen
ALTER TABLE leser DROP COLUMN telefon;        -- Spalte entfernen
ALTER TABLE leser RENAME COLUMN ort TO wohnort;
DROP TABLE test_beitrag;                      -- Tabelle weg, ohne Rückfrage
```

**Was `ALTER TABLE` kann und was nicht:**

| geht | geht nicht |
|---|---|
| Merkmal anhängen, entfernen, umbenennen | Datentyp eines Merkmals ändern |
| Tabelle umbenennen | Constraint hinzufügen oder entfernen |
| | `STRICT` nachrüsten |

Der Primärschlüssel lässt sich nicht entfernen — `ALTER TABLE leser DROP COLUMN leser_id;`
meldet `cannot drop PRIMARY KEY column: "leser_id"`.

Für alles in der rechten Spalte gibt es nur einen Weg: neue Tabelle anlegen, mit
`INSERT INTO neu SELECT * FROM alt;` umkopieren, alte löschen, neue umbenennen. Deshalb lohnt
es sich, das Schema vor dem Befüllen richtig zu entwerfen.

---

## 6 · Nachschlagen im Programm

```sql
SELECT sqlite_version();                              -- welche SQLite-Fassung
PRAGMA foreign_keys;                                  -- 1 = Prüfung ist an
SELECT name FROM sqlite_master WHERE type='table';    -- welche Tabellen gibt es
PRAGMA table_info(buch);                              -- welche Spalten hat buch
SELECT typeof(seitenzahl) FROM buch LIMIT 1;          -- was steht wirklich drin
```

`typeof()` ist der Detektiv: Es zeigt, was in einem Datenfeld **tatsächlich** liegt — nicht, was
laut Definition des Merkmals drinstehen sollte. In einer Tabelle ohne `STRICT` können die beiden
auseinanderfallen.

---

## 7 · Wenn eine Abfrage nicht tut, was sie soll

| Beobachtung | Meist die Ursache |
|---|---|
| `no such column: München` | Text ohne Anführungszeichen. Textwerte gehören in `'…'` |
| `no such column: x` bei richtigem Merkmal | Tippfehler, oder das Merkmal gehört zur anderen Tabelle |
| 0 Datensätze, obwohl es Treffer geben müsste | `= NULL` statt `IS NULL`, oder Umlaut in `LIKE`, oder Tippfehler im Wert |
| Viel zu viele Datensätze | `ON`-Bedingung im `JOIN` fehlt → kartesisches Produkt |
| Datensätze fehlen, die dastehen müssten | `JOIN` statt `LEFT JOIN`, oder Bedingung im `WHERE` statt im `ON` |
| `misuse of aggregate…COUNT()` | `COUNT` in `WHERE` — es gehört in `HAVING` |
| `incomplete input` | Semikolon oder schließende Klammer fehlt |
| Ergebnis stimmt, ist aber trotzdem falsch | Text in einem Zahlenmerkmal. `typeof()` prüfen, Tabelle mit `STRICT` neu anlegen |

**Die letzte Zeile ist die unangenehmste**, weil keine Fehlermeldung kommt. Genau deshalb
bekommt jede Tabelle, die Sie selbst anlegen, ein `STRICT`.
