# Skript · Stunde 01 · Warum Tabellen irgendwann nicht mehr reichen

**Datenbanken · Fachschule für Künstliche Intelligenz · 17.09.2026**

*Lesefassung. Die Vorlage zum Ausfüllen bekommen Sie im Unterricht auf Papier — hier sind die Schreiblinien entfernt.*

---

## 1 · Worum es heute geht

Fast jede Organisation beginnt gleich: Jemand legt eine Tabelle an. Eine Zeile je Fall, eine
Spalte je Angabe. Das funktioniert — eine Weile.

Was danach passiert, kennen Sie vermutlich aus dem Betrieb. Die Tabelle wächst. Verschiedene
Leute pflegen sie. Es kommen Spalten dazu, weil eine neue Frage beantwortet werden muss.
Irgendwann traut niemand mehr den Zahlen, die drinstehen, und keiner kann genau sagen, warum.

Heute sehen Sie sich so eine Tabelle an. Sie sollen sie nicht reparieren. Sie sollen sehen,
**was daran nicht stimmt** — und am Ende der Stunde drei Wörter dafür haben.

---

## 2 · Die Liste

**Mitgliederliste des Sportvereins „TSV Grünwiese", Stand September 2026.**
Geführt seit 2019 in einer einzigen Tabelle, gepflegt von wechselnden Ehrenamtlichen.

Datei: `Vereinsliste.csv` — 15 Zeilen, 11 Spalten.
*(LibreOffice fragt beim Öffnen: Trennzeichen **Semikolon**, Zeichensatz **UTF-8**.)*

Eine einzige Tabelle für drei verschiedene Dinge: **Mitglieder**, **Kurse** und **Trainer**.
Merken Sie sich diesen Satz — er ist die Erklärung für fast alles, was Sie gleich finden.

Am Rand der Liste steht ein handschriftlicher Nachtrag des Vorstands:

> *„Frau Selb hat ab Oktober eine neue Nummer. Bitte überall ändern!"*

---

## 3 · Arbeitsauftrag 1 — Die Liste sichten

*10 Minuten · Einzelarbeit am Rechner*

Öffnen Sie die Datei und sehen Sie sie in Ruhe durch. Notieren Sie, **was Ihnen auffällt.**
Stichworte genügen. Es gibt keine Musterlösung.

| Zeile(n) / Spalte | Was mir auffällt |
|---|---|
| | |
| | |
| | |
| | |
| | |
| | |

*Falls Sie hängen: Steht irgendetwas mehr als einmal da? Gibt es zwei Angaben, die nicht
zusammenpassen?*

---

## 4 · Arbeitsauftrag 2 — Zu zweit vergleichen

*12 Minuten · Partnerarbeit*

Vergleichen Sie Ihre Notizen. Ergänzen Sie, was Ihr Partner gefunden hat und Sie nicht.
Einigen Sie sich dann auf die **drei ärgerlichsten** Stellen — ärgerlich heißt: Wenn Sie
diesen Verein leiten müssten, würde Sie genau das aufhalten.

**Unser Fund 1:**

*Was geht dadurch kaputt?*

**Unser Fund 2:**

*Was geht dadurch kaputt?*

**Unser Fund 3:**

*Was geht dadurch kaputt?*

Wer von Ihnen beiden trägt vor?

---

## 5 · Gemeinsame Besprechung

Wir sammeln die Funde reihum. Jede genannte Stelle wird am Beamer **im Excel gelb markiert**
und im OneNote-Klassennotizbuch festgehalten.

Notieren Sie hier mit, was Sie selbst nicht gefunden hatten:

---

## 6 · Die drei Wörter

Ordnen Sie am Ende der Besprechung Ihre Funde zu. Ein Fund darf zu mehreren passen.

**Redundanz** — dieselbe Information steht mehrfach.

Mein Beispiel aus der Liste:

**Widerspruch** — zwei Angaben widersprechen sich, und niemand weiß, welche stimmt.

Mein Beispiel aus der Liste:

**Suchbarkeit** — die Antwort steckt in den Daten, ist aber nicht verlässlich herauszuholen.

Mein Beispiel aus der Liste:

---

## 7 · Zum Merken

> **Redundanz ist die Ursache. Widerspruch ist die Folge.**

Frau Selbs Telefonnummer steht sechsmal in dieser Liste. Genau deshalb kann eine davon falsch
sein. Stünde sie einmal da, gäbe es nichts zu widersprechen.

> **Eine Tabellenkalkulation kann Fehler finden. Eine Datenbank lässt sie nicht entstehen.**

Excel kann sortieren, filtern und ersetzen — darin ist es gut, und das bleibt so. Was es nicht
kann: eine Regel kennen. Tragen Sie als Beitrag `Kartoffelsalat` ein, nimmt Excel das klaglos
an. Eine Datenbank **kann** das ablehnen, weil in ihrem Schema steht, dass dort ein Betrag
hingehört.

*Kann* — nicht automatisch *tut*. Wie streng eine Datenbank ist, hängt davon ab, wie genau die
Regel beim Anlegen der Tabelle geschrieben wurde. Am **19.11.** machen Sie mit genau diesem
Kartoffelsalat die Probe aufs Exempel. Das Ergebnis wird Sie überraschen.

**Was ein Datenbanksystem gegen die drei Probleme setzt:**

| Problem | Antwort des Datenbanksystems |
|---|---|
| Redundanz | Jede Information steht an genau einer Stelle |
| Widerspruch | Regeln, die falsche Daten gar nicht erst zulassen |
| Suchbarkeit | Eine Abfragesprache: die Frage hinschreiben, das System sucht |
| Mehrere Nutzer | Gleichzeitiges Arbeiten, ohne sich gegenseitig zu überschreiben |
| Ausfall | Sicherung und Wiederherstellung |

---

## 8 · Z1 — Zusatzauftrag für Schnelle (freiwillig)

Zerlegen Sie die Liste in **mehrere** Tabellenblätter, sodass jede Information nur noch an
einer Stelle steht.

Skizzieren Sie: Welche Blätter brauchen Sie? Welche Spalten hat jedes? Und woran erkennt man,
welche Zeile aus Blatt A zu welcher Zeile aus Blatt B gehört?

*Wer das löst, hat vorweggenommen, was wir in den Stunden 08 bis 11 systematisch lernen.*

---

## 9 · Hausaufgabe

**Abgabe: mündlich zu Beginn von Stunde 02 am 24.09.2026.**

Finden Sie **drei Datenbanken** in Ihrem Alltag oder in Ihrem Betrieb. Gemeint sind keine
Datenbankprodukte, sondern Stellen, an denen erkennbar strukturiert Daten gespeichert werden:
die Kundenverwaltung in der Firma, die Bibliotheks-App, das Ticketsystem, die Lohnbuchhaltung,
die Trainings-App auf dem Handy.

Beschreiben Sie jede in **zwei Sätzen**:

1. Was wird dort gespeichert?
2. Was ginge schief, wenn es sie nicht gäbe — oder wenn stattdessen eine Excel-Liste wie die
   des TSV Grünwiese geführt würde?

**Datenbank 1:**

**Datenbank 2:**

**Datenbank 3:**

*Mindestens eine davon soll aus Ihrem eigenen Betrieb kommen.*
