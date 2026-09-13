# Beispieldatenbank „Stadtbibliothek"

Die Datenbank, die das ganze Halbjahr trägt. Dieselbe Domäne, die in Stunde 06 als
ER-Modell entsteht und in Stunde 08 zum relationalen Schema wird.

## Einrichten (5 Minuten, in Stunde 02)

1. **DB Browser for SQLite** starten (portable Version, kein Installer nötig).
2. *Neue Datenbank* → als `bibliothek.db` speichern → den Tabellen-Dialog abbrechen.
3. Reiter *SQL ausführen* → Inhalt von `bibliothek.sql` einfügen → **F5**.
4. *Änderungen schreiben* klicken. Fertig.

Kontrolle: `SELECT COUNT(*) FROM buch;` muss **13** liefern.

## Tabellen

| Tabelle | Zeilen | Inhalt |
|---|---|---|
| `verlag` | 6 | Verlage mit Ort |
| `autor` | 8 | Autorinnen und Autoren |
| `buch` | 13 | Werke mit ISBN, Jahr, Seitenzahl, Verlag |
| `buch_autor` | 14 | Auflösung der n:m-Beziehung Buch ↔ Autor |
| `exemplar` | 26 | Physische Exemplare mit Inventarnummer, Zustand, Standort |
| `leser` | 12 | Ausweisinhaber |
| `ausleihe` | 32 | Ausleihvorgänge; `rueckgabe_ist IS NULL` = noch draußen |

## Beziehungen

```
verlag 1 ──< n buch n >── buch_autor ──< n autor
                 │
                 1
                 │
                 n
             exemplar 1 ──< n ausleihe n >── 1 leser
```

## Absichtlich eingebaute Lehr-Fälle

Diese Eigenheiten der Daten sind kein Zufall — sie tragen jeweils eine Aufgabe:

| Fall | Wo | Wofür |
|---|---|---|
| `leser.email` ist bei Paul Klein `NULL` | Stunde 04 | `IS NULL` statt `= NULL` |
| Paul Klein hat keine einzige Ausleihe | Stunde 12 | `LEFT JOIN` gegen `INNER JOIN` |
| „Zwischen Welten" wurde nie ausgeliehen | Stunde 12 | `LEFT JOIN` über drei Tabellen |
| 8 Ausleihen ohne Rückgabedatum | Stunde 04/05 | Offene Ausleihen filtern |
| 4 Rückgaben nach Frist | Stunde 05 | Vergleich zweier Datumsspalten |
| „Python Cookbook" hat zwei Autoren | Stunde 06/12 | n:m ist real, nicht konstruiert |
| Verlag „O'Reilly" enthält ein Apostroph | Stunde 04 | Escaping in SQL-Strings (`''`) |
| Ein Exemplar hat Zustand `defekt` | Stunde 05 | `CHECK`-Constraint sichtbar machen |

## Hinweis zu den Daten

Alle Personen sind erfunden, die E-Mail-Adressen liegen auf `example.org` und gehen
damit nirgendwohin. Titel, ISBN und Verlage sind realen Büchern nachempfunden, damit
die Daten plausibel wirken — für den Unterricht reicht das, als bibliografische
Quelle taugen sie nicht.
