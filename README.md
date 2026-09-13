# Datenbanken — Klassenrepository KI 1, Schuljahr 2026/27

Fachschule für Künstliche Intelligenz · 1. Schuljahr · Donnerstag, 1./2. Stunde

Hier liegt das Material aus dem Unterricht: je Termin ein Ordner mit dem Skript
der Stunde und den Dateien, mit denen wir gearbeitet haben. Die Lösungen kommen
jeweils eine Woche später dazu.

> Diese Datei wird bei jedem Hochladen überschrieben. Wer etwas ändern will,
> sagt es der Lehrkraft.

---

## Wenn Sie nur die Dateien brauchen

Sie müssen für dieses Repository **kein Git können**. Auf der Seite oben rechts
auf **Code → Download ZIP**, entpacken, fertig. Einzelne Dateien lassen sich
auch direkt im Browser lesen — Markdown (`.md`) wird von GitHub gleich
lesbar dargestellt.

## Wenn Sie mit Git arbeiten wollen

Das ist der Weg, den wir empfehlen: Sie holen sich Änderungen ab, ohne jedes
Mal alles neu herunterzuladen.

```
git clone https://github.com/sschaffenroth/2627_KI1_DB.git
cd 2627_KI1_DB
```

Einmalig sagen, wer Sie sind — **`user.email`**, nicht `user.mail`:

```
git config --global user.name  "Vorname Nachname"
git config --global user.email "vorname.nachname@example.org"
```

Später neuen Stand abholen:

```
git pull
```

**Arbeiten Sie in einer Kopie.** Die Dateien hier werden bei jedem Hochladen
überschrieben — was Sie direkt hineinschreiben, ist beim nächsten `git pull`
weg. Legen Sie sich für eigene Lösungsversuche einen eigenen Ordner an,
oder arbeiten Sie in einem eigenen Branch:

```
git switch -c loesungen-nachname
```

---

## Was hier liegt

| Ordner | Inhalt |
|---|---|
| `NN_JJJJ-MM-TT_Thema/` | ein Ordner je Unterrichtstermin |
| `00_Beispieldatenbank/` | `bibliothek.sql` — die Stadtbibliothek, unser Beispiel für das ganze Jahr |

In jedem Stundenordner steht eine kurze `README.md`, die die Dateien der Stunde
auflistet. Wiederkehrende Dateien:

| Datei | Was es ist |
|---|---|
| `02_Skript.md` | das Skript der Stunde: Material zum Nachlesen, die Arbeitsaufträge und die Hausaufgabe |
| `04_Loesung_Schueler.md` | die Lösungen — erscheint **eine Woche nach** der Stunde |
| `05_Uebungen.sql` | SQL-Datei zum Mitarbeiten |
| `05_SQL_Spickzettel.md` | der Spickzettel, gilt das ganze Jahr (liegt bei Stunde 04) |
| `05_Inbetriebnahme_DB_Browser.md` | Anleitung zum Einrichten, gilt das ganze Jahr (liegt bei Stunde 02) |

Verlaufspläne, Folien und die Lehrerfassung der Lösungen liegen **nicht** hier.

---

## Die Beispieldatenbank aufbauen

Sie brauchen den **DB Browser for SQLite** (portabel, kostenlos, ohne
Administratorrechte — Anleitung im Ordner der Stunde vom 24.09.).

1. DB Browser starten → **Neue Datenbank** → als `bibliothek_<IhrNachname>.db`
   in Ihrem eigenen Ordner speichern
2. Den Dialog *Tabelle definieren* **abbrechen**
3. Reiter **SQL ausführen** → Ordnersymbol *SQL-Datei öffnen* →
   `00_Beispieldatenbank/bibliothek.sql`
4. **F5** — das Skript läuft durch
5. **Änderungen schreiben** (Strg+S). Ohne diesen Klick ist nichts gespeichert

Kontrolle: Reiter *Datenbankstruktur* zeigt sieben Tabellen, Tabelle `buch`
enthält 13 Datensätze.

Dieser Weg stellt jederzeit den Ursprungszustand wieder her — wenn ein
Experiment schiefgeht, fangen Sie einfach neu an.

**`.db`-Dateien gehören nicht ins Repository** und werden von der `.gitignore`
ferngehalten. Die Datenbank baut sich jede und jeder selbst aus dem SQL-Skript;
so bleibt hier nur Text, den man auch in einem Jahr noch lesen kann.

---

## Spielregeln

- **Erfundene Testdaten, immer.** Echte Kunden-, Patienten-, Schüler- oder
  Personaldaten haben in einer Schulübung nichts zu suchen — auch nicht
  „nur zum Testen", und erst recht nicht in einem öffentlichen Repository.
- Dieses Repository ist **öffentlich**. Was Sie hier hochladen, kann jeder
  lesen. Überlegen Sie das einmal, bevor Sie etwas pushen.
- Keine Zugangsdaten, keine Passwörter, keine Schlüssel — auch nicht in einem
  Kommentar und auch nicht „nur kurz zum Ausprobieren". Was einmal in der
  Historie steht, bleibt dort.
