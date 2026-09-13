# Skript · Stunde 02 · Grundlagen der Datenorganisation

**Datenbanken · Fachschule für Künstliche Intelligenz · 24.09.2026**

*Lesefassung. Die Vorlage zum Ausfüllen bekommen Sie im Unterricht auf Papier — hier sind die Schreiblinien entfernt.*

*In diesem Skript: die Arbeitsaufträge der Stunde · die Hausaufgabe.*

*Mitbringen: die `Vereinsliste.csv` aus Stunde 01 — vom Stick oder aus dem Netzlaufwerk.*


---

## Arbeitsaufträge

### P1 — Ihre Liste wird eine Datenbank (22 min, Einzel- oder Partnerarbeit am Rechner)

Letzte Woche haben Sie die **Vereinsliste** des TSV auseinandergenommen und drei Wörter dafür
gefunden: Redundanz, Widerspruch, Suchbarkeit. Heute kommt genau diese Liste in eine echte
Datenbank — unverändert, so wie sie ist. Sie werden sehen, was dabei herauskommt.

#### Teil A — Importieren

**a)** DB Browser for SQLite starten. Schaltfläche **Neue Datenbank**. Dateiname
`verein_<IhrNachname>.db`, gespeichert in Ihrem eigenen Ordner. Der Dialog *Tabelle definieren*
springt auf — **Abbrechen**. Die Tabelle kommt gleich aus der Datei.

**b)** Menü **Datei → Importieren → Tabelle aus CSV-Datei…** und `Vereinsliste.csv` auswählen.
Im Dialog einstellen:

| Feld | Wert |
|---|---|
| Tabellenname | `mitglieder` |
| Feldtrenner | **Semikolon `;`** |
| Zeichenkodierung | **UTF-8** |
| *Spaltennamen in erster Zeile* | **Häkchen setzen** |

Die Vorschau muss **11 Spalten** zeigen, beginnend mit `Nr`. Erst dann auf *OK*.

**c) Änderungen schreiben** (Strg+S). Ohne diesen Klick ist nichts gespeichert.

#### Teil B — Was hat der Import daraus gemacht?

**d)** Reiter **Datenbankstruktur**, Tabelle `mitglieder` aufklappen. Welchen Datentyp hat die
Spalte `Nr`? … Und `PLZ`? … Und `Beitrag`?

Was fällt Ihnen bei allen elf Spalten auf?

**e)** Reiter **Daten durchsuchen**. Wie viele Datensätze enthält `mitglieder`?

#### Teil C — Vier Klicks, vier Entdeckungen

Sie klicken jetzt nur auf **Spaltenüberschriften**. Ein Klick sortiert. Nicht doppelklicken —
Zellen sind hier direkt editierbar.

**f)** Auf `Nr` klicken. Notieren Sie die ersten **sechs** Werte von oben nach unten:

Ist das die Reihenfolge, die Sie erwartet haben? Woran könnte das liegen?

**g)** Auf `Geburtstag` klicken. Der oberste Eintrag ist ….
Wonach ist die Spalte sortiert — nach Jahr, nach Monat oder nach Tag?

**h)** Auf `Trainer` klicken. Wie viele **verschiedene Schreibweisen** stehen untereinander?
… Wie viele **Personen** sind das in Wirklichkeit?

Und dieselbe Frage für `Telefon Trainer`: wie viele verschiedene Nummern?

**i)** Auf `Mitglied` klicken. Wer steht mehrfach in der Liste? Und was ist mit **Anna Baur**
in Zeile 7 — eine eigene Person oder ein Tippfehler? Woran würden Sie das entscheiden?

#### Teil D — Eine gebaute Datenbank daneben

**j)** *Datenbank öffnen* → `bibliothek.db`. Reiter **Datenbankstruktur**: Wie viele Tabellen
enthält sie? … Notieren Sie die Namen.

Welche Datentypen stehen hier bei den Spalten — auch überall `TEXT`?

**k)** Tabelle `buch`, Spalte `verlag_id`. Dort stehen nur Zahlen, keine Verlagsnamen. Was
vermuten Sie: wofür steht diese Zahl?

*Es gibt heute noch keine endgültige Antwort — wir klären das in Stunde 03. Jede begründete
Vermutung zählt.*

**l) Zum Schluss:** *Datenbank speichern unter* → `bibliothek_<IhrNachname>.db`, in Ihrem
eigenen Ordner. Kontrollieren Sie, dass **beide** Dateien wirklich da sind — `verein_….db`
und `bibliothek_….db`. Sie brauchen beide wieder.

---

### P2 — Szenarien zuordnen (12 min, Gruppenarbeit zu viert)

Sie erhalten zehn Szenariokarten. Ordnen Sie jeder Karte **einen** Datenbanktyp zu und begründen Sie in einem Satz.

Zur Auswahl: **relational · dokumentenorientiert · Key-Value · Graph · Vektor**

Nutzen Sie den Auswertungsbogen auf dem Kartensatz.

**Regel für die Gruppe:** Erst jede und jeder für sich zwei Minuten, dann besprechen. Wer sofort losredet, hat schon gewonnen — aber die Gruppe hat verloren.

---

### P3 — Die drei Wörter wiederfinden (6 min, Gruppenarbeit)

Sie haben die Vereinsliste eben in der Datenbank vor sich gehabt. Die drei Wörter aus
Stunde 01 sind dort alle drei nachweisbar.

**a)** Nennen Sie zu **jedem** der drei Wörter **eine** Stelle in `mitglieder`, an der Sie es
gerade gesehen haben. Spaltenname genügt.

Redundanz:

Widerspruch:

Suchbarkeit:

**b)** Der Import hat aus der Liste eine Datenbanktabelle gemacht. Ist damit eines der drei
Probleme gelöst? Begründen Sie in einem Satz.

**c)** Nennen Sie **zwei** Aufgaben eines DBMS aus dem Input von heute, die diese Probleme
lösen *würden* — wenn die Tabelle richtig gebaut wäre.

1.

2.

---

### P4 — Die Mehrbenutzerfrage (4 min, Einzelarbeit)

Zwei Mitarbeiter der Werkstatt öffnen dieselbe Auftragsliste. Beide tragen zur selben Zeit eine Arbeitsstunde bei Auftrag 4711 ein.

**a)** Was passiert in einer Excel-Datei auf einem Netzlaufwerk?

**b)** Was macht ein Datenbanksystem anders?

---

### V1 — Drei Ebenen im Alltag (7 min, Einzelarbeit)

Nutzen Sie die Erfahrung von eben: „Datenbankstruktur" war die konzeptionelle Ebene, „Daten durchsuchen" mit Filter eine externe Sicht, die Datei `bibliothek.db` auf der Platte die interne Ebene.

Ordnen Sie jede Aussage der richtigen Ebene zu: **E** = extern, **K** = konzeptionell, **I** = intern.

| | Aussage | Ebene |
|---|---|---|
| a | „In der Tabelle *Auftrag* steht eine Spalte, deren Wert auf eine Zeile der Tabelle *Kunde* zeigt." | |
| b | „Der Meister sieht in seiner Ansicht nur die offenen Aufträge seiner Halle." | |
| c | „Auf der Spalte *Auftragsnummer* liegt ein Index, damit die Suche schneller geht." | |
| d | „Die Datenbank liegt seit gestern auf einer SSD statt auf einer Festplatte." | |
| e | „Die Lohnbuchhaltung darf das Gehaltsfeld sehen, der Einkauf nicht." | |
| f | „Ein Kunde hat genau eine Kundennummer, und die ist eindeutig." | |

**Anschlussfrage:** Bei welchen der sechs Änderungen müssen die Anwendungsprogramme angepasst werden? Warum ist das eine gute Nachricht?

---

### Z1 — Zusatz: Es gibt keine eine Antwort (freiwillig)

Suchen Sie **zwei** Karten heraus, bei denen ein zweiter Typ ebenfalls vertretbar wäre.

Beschreiben Sie für jede: Welcher zweite Typ? Was gewinnt man, was verliert man?

Karte …:

Karte …:

*Diese Abwägung ist genau das, was Sie im Projekt im Juli begründen müssen.*

---

## Hausaufgabe

**Gestellt:** Do 24.09.2026 · **Fällig:** Do 01.10.2026, zu Stundenbeginn

---

### Auftrag: DBMS-Steckbrief

Ihre Gruppe (2–3 Personen) hat ein Datenbanksystem gezogen. Erstellen Sie dazu einen Steckbrief und stellen Sie ihn in **2 Minuten** vor.

Die Systeme:

| | System | | System |
|---|---|---|---|
| 1 | SQLite | 5 | Microsoft SQL Server |
| 2 | MySQL / MariaDB | 6 | MongoDB |
| 3 | PostgreSQL | 7 | Neo4j |
| 4 | Oracle Database | 8 | Redis |

### Gliederung — genau diese fünf Punkte, in dieser Reihenfolge

1. **Name, Hersteller, Lizenz** — kommerziell, quelloffen oder beides? Was kostet es?
2. **Typ** — relational, dokumentenorientiert, Key-Value oder Graph?
3. **Typischer Einsatz** — ein konkretes Beispiel, kein „für Datenbanken halt"
4. **Eine Stärke** — wofür würde man es bewusst wählen?
5. **Eine Schwäche oder Grenze** — wofür würde man es bewusst **nicht** wählen?

Die Reihenfolge ist verbindlich, damit die acht Vorträge vergleichbar sind und wir daraus an der Tafel eine Übersichtstabelle bauen können.

### Form

Eine halbe DIN-A4-Seite, gerne handschriftlich. **Kein Foliensatz.** Zwei Minuten sind kurz — üben Sie einmal mit der Uhr.

### Quellen

Beginnen Sie bei der Herstellerseite und der deutschen Wikipedia. Prüfen Sie mindestens eine Angabe an einer zweiten Quelle nach — besonders bei Lizenz und Preis, da steht viel Veraltetes im Netz. Nennen Sie Ihre Quellen am Ende des Blattes.

### Bewertung

Der Steckbrief geht als mündliche Note ein. Bewertet werden: Vollständigkeit der fünf Punkte, Konkretheit von Punkt 3 und die Ehrlichkeit von Punkt 5. Wer als Schwäche „ist manchmal langsam" schreibt, hat nicht recherchiert.

### Zusatzfrage für schnelle Gruppen

Findet Ihr System sich in einem der zehn Szenarien von heute wieder? In welchem, und warum gerade dort?
